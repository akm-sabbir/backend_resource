JAVAC = javac
JAVA = java
SOURCE_PARAM_1 = -sourcepath
SOURCE_PARAM_2 = dimensionOperation/
DES_PARAM_1 = -d
RUN_PARAM_1 = -cp
RUN_PARAM_2 = .:build:/**/*.class
RUN_MAIN = dimensionOperation.main_
DES_PARAM_2 = build/
SOURCE = dimensionOperation/*.java
SOURCE_C = build/dimensionOperation/*.class
PARAM =  $(SOURCE)

run:
	$(JAVAC) $(SOURCE_PARAM_1) $(SOURCE_PARAM_2) $(DES_PARAM_1) $(DES_PARAM_2) $(PARAM)
	$(JAVA) $(RUN_PARAM_1) $(RUN_PARAM_2) $(RUN_MAIN) 
clean:
	$(RM) $(SOURCE_C)
