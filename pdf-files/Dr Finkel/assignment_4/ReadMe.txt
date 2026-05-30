this program written in smalltalk and java can represents fractional number with added dimension. all the arithmatic operation
and condtional operation is also appilcable to the created numbers. such as i can represents 2/3 distance/time and 4/5 distance/time and
perform fundamental arithmatic operation and conditional on these numbers. the programe design pattern in both smalltalk and java are same.
programe has one base class named base_dimension and four derived class from base such as time_dimension,distance_dimension,mass_dimension
and constant. Number can only be represented by constant object and then we can add dimension to numbers by decorating or encaptulating 
constant object with other object like time, distance and mass. so to represent velocity we have to follow the following syntax
this is pseudo syntax.
con = new Constant(2/3)
time = new Time(con,-1)
distance = new Distance(time,1)
velocity = base_dimension(distance)

in this way you can create any dimension that is possible by using time, distance and mass. 

just change directory to project directory and run Makefile using make command to get the sample output. 