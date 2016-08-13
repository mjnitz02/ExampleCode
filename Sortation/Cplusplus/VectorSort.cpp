// Name: VectorSort.cpp
// Author : Matt Nitzken
// Description : Vector based implementation of mergesort and quicksort

#include "stdafx.h"
#include <cstdlib>
#include <ctime>
#include <iostream>
#include <vector>
#include "VectorSort.hpp"

using namespace std;

//VectorSort class constructor
VectorSort::VectorSort() {
	srand((int)time(0));

	for (int i = 0; i < dataSize; i++) {
		data.push_back(rand() % 100);
	}
}

//VectorSort class destructor
VectorSort::~VectorSort() {
	data.clear();
}

//Function to scramble data stored in the array
void VectorSort::Scramble() {

	data.clear();
	for (int i = 0; i < dataSize; i++) {
		data.push_back(rand() % 100);
	}

}

//Function to print the array
void VectorSort::PrintArray() {
	cout << "The vector contains the following values" << endl;
	for (int i = 0; i < (int)data.size(); i++) {
		cout << data.at(i) << " ";
	}
	cout << endl;
}

//Function to initialize MergeSort
void VectorSort::MergeSort() {

	MergeSortPrivate(data);
}

//Function to perform a merge sort
void VectorSort::MergeSortPrivate(vector<int>& A) {

	if (A.size() < 2) {
		return;
	}

	int mid = A.size() / 2;

	vector<int> L;
	vector<int> R;

	for (int i = 0; i < mid; i++) {
		L.push_back(A[i]);
	}
	for (int i = mid; i < (int)A.size(); i++) {
		R.push_back(A[i]);
	}
	MergeSortPrivate(L);
	MergeSortPrivate(R);
	Merge(L, R, A);
}

//Function to merge a left and right vector together
void VectorSort::Merge(vector<int>& L, vector<int>& R, vector<int>& A) {
	int i = 0, j = 0, k = 0;

	while (i < (int)L.size() && j < (int)R.size()) {

		if (L[i] <= R[j]) {
			A[k] = L[i];
			i++;
		}
		else {
			A[k] = R[j];
			j++;
		}
		k++;
	}
	while (i < (int)L.size()) {
		A[k] = L[i];
		i++;
		k++;
	}
	while (j < (int)R.size()) {
		A[k] = R[j];
		j++;
		k++;
	}
}

//Function to initialize a QuickSort
void VectorSort::QuickSort() {

	QuickSortPrivate(data, 0, data.size() - 1);

}

//Function to perform a QuickSort
void VectorSort::QuickSortPrivate(vector<int>& A, int start, int end) {

	if (start < end) {
		int pIndex = Partition(A, start, end);
		QuickSortPrivate(A, start, pIndex - 1);
		QuickSortPrivate(A, pIndex + 1, end);
	}
}

//Function to partition an array
int VectorSort::Partition(vector<int>& A, int start, int end) {

	int pivot = A[end];
	int pIndex = start;

	for (int i = start; i < end; i++) {
		if (A[i] <= pivot) {
			swap(A[i], A[pIndex]);
			pIndex++;
		}
	}
	swap(A[pIndex], A[end]);
	return pIndex;
}