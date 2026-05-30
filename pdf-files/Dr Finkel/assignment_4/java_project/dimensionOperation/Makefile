GS = -g
JC = javac
.SUFFIXES: .java .class
.java.class:
	        $(JC) $(JFLAGS) $*.java

		  CLASSES = \
			    base_dimension.java \
			    constant_.java \
			    distance_dimension.java \
			    main_.java\
			    pair.java\
			    weight_dimension.java\
			    time_dimension.java\
			    mixed_dimension.java
default: classes

classes: $(CLASSES:.java=.class)

clean:
	$(RM) *.class
