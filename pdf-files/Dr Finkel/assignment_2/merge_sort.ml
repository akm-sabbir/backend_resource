(*this algorithm has a nlogn complexity*)
datatype intstring = INT of int * intstring | STRING of string * intstring|INT2 of int | STRING2 of string
val le = fn (a,b) => a < b; (*int*int->bool comparator*)
val strLe = fn (a:string,b) => a < b;(*string comparator*)
val splitter = fn xs => let (*provided xs list it will split into two equal or almost equal size list*)
	val rec split = fn (x::[],ls,rs) => split([],x::ls,rs)| ([],ls,rs) => (ls,rs)|(x::y::zs,ls,rs) => split(zs,x::ls,y::rs);
in
		split(xs,[],[])
end;
val rec merge = fn (out,left as x::xl,right as y::yr,le) => if le(x ,y) then merge(x::out,xl,right,le) (*this function merges already sorted two lists recursively*)
	else merge(y::out,left,yr,le)|(out,x::xl,[],le) => merge(x::out,xl,[],le)| (out,[],y::yr,le) => merge(y::out,[],yr,le)
	|(out,[],[],le) => List.rev out;
val merge' = fn (l,r,le) => merge([],l,r,le); (*it just calls the merger*)
val merge_sort = fn (a,le) => let (*it takes a list and a comparator function then implement the merge sort algorithm, first split data then merge the sorted data recursively *)
	val rec ms = fn ([]) => [] |([x]) => [x] | (xs) => let
         val (left, right) = splitter xs (*splitter split it into left and right list and it will be called recursively until xs has one element*)
         in
           merge' (ms left, ms right,le)  (*merge is going to merge from top down, at top it will have at most 2 elements sorted*)
         end;
in
	 ms(a)
end;

val main = fn (a, func)  => let (*main function initiate the merge sort*)
	val l = merge_sort(a,func)(*(case (hd a) of INT2 y => merge_sort (a,le) | STRING2 z => merge_sort (a,strLe))*)
in
	l
end;