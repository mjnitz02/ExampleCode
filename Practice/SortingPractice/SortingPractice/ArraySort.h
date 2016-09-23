#include "stdafx.h"

using namespace std;

#ifndef ARRAYSORT_H
#define ARRAYSORT_H

class ArraySort{

private:
	int dataSize = 20;
	int* data;

	void Merge(int* L, int* R, int* A, int sL, int sR, int sA);
	void MergeSortPrivate(int* A, int sA);

	int Partition(int* A, int start, int end);
	void QuickSortPrivate(int* A, int start, int end);

public:

	ArraySort();
	~ArraySort();
	void Scramble();

	void MergeSort();
	void QuickSort();
	void PrintArray();

};

#endif