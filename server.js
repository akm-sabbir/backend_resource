const express = require("express");
const fs = require("fs");
const path = require("path");
const cors = require("cors");

const app = express();
const PORT = 5000;
const PDF_FILE_DIR = "pdf-files"
// Folder containing PDFs
const FILE_DIR = path.join(process.cwd(), PDF_FILE_DIR);
// List of allowed domains
const allowedOrigins = [
  'http://localhost:3000',      // Your local dev environment
  'https://yourproduction.com', // Your live site
  'https://another-domain.com',
  'http://localhost:1234',
  'https://vercel.com'
];

const corsOptions = {
  origin: function (origin, callback) {
    // Check if origin is in the list or if it's a non-browser request (like Postman/Curl)
    if (!origin || allowedOrigins.includes(origin)) {
      callback(null, true);
    } else {
      callback(new Error('Not allowed by CORS'));
    }
  },
  optionsSuccessStatus: 200 // For legacy browser support
};

app.use(cors(corsOptions));

// Enable CORS for frontend
app.use(cors({
  origin: ['http://localhost:1234/*', 'http://127.0.0.1:1234/*', "*"] // Allow only your React app
}));
// Serve PDF files statically

app.get('/', (req, res) => {
  res.send('Backend is running!');
});

app.use("/files", express.static(FILE_DIR));
app.set('etag', false);

/*
  GET /api/files

  Returns:
  [
    {
      name: "sample1.pdf",
      url: "/files/sample1.pdf"
    }
  ]
*/
app.get("/api/files", async (req, res) => {
	 
  try {
	NEW_FILE_DIR = path.join(FILE_DIR, "general_files");
    const files = await fs.promises.readdir(NEW_FILE_DIR);

    const pdfFiles = files
      .filter((file) => file.toLowerCase().endsWith(".pdf"))
      .map((file) => ({
        name: file,
        url: `/files/${encodeURIComponent(file)}`
      }));
	res.set('Cache-Control', 'no-store');
    res.json(pdfFiles);
  } catch (error) {
    console.error(error);

    res.status(500).json({
      error: "Failed to read PDF directory"
    });
  }
});

/*
  GET /api/file/:name

  Optional endpoint if you want metadata
*/
app.get("/api/resources/files", async (req, res) => {
  try {
    const fileName = req.params.name;
    const { semester, course_name, file_name} = req.query;
    NEW_FILE_DIR = path.join(FILE_DIR, "general_files");
	 //const filePath = path.join(__dirname, 'pdf-files', fileName);
	 //const filePath = path.join(NEW_FILE_DIR, fileName);
	
    //const fullPath = path.join(FILE_DIR, fileName);
    const targetFilePath = path.join(FILE_DIR, semester.trim(), course_name.trim(), file_name.trim());

    // Security Check: Block directory traversal hacking attempts
    if (!targetFilePath.startsWith(FILE_DIR)) {
      return res.status(403).send('Access denied: Invalid directory layout path.');
    }

    if (!fs.existsSync(targetFilePath)) {
      return res.status(404).send('File not found on this server.');
    }

    const stats = await fs.promises.stat(targetFilePath);//await fs.promises.stat(filePath);

    /*res.json({
      name: fileName,
      size: stats.size,
      modified: stats.mtime,
      url: `/files/${encodeURIComponent(fileName)}`
    });*/
	
    //const fileBuffer = fs.readFileSync(filePath);
    //const base64Data = fileBuffer.toString('base64');
    console.log("Target File:, ", targetFilePath);
	res.set('Cache-Control', 'no-store');
    /*res.json({
        success: true,
        fileName: fileName,
        contentType: 'application/pdf',
        data: base64Data // The encoded file
    });*/
	res.setHeader('Content-Type', 'application/pdf');
	res.sendFile(targetFilePath);//filePath);
  } catch (error) {
    res.status(404).json({
      error: "File not found"
    });
  }
});

/**
 * GET Route optimized for Inline Browser Previews
 */
app.get('/api/resources/list', async (req, res) => {
  // 1. Unpack parameters from req.query (GET parameters) instead of req.body
  const { semester, course_name} = req.query;
    console.log("semester name and course name", semester.trim(), course_name.trim());
  if (!semester || !course_name) {
    return res.status(400).send('Missing required fields: semester, course_name, and file_name.');
  }

  try {
    const targetFilePath = path.join(FILE_DIR, semester.trim(), course_name.trim());

    // Security Check: Block directory traversal hacking attempts
    if (!targetFilePath.startsWith(FILE_DIR)) {
      return res.status(403).send('Access denied: Invalid directory layout path.');
    }

    if (!fs.existsSync(targetFilePath)) {
      return res.status(404).send('File not found on this server.');
    }

    // 2. OPTIMIZATION RULE: Force the browser to render the file "inline" in the window
    //res.setHeader('Content-Disposition', `inline; filename="${encodeURIComponent(file_name)}"`);
    const files = await fs.promises.readdir(targetFilePath);

    const pdfFiles = files.filter((file) => file.toLowerCase().endsWith(".pdf"))
      .map((file) => ({
        name: file,
        url: `/files/${encodeURIComponent(file)}`
      }));
	res.set('Cache-Control', 'no-store');
    res.json(pdfFiles);
    // 3. Stream the file asset. Express auto-configures Content-Type (e.g. application/pdf)
    //return res.sendFile(targetFilePath);

  } catch (error) {
        console.error('File retrieval crash:', error);
        return res.status(500).send('Internal server error.');
  }
});

app.use((req, res) => {
  res.status(404).json({ error: "Route not found" });
});

app.listen(5000, '0.0.0.0', () => {
  console.log('Server running on port 5000');
});


// Important: Vercel needs the app exported
module.exports = app; 
