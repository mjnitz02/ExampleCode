// Name: SortExamples.cpp
// Author : Matt Nitzken
// Description : Example of merge sort and quick sort implemented in C++.

#include "stdafx.h"
#include <iostream>
#include "ArraySort.hpp"
#include "VectorSort.hpp"

using namespace std;

int main()
{
	//Test of array sortation code
	cout << "Test of Array Code" << endl;
	ArraySort testArray;
	testArray.PrintArray();

	cout << "After merge sort" << endl;
	testArray.MergeSort();
	testArray.PrintArray();

	testArray.Scramble();
	testArray.PrintArray();

	cout << "After quick sort" << endl;
	testArray.QuickSort();
	testArray.PrintArray();

	//Test of vector sortation code
	cout << endl << "Test of Vector Code" << endl;
	VectorSort testVector;
	testVector.PrintArray();

	cout << "After merge sort" << endl;
	testVector.MergeSort();
	testVector.PrintArray();

	testVector.Scramble();
	testVector.PrintArray();

	cout << "After quick sort" << endl;
	testVector.QuickSort();
	testVector.PrintArray();

    return 0;
}

