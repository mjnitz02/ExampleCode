#include "stdafx.h"

using namespace std;

#ifndef VECTORSORT_H
#define VECTORSORT_H

class VectorSort{

private:

	int dataSize = 20;
	vector < int > data;

	void Merge(vector<int>& L, vector<int>& R, vector<int>& A);
	void MergeSortPrivate(vector<int>& A);

	int Partition(vector<int>& A, int start, int end);
	void QuickSortPrivate(vector<int>& A, int start, int end);

public:
	VectorSort();
	~VectorSort();
	void Scramble();
	void PrintArray();

	void MergeSort();
	void QuickSort();
};

#endif