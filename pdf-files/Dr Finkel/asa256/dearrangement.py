#! usr/bin/env python
# grader: missing internal documentation. -0
#! -*- coding: utf-8 -*-
# Written by AKM Sabbir
def dearrangement(container,loc,element):
# grader: you never use the loc parameter.  -1
    if(len(container) == 1):
# grader: you don't need this special case. -0
        yield 'empty'

    if(element <= len(container)): # base condition 
        for locator in xrange(0,len(container)):
            if(locator + 1 == element or container[locator] == 1): # checking for valid position of a number 
                continue
            container[locator] = 1
            for elem in dearrangement(container,locator,element + 1): # iterator being called again
                    yield str(locator + 1)+' ' + elem
            container[locator] = 0 # reinitialize the container to unused value
    else:
        
        yield "" #return empty string
        
    return

def main_func():
    size_of_dearrangement = input('specify input size to get dearrangement or press 0 to exit : ') # input size
# grader: please limit lines to 80 characters.  -0
    while(size_of_dearrangement > 0):
        element_container = [0]*size_of_dearrangement # track the position of numbers which have already been placed
        for each in dearrangement(element_container,size_of_dearrangement,1): # call the iterator
            if(each.find('empty') != -1):
                print('empty output')
                break
            print(each)
        size_of_dearrangement = input('specify input size to get dearrangement or press 0 to exit : ') # input size
# grader: duplicate code. -1
    return
main_func()
