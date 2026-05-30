package dimensionOperation;

import java.util.ArrayList;
/*
 *  this class takes a string expression representing a fractional number and extract the integer representation
 *  of nominator and denominator.
 * it creates a constant object that represent fractional number.
 * it has one constructor to recieve the expression  
 * */
class constant_ extends base_dimension{
	
	public constant_(String expression){
		super();
		ArrayList<String> holder = splitUsingStringTokenizer(expression, "/");
		Integer  ob_1 = new Integer(holder.get(0));
		Integer  ob_2 = new Integer(holder.get(1));
		this.set_nominator(ob_1.intValue());
		this.set_denominator(ob_2.intValue());
	}
	
}