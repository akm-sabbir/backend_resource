(*this sorting algorithm has n^2 complexity*)
val le = fn (a,b) => a < b; (*this is integer comparator function*)
val strLe = fn (a:string,b) => a < b; (* this is string or char comparator*)
val rec insertion = fn (n, [],le) => [n] (*polymorphic recursive function tries to find out the appropriate position for a data with in the list*)
   | (n, ns as h::t,le) => if le(n , h) then n::ns else h::(insertion (n, t,le));
val rec insertionSort = fn (a,[],func) => a |(a,head::tail,func) => insertionSort(insertion(head,a,func),tail,func);(*recursively traverse the whole list provided to it*)