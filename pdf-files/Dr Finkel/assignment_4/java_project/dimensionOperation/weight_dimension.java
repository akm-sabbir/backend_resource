/* weight_dimension is a derived class and derived from base_dimension class and it represent distance dimension by encapsulating any other derived or base class object or constant class object 
 * it has two constructor one with one string type parameter and another one with two parameters, one is base_dimension type  and another one is integer type.
 * first parameter of of second constructor takes any object of base or derived type and second parameter determine the sign of the unit power */
package dimensionOperation;
import java.util.*;
import java.io.*;
import java.math.*;

public class weight_dimension extends base_dimension{
	public weight_dimension(String expression){
		//super(expression);
	}
	public weight_dimension(base_dimension ob,int dim_power){
		super(ob);
		this.mass += dim_power;
	}
	

}