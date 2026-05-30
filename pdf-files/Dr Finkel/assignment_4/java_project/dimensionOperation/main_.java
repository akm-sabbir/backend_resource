/* main_ class is the starting point of the project and it contains single point of entry main function.
 * one can create fractional numbers with dimension by decorating constant type object with other dimensional
 * object. then perform arithmetic and conditional operations as all the arithmetic and coditional operators are
 * overloaded. 
 * */
package dimensionOperation;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.NoSuchElementException;
import java.util.Scanner;
import java.util.Stack;
import java.util.StringTokenizer;

class main_{
	
	public static void main(String[] args){
		
		try{
			base_dimension b_ob,b_ob_1;
			time_dimension t_ob,t_ob_1;
			distance_dimension d_ob,d_ob_1;
			constant_ c_ob,c_ob_1;
			c_ob = new constant_("2/3");
			t_ob = new time_dimension(c_ob,-1);
			d_ob = new distance_dimension(t_ob,1);
			b_ob = new base_dimension(d_ob);
			c_ob_1 = new constant_("4/3");
			t_ob_1 = new time_dimension(c_ob_1,-1);
			d_ob_1 = new distance_dimension(t_ob_1,1);
			b_ob_1 = new base_dimension(d_ob_1);
			//b_ob = b_ob.multiple(b_ob_1);
			b_ob.display_state();
			b_ob_1.display_state();
			System.out.println(b_ob.less(b_ob_1));
		}catch(NullPointerException ex){
			System.out.println("program is exiting as there is no input");
		}catch(NoSuchElementException ex){
			System.out.println("program is exiting as " + ex.getMessage());
		}
	}
}