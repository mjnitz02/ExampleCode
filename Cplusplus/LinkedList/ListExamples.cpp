// Name: ListExamples.cpp
// Author : Matt Nitzken
// Description : Example construction of a formal linked list implementation in C++.

//import externals
#include "stdafx.h"
#include "List.hpp"
#include <iostream>

using namespace std;

//Examples
int _tmain(int argc, _TCHAR* argv[])
{
	//Create a test list
	List TestList;

	//Fill list with information
	cout << "Original List" << endl;
	TestList.AddNode(0);
	TestList.AddNode(1);
	TestList.AddNode(2);
	TestList.AddNode(3);
	TestList.AddNode(4);
	TestList.PrintList();

	//Reverse the list
	cout << "Reversed List" << endl;
	TestList.ReverseList();
	TestList.PrintList();

	//Reverse the list recursively
	cout << "Reversed List (recursive)" << endl;
	TestList.ReverseListRecursive();
	TestList.PrintList();

	//Remove a middle element
	TestList.DeleteNode(2);
	TestList.PrintList();

	//Remove the list head
	TestList.DeleteNode(0);
	TestList.PrintList();

	//Remove the list tail
	TestList.DeleteNode(4);
	TestList.PrintList();

	return 0;
}