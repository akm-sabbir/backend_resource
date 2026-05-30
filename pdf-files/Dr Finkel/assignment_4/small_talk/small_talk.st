"written by AKM Sabbir dimension based fractional number presentation"
"following is the base class contains all the necessary dimension related variable and also nominator and denominator variable to represent fractional number"
"it has member function for gcd and lcm calculation and it also overloaded all the arithmatic and conditional operators"
"it also has type checking function that checks the compatibility of type between two objects"
"it has type normalization function that is used to normalize the dimension type after multiplication and dividing operation"
"it has display state function that can display state of all variables defined in this class"
"it has getter function for time,distance,mass, nom and denom instance variable"
Object subclass: #Base_dimension .
Base_dimension instanceVariableNames: 'nom denom time distance mass' .
Base_dimension comment: 'i repsresent base dimension' .

Base_dimension extend [

	init  [			
		time := 0 .
		mass := 0 .
		distance := 0 .
	]
	init: named_object [
		nom := named_object get_constant_nom .
		denom := named_object get_constant_denom .
		self class ~= Base_dimension
		ifTrue: [
			distance := (self get_distance) + named_object get_distance .
			time := (self get_time ) + named_object get_time .
			mass := (self get_mass) + named_object get_mass .		
		] 
		ifFalse: [
			distance := named_object get_distance .
			time := named_object get_time .
			mass :=  named_object get_mass .		
		]
		
	]
	get_gcd: divide and: dividor [
		dividor ~= 0
		ifTrue: [^(self get_gcd: dividor and: (divide \\ dividor)) .] 
		ifFalse: [^divide .]
	]
	get_lcm: num_1 and: num_2 [
		|mul gcd|
			mul := num_1*num_2 .
			num_1 > num_2			
			ifTrue: [gcd := self get_gcd: num_1 and: num_2 .]
			ifFalse: [gcd := self get_gcd: num_2 and: num_1 .] .
			^ (mul // gcd) .
	]
	type_consistency_check: object_to [
		|set|
		set := 1 .
		(self get_time) = (object_to get_time)
		ifFalse: [set := 0] .
		(self get_distance) = (object_to get_distance)
		ifFalse: [set := 0] .
		(self get_mass) = (object_to get_mass)
		ifFalse: [set := 0] .
		
		^set .
	]
	+ second_ob [
		|temp_var_1 temp_var_2 temp_var_3 temp|
		(self type_consistency_check: second_ob) = 1
		ifTrue:[
			'sum of unit 1 and unit 2' printNl .
			temp_var_1 := self get_lcm: ((self get_constant_denom) abs) and: ((second_ob get_constant_denom) abs) .
			temp_var_2 := (self get_constant_nom) * (temp_var_1 // (self get_constant_denom)) .
			temp_var_3 := (second_ob get_constant_nom) * (temp_var_1 // (second_ob get_constant_denom)) .
			temp_var_2 := temp_var_2 + temp_var_3 .
			(temp_var_2 abs)> (temp_var_1 abs)
			ifTrue: [ temp_var_3 := self get_gcd: (temp_var_2 abs) and: (temp_var_1 abs) ]
			ifFalse: [ temp_var_3 := self get_gcd: (temp_var_1 abs) and: (temp_var_2 abs) ] .
			nom := temp_var_2 // temp_var_3 .
			denom := temp_var_1 // temp_var_3 .
		]
		ifFalse: [self error: 'in compatible data cannot add'] .
		
		^self .
	]
	- second_ob [
		|temp_var_1 temp_var_2 temp_var_3 temp|

		(self type_consistency_check: second_ob) = 1
		ifTrue:[
			temp_var_1 := self get_lcm: ((self get_constant_denom) abs) and: ((second_ob get_constant_denom) abs) .
			temp_var_2 := (self get_constant_nom) * (temp_var_1 // (self get_constant_denom)) .
			temp_var_3 := (second_ob get_constant_nom) * (temp_var_1 // (second_ob get_constant_denom)) .
			temp_var_2 := temp_var_2 - temp_var_3 .
			temp := temp_var_2 .
			(temp_var_2 abs)> (temp_var_1 abs)
			ifTrue: [ temp_var_3 := self get_gcd: (temp_var_2 abs)and: (temp_var_1 abs) ]
			ifFalse: [ temp_var_3 := self get_gcd: (temp_var_1 abs) and: (temp_var_2 abs)] .
			nom := temp // temp_var_3 .
			denom := temp_var_1 // temp_var_3 .
		
		]
		ifFalse: [self error: 'in compatible data cannot add'] .
		
		^self .
	]
	* second_ob [
		|temp_var_1 temp_var_2 temp_var_3|
			'multiplication of unit 1 and unit 2' printNl .
			temp_var_1 := (self get_constant_nom) * (second_ob get_constant_nom) .
			temp_var_2 := (self get_constant_denom) * (second_ob get_constant_denom) .
			(temp_var_2 abs) > (temp_var_1 abs)
			ifTrue: [ temp_var_3 := self get_gcd: (temp_var_2 abs)and: (temp_var_1 abs)]
			ifFalse: [ temp_var_3 := self get_gcd: (temp_var_1 abs) and: (temp_var_2 abs) ] .
			nom := temp_var_1 // temp_var_3 .
			denom := temp_var_2 // temp_var_3 .
			self type_normalization: second_ob and: 0 .
		^self .
	]
	// second_ob [
		|temp_var_1 temp_var_2 temp_var_3|
			'dividation of unit 1 and unit 2' printNl .
			temp_var_1 := (self get_constant_nom) * (second_ob get_constant_denom) .
			temp_var_2 := (self get_constant_nom) * (second_ob get_constant_denom) .
			(temp_var_2 abs) > (temp_var_1 abs)
			ifTrue: [ temp_var_3 := self get_gcd: (temp_var_2 abs) and: (temp_var_1 abs) ]
			ifFalse: [ temp_var_3 := self get_gcd: (temp_var_1 abs) and: (temp_var_2 abs) ] .
			nom := temp_var_1 // temp_var_3 .
			denom := temp_var_2 // temp_var_3 .
			self type_normalization: second_ob and: 1 .
		^self .
	]
	> second_ob [

		|temp_var_1 temp_var_2 base |
		(self type_consistency_check: second_ob) = 1
		ifTrue:[
			'Is unit 1 > unit 2' printNl .
			base := self - second_ob .
			(base get_constant_nom) > 0
			ifTrue: ['True' printNl .]
			ifFalse: ['False' printNl .] .
		]
		ifFalse: [self error: 'type inconsistency cannot compare.' .] .
	]
	< second_ob [

		|temp_var_1 temp_var_2 base |
		(self type_consistency_check: second_ob) = 1
		ifTrue:[
			'Is unit 1 < unit 2' printNl .
			base := self - second_ob .
			(base get_constant_nom) < 0
			ifTrue: ['True' printNl .]
			ifFalse: ['False' printNl .] .
		]
		ifFalse: [self error: 'type inconsistency cannot compare.' .] .
	]
	>= second_ob [

		|temp_var_1 temp_var_2 base |
				
		(self type_consistency_check: second_ob) = 1
		ifTrue:[
			'Is unit 1 >= unit 2' printNl .
			base := self - second_ob .
			(base get_constant_nom) >= 0
			ifTrue: ['True' printNl .]
			ifFalse: ['False' printNl .] .
		]
		ifFalse: [self error: 'type inconsistency cannot compare.' .] .
	]
	<= second_ob [

		|temp_var_1 temp_var_2 base |
		(self type_consistency_check: second_ob) = 1
		ifTrue:[
			'Is unit 1 <= unit 2' printNl .
			base := self - second_ob .
			(base get_constant_nom) <= 0
			ifTrue: ['True' printNl .]
			ifFalse: ['False' printNl .] .
		]
		ifFalse: [self error: 'type inconsistency cannot compare.' .] .
	]
	~= second_ob [

		|temp_var_1 temp_var_2 base |
		(self type_consistency_check: second_ob) = 1
		ifTrue:[
			'Is unit 1 ~= unit 2' printNl .			
			base := self - second_ob .
			(base get_constant_nom) ~= 0
			ifTrue: ['True' printNl .]
			ifFalse: ['False' printNl .] .
		]
		ifFalse: [self error: 'type inconsistency cannot compare.' .] .
	]
	= second_ob [

		|temp_var_1 temp_var_2 base |
		(self type_consistency_check: second_ob) = 1
		ifTrue:[
			'Is unit 1 = unit 2' printNl .
			base := self - second_ob .
			(base get_constant_nom) = 0
			ifTrue: ['True' printNl .]
			ifFalse: ['False' printNl .] .
		]
		ifFalse: [self error: 'type inconsistency cannot compare.' .] .
	]

	type_normalization: type_op and: var [
		
		var = 1 
		ifTrue: [
			time := (self get_time) - (type_op get_time) .
			distance := (self get_distance) - (type_op get_distance) .
			mass := (self get_mass) - (type_op get_mass) .	
		] 
		ifFalse: [
			time := (self get_time) + (type_op get_time) .
			distance := (self get_distance) + (type_op get_distance) .
			mass := (self get_mass) + (type_op get_mass) .
		]
	]
	get_constant_nom [
		^nom .
	]
	get_constant_denom [
		^denom .
	]
	get_time [
		^time .
	]
	get_distance [
		^distance .
		]
	get_mass [
		^mass .
	]
	display_state [
		self get_constant_nom print .
		'/' print .
		self get_constant_denom print .
	
		(self get_time) ~= 0
		ifTrue: ['t^' print .
			 (self get_time) print .				
			] .
		(self get_distance) ~= 0
		ifTrue: ['d^' print .
			(self get_distance) print .] .
		(self get_mass) ~= 0 
		ifTrue: ['m^' print .
			(self get_mass) printNl .] .
		'' printNl .
	]

]
"Time is a derived class derived from Base_dimension class and it represent time dimension by encapsulating any other derived or base class object or constant class object "
"it has two overloaded init function one with zero parameter and one with two parameters"
"first parameter of init takes any object of base or derived type and second parameter determine the sign of the unit power"
Base_dimension subclass: #Times .
Time instanceVariableNames: '' .
Time comment: 'i represent time dimension' .

Times extend [
	init  [
				
	]
	init: message and: T [
		super init .
		nom := message get_constant_nom .
		denom := message get_constant_denom .
		time := time + T .
		super init: message .
	]
	
] 
"Distance is a derived class derived from Base_dimension class and it represent distance dimension by encapsulating any other derived or base class object or constant class object "
"it has two overloaded init function one with zero parameter and one with two parameters"
"first parameter of init takes any object of base or derived type and second parameter determine the sign of the unit power"
Base_dimension subclass: #Distance .
Distance instanceVariableNames: '' .
Distance comment: 'i represent the distance dimension' .
Distance extend [
	init: message and: temp [
		super init .
		nom := message get_constant_nom .
		denom := message get_constant_denom .
		distance := distance + temp .
		super init: message .		
	]

]
"Mass is a derived class derived from Base_dimension class and it represent mass dimension by encapsulating any other derived or base class object or constant class object "
"it has two overloaded init function one with zero parameter and one with two parameters"
"first parameter of init takes any object of base or derived type and second parameter determine the sign of the unit power"
Base_dimension subclass: #Mass .
Mass instanceVariableNames: '' .
Mass comment: 'i represent the mass dimension' . 
Mass extend [
	init: message and: T [
		super init .
		nom := message get_constant_nom .
		denom := message get_constant_denom .
		mass := mass + T .
		super init: message .
	]
]
"Constant is a derived class derived from Base_dimension class and it represent constant numbers in fractional object form "
"it has init function with two parameters"
"two parameters are the number represents nominator and denominator of fractional number"
Base_dimension subclass: #Constant .
Constant instanceVariableNames: '' .
Constant comment: 'i represent the constant' .
Constant extend [
	init: nom_p and: denom_p[
		nom := nom_p .
		denom := denom_p .
		super init .
				
	]	
]
"Testing section"
| miles times dis cons|
	cons := (Constant new ) init: 2 and: 3 .
	dis := ( Distance new ) init: cons and: 1 .
	times := (Times new) init: dis and: -1 .
	miles := (Base_dimension new) init: times .
| miles1 times1 dis1 cons1|
	cons1 := (Constant new ) init: 4 and: 3 .
	dis1 := ( Distance new ) init: cons1 and: 1 .
	times1 := (Times new) init: dis1 and: -1 .
	miles1 := (Base_dimension new) init: times1 .
	miles display_state .
	miles1 display_state .
	miles <= miles1 .