// StackPractice.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include "stack.h"


int _tmain(int argc, _TCHAR* argv[])
{

	Stack myStack;

	myStack.Print();
	myStack.Push("Tom", 1);
	myStack.Push("John", 156);
	myStack.Push("Fred", 2011);
	myStack.Push("Matt", 1987);
	myStack.Print();
	myStack.Pop();
	myStack.Pop();
	myStack.Print();


	return 0;
}

