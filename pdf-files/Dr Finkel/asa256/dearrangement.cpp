#include<stdio.h>
// grader: I removed your old swap files.
// grader: It's customary to put a space before < in this context. -0
#include<stdlib.h>
#include<string.h>
#define MAX 150 // macro for defining array size 
// number to string conversion function
char* string_generator(int number){
// grader: why not just uses sprintf? -1
	char *container = new char[10];
// grader: 10 is a magic number. -1
	int index = 0;
	while(number){
		int temp = number % 10;
		number = number/10;
		container[index++] = temp + 48;
	}
	container[index] = '\0';
	for(int i = 0 ; i < index/2; i += 1){
		char temp = container[i];
		container[i] = container[index - 1 - i];
		container[index - 1 - i ] = temp;
	}
	return container;
}
/*
  Label_1:
  	For Array[column] in 0............n-1 do
		execute body of loop
		if( Array[column]  == OK)
			store current state of all variables
			goto Label_1
		else
			print output
  Label_2:
  			restore all varaible to get back to previous stage of power loop
// grader: spelling: variables  -0
			goto Label_1
	
	if(depth != 1)
		goto Label_2 to restart previous stage of power loop
	else
		return
 */
void start_generating_dearrangements(int n,int element){
// grader: n, i, j are non-mnemonic identifiers. -1
// grader: spelling: derangements  -0
	
	int locator;     // this varibale will track the position of each number placed in used_position container array
// grader: spelling: variable.  -1
	int used_position[n+1]; // array will track the number of unused position
	int deeper[MAX]; // this array will locate the next position where a number can be possibly placed
	int arrS[MAX]; // this array will contain the actual output that is elements in their respective position
	int tracker[MAX][MAX]; //this is for clearing the previously used position for a number because a number can only occupy one position
// grader: that's a space-expensive method.  -1
	int depth = 1; // this is to track the current depth of the function call
 	if(n == 1 || n== 0){ // if input size is either 1 or 0 there will be no possible output
// grader: you don't need these special cases. -1
		printf("there is no possible output\n");
		return;
	}
	//variable initializations from line 33 to 42
	for(int j = 1 ; j <= n; j++){
		used_position[j] = 0;
		deeper[j] = 1;
		arrS[j] = 0;
	}
	for (int j = 1 ; j <= n; j++)
		for (int k = 1 ; k <=n; k++)
			tracker[j][k] = 0;
label:
	locator = deeper[depth]; // a depth is equivalent to element 
	for (int j = 1; j < locator; j++){ // clearing the previously used position for a number/element 
		if(tracker[element][j] == 1 )
			used_position[j] = 0; 
			tracker[element][j] = 0;
	}
		
	for(; locator <= n ;locator += 1){ // iterate over the possible location
		if(used_position[locator] == 0 && locator != element){ // check the condition for a valid position in an array for a number
			used_position[locator] = 1; // if its valid consumed the space
			arrS[locator] = element; // initialize the output container with the element
			tracker[element][locator] = 1; //this will track all the consumed space for a specific element
			if(element < n){ //if element size is smalled than input size then go deeper
// grader: spelling: smaller.  -0
				element += 1;
				deeper[depth] = locator + 1;
				depth += 1;
				goto label;
			}
			else{
				for(int j = 1 ; j <= n ; j++) // print the output when all the space is consumed
					printf("%d ",arrS[j]);
				printf("\n");
label2: // label2 simulate calling back to previous stage of function call
				// restore the various variable value before goto the previous stage of the function
				int set = 1;
				//following for loop tracks whether the current locator value points to current element or not.
				for (int k = 1 ; k < element ; k++){
					if(arrS[locator] == k)	
						set = 0;
				}
				// if current locator contains current/latest element then used_position for current location will be 0
				if(set)
					used_position[locator] = 0;
				deeper[depth] = 1;
				element -= 1;
				depth -= 1;
				goto label;
			}
		}
	}
	// continue to iterate until reach to the initial stage of function call
	if(depth != 1){
		locator -= 1;
		goto label2;
	}
			//arr[locator] = 0;
		
	return;
}
int  main(){
	int input;    // input size 
	printf("press any number (better to have small number) or press ctrl+z to exit\n");
// grader: you mean "enter any number".  -0
// grader: ^Z is not the universal (or even typical) interrupt character. -1
	while(scanf("%d",&input) != EOF){
		
		start_generating_dearrangements(input,1); // function responsible for generating the dearrangement
		printf("press any number (better to have small number) or press ctrl+z to exit\n");
	}

	return -1;
// grader: -1 means "an error has occurred".  Use 0.  -1
}
// grader: no pseudo-code using power loops.  -5
