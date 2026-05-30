/*
 * 	following is the base class contains all the necessary dimension related variable and also nominator, denominator variable to represent fractional number
 * it has member function for gcd and lcm calculation and it also overloaded all the arithmatic and conditional operators
 * it also has type checking function that checks the compatibility of type between two objects
 * it has type normalization function that is used to normalize the dimension type after multiplication and dividing operation
 * it has display state function that can display state of all variables defined in this class
 * it has getter function for time,distance,mass, nom and denom instance variable
 * it also has setter function for all instance variable
 * this class also has a string splitter function that uses stringtokenizer to split a given expression for a given delimiter this.
 * this class also has oveloaded implementation of arithmetic operations and conditional operations.
 * * */
package dimensionOperation;
import java.util.*;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.lang.*;

import javax.lang.model.type.NoType;

import org.omg.IOP.CodecPackage.TypeMismatch;
public class base_dimension{
	
	protected int nominator;
	protected int denominator;
	protected int nominator_name;
	protected int time;
	protected int distance;
	protected int mass;
	protected String unit_name;
	protected HashMap<String, ArrayList<pair>> hash_unit_mapper;
	public base_dimension(){
		this.nominator = 0;
		this.denominator = 0;
		this.mass = 0;
		this.time = 0;
		this.distance = 0;
	}
	public base_dimension(base_dimension ob){
		this.nominator = ob.get_nominator();
		this.denominator  = ob.get_denominator();
		if(!(ob instanceof base_dimension)) {
			this.time = this.get_time() + ob.get_time();
			this.mass = this.get_mass() + ob.get_mass();
			this.distance = this.get_distance() + ob.get_distance();
		}else{
			this.time = ob.get_time();
			this.mass =  ob.get_mass();
			this.distance = ob.get_distance();
		}
	}
	public int get_time(){
		
		return time;
	}
	public int get_distance(){
		return distance;
	}
	public int get_mass(){
		return mass;
	}
	public int get_nominator(){
		return nominator;
	}
	public int get_denominator(){
		return denominator;
	}
	public void set_nominator(int val){
		this.nominator = val;
	}
	public void set_denominator(int denominator){
		this.denominator = denominator;
	}
	public int get_gcd(int divide,int dividend){
		if(dividend != 0)
			return get_gcd(dividend, divide % dividend);
		else return divide ;	
	}
	public int get_lcm(int number_1,int number_2){
		
		int gcd_result = 1;
		if(number_1 > number_2)
			get_gcd(number_1, number_2);
		else
			get_gcd(number_2, number_1);
			
		return (number_1*number_2)/gcd_result;
	}
	public base_dimension add(base_dimension number_2){
		
		if(compare_dimension(number_2)== true)
		{
			System.out.println("addition of number_1 with number_2");
			int lcm = get_lcm(Math.abs(this.denominator),Math.abs(number_2.denominator));
			
			int num_1 = lcm/this.denominator;
			int num_2 = lcm/number_2.denominator;
			int result_nom = this.nominator*num_1 + number_2.nominator*num_2;
			int gcd = 1;
			if(Math.abs(result_nom )> Math.abs(lcm))
				gcd = get_gcd(Math.abs(result_nom),Math.abs(lcm));
			else gcd = get_gcd (Math.abs(lcm),Math.abs(result_nom));
			result_nom = result_nom/gcd;
			lcm = lcm/gcd;
			this.set_nominator(result_nom);
			this.set_denominator(lcm);
			//return result_nom +"/" + lcm + " " + this.nominator_name +"/"+this.denominator_name;
		}else{
			System.out.println("type mismatch error cannot add");
		}
	
		return this;
		//return "dimension mismatch error";
	}
	public base_dimension subtraction(base_dimension number_2){
		
		if(compare_dimension(number_2)== true)
		{
			System.out.println("Subtracting number_2 from number_1");
			int lcm = get_lcm(Math.abs(this.denominator),Math.abs(number_2.denominator));
			
			int num_1 = lcm/this.denominator;
			int num_2 = lcm/number_2.denominator;
			int result_nom = this.nominator*num_1 - number_2.nominator*num_2;
			int gcd = 1;
			if(Math.abs(result_nom) > Math.abs(lcm))
				gcd = get_gcd(Math.abs(result_nom),Math.abs(lcm));
			else gcd = get_gcd(Math.abs(lcm),Math.abs(result_nom));
			result_nom = result_nom/gcd;
			lcm = lcm/gcd;
			this.set_nominator(result_nom);
			this.set_denominator(lcm);
		}
		else{
			System.out.println("Type mismatch error cannot perform operation");
		}
		//return "dimension mismatch error";
		return this;
	}
	public base_dimension divide(base_dimension number_2){
		System.out.println("dividing number_1 by number_2");
		int num_1 = this.nominator * number_2.denominator;
		int num_2 = this.denominator* number_2.nominator;
		int gcd = 1;
		if(num_1 > num_2)
			gcd = get_gcd(num_1,num_2);
		else
			gcd = get_gcd(num_2,num_1);
		num_1 = num_1/gcd;
		num_2 = num_2/gcd;
		this.set_denominator(num_2);
		this.set_nominator(num_1);
		normalize_dimension(number_2,1);
		
		return this;
	}
	public base_dimension multiple(base_dimension number_2){
		System.out.println("multipling number_1 by number_2");
		int num_1 = this.nominator * number_2.nominator;
		int num_2 = this.denominator* number_2.denominator;
		int gcd = 1;
		if(Math.abs(num_1) > Math.abs(num_2))
			gcd = get_gcd(Math.abs(num_1),Math.abs(num_2));
		else
			gcd = get_gcd(Math.abs(num_2),Math.abs(num_1));
		num_1 = num_1/gcd;
		num_2 = num_2/gcd;
		this.set_nominator(num_1);
		this.set_denominator(num_2);
		normalize_dimension(number_2,-1);
		return this;
		//return (new Integer(num_1)).toString()+"/"+ (new Integer(num_2)).toString() + " "+ units_name;
	}
	public int get_subtracted_value(base_dimension target_object){
		int lcm = get_lcm(Math.abs(this.denominator),Math.abs(target_object.denominator));
		
		int num_1 = lcm/this.denominator;
		int num_2 = lcm/target_object.denominator;
		return this.nominator*num_1 - target_object.nominator*num_2;
	}
	public String greater(base_dimension tar_ob){
		if(compare_dimension(tar_ob) ==true){
			System.out.println("Is number_1 is greater than number_2");
			if(get_subtracted_value(tar_ob) > 0)
				return "True";
			else
				return "False";
					
		}
		return "type mismatch cannot compare";
	}
	public String greaterequal(base_dimension tar_ob){
		if(compare_dimension(tar_ob) ==true){
			System.out.println("Is number_1 is greater than or equal number_2");
			if(get_subtracted_value(tar_ob) >= 0)
				return "True";
			else
				return "False";
					
		}
		return "type mismatch cannot compare";
	}
	public String less(base_dimension tar_ob){
		
		if(compare_dimension(tar_ob) ==true){
			System.out.println("Is number_1 is less than number_2");
			if(get_subtracted_value(tar_ob) < 0)
				return "True";
			else
				return "False";
					
		}
		return "type mismatch cannot compare";
	}
	public String lessequal(base_dimension tar_ob){
		if(compare_dimension(tar_ob) ==true){
			System.out.println("Is number_1 is less than or equal number_2");
			if(get_subtracted_value(tar_ob) <= 0)
				return "True";
			else
				return "False";
					
		}
		return "type mismatch cannot compare";
	}
	public String notequal(base_dimension tar_ob){
		if(compare_dimension(tar_ob) ==true){
			System.out.println("Is number_1 is not equal number_2");
			if(get_subtracted_value(tar_ob) != 0)
				return "True";
			else
				return "False";
					
		}
		return "type mismatch cannot compare";
	}
	public String equal(base_dimension tar_ob){
		if(compare_dimension(tar_ob) ==true){
			System.out.println("Is number_1 is equal number_2");
			if(get_subtracted_value(tar_ob) == 0)
				return "True";
			else
				return "False";
					
		}
		return "type mismatch cannot compare";
	}
	public String get_normalized_result(String source_data){
		String result = null;
		return result;
	}
	public int get_max(int elem_1,int elem_2){
		return elem_1 > elem_2 ? elem_1 : elem_2;
	}
	public void normalize_dimension(base_dimension object,int type){
		
		if(type == 1){
			this.time = this.get_time() - object.get_time();
			this.distance = this.get_distance() - object.get_distance();
			this.mass = this.get_mass() - object.get_mass();
		}else{
			this.time = this.get_time() - object.get_time();
			this.distance = this.get_distance() - object.get_distance();
			this.mass = this.get_mass() - object.get_mass();
		}
	}
	

	public boolean compare_dimension(base_dimension object){
		boolean set = true;
		if(this.get_time() != object.get_time())
			set = false;
		if(this.get_distance() != object.get_distance())
			set = false;
		if(this.get_mass() != object.get_mass())
			set = false;
		return set;
	}
	public void display_state(){
		int set = 0;
		System.out.print(this.nominator +"/" + this.denominator+" ");
		if(this.time != 0){
			if(set == 1)
				System.out.print("*");
			set = 1;
			System.out.print("time^" + this.time );
		}
		if(this.mass != 0){
			if(set == 1)
				System.out.print("*");
			set = 1;
			System.out.print( "mass^" + this.mass);
		}
		if(this.distance != 0){
			if(set == 1)
				System.out.print("*");
			set = 1;
			System.out.println("distance^" + this.distance );
		}
	}
	public ArrayList<String> splitUsingStringTokenizer(String data,String delimiter){
		StringTokenizer st = new StringTokenizer(data,delimiter);
		ArrayList<String> result = new ArrayList<String>();
		while(st.hasMoreTokens())
			result.add(st.nextToken());
		return result;
	}
	//////////no longer useful in this project
	public void add_new_dimension(String source,String des,int scale){
		ArrayList<pair> arrL = null;
		if(hash_unit_mapper.containsKey(source) ==false)
			arrL = new ArrayList<pair>();
		else
			arrL = hash_unit_mapper.get(source);
		arrL.add(new pair(des,new Integer(scale)));
		if(arrL.equals(null) == false)
			hash_unit_mapper.put(source,arrL);
			
	}
	////////////////// conditional greater operator////////////////////////
	/////////no longer useful in this project //////////////////////
	public int math_operation_check(base_dimension number_2){
		int lcm = get_lcm(this.denominator,number_2.denominator);
		int num_1 = lcm/this.denominator;
		int num_2 = lcm/number_2.denominator;
		int result_nom = this.nominator*num_1 - number_2.denominator*num_2;
		return result_nom;
		
	}
	
	//////////////////////////////////////////////////////////////////


	
}