package dimensionOperation;

public class pair {
	public Object a;
	public Object b;
	public pair(){
		this.a = new Integer(0);
		this.b = new Integer(0);
	}
	public pair(Object object_1,Object object_2){
		this.a = object_1;
		this.b = object_2;
	}
	public Object get_object(int index){
		if(index == 0)
			return this.a;
		else
			return this.b;
	}
	public void set_object(Object data,int index){
		if(index == 0)
			this.a = data;
		else
			this.b = data;
	}
}

