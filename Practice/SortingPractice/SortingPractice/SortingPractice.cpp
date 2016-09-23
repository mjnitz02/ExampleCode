// SortingPractice.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include "ArraySort.h"
#include "VectorSort.h"

using namespace std;


int _tmain(int argc, _TCHAR* argv[])
{

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