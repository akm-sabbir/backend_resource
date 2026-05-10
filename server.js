const express = require("express");
const fs = require("fs");
const path = require("path");
const cors = require("cors");

const app = express();
const PORT = 5000;
const PDF_FILE_DIR = "pdf-files"
// Folder containing PDFs
const FILE_DIR = path.join(__dirname, PDF_FILE_DIR);
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
	  
    const files = await fs.promises.readdir(FILE_DIR);

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
app.get("/api/files/:name", async (req, res) => {
  try {
    const fileName = req.params.name;
	 //const filePath = path.join(__dirname, 'pdf-files', fileName);
	 const filePath = path.join(FILE_DIR, fileName);
	
    //const fullPath = path.join(FILE_DIR, fileName);

    const stats = await fs.promises.stat(filePath);

    /*res.json({
      name: fileName,
      size: stats.size,
      modified: stats.mtime,
      url: `/files/${encodeURIComponent(fileName)}`
    });*/
	
    //const fileBuffer = fs.readFileSync(filePath);
    //const base64Data = fileBuffer.toString('base64');
	res.set('Cache-Control', 'no-store');
    /*res.json({
        success: true,
        fileName: fileName,
        contentType: 'application/pdf',
        data: base64Data // The encoded file
    });*/
	res.setHeader('Content-Type', 'application/pdf');
	res.sendFile(filePath);
  } catch (error) {
    res.status(404).json({
      error: "File not found"
    });
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
