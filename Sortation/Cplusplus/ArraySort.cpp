// Name: ArraySort.cpp
// Author : Matt Nitzken
// Description : Array based implementation of mergesort and quicksort

#include "stdafx.h"
#include <cstdlib>
#include <ctime>
#include <iostream>
#include "ArraySort.hpp"

using namespace std;

//ArraySort class constructor
ArraySort::ArraySort(){
	data = new int[dataSize];
	srand(time(0));

	for (int i = 0; i < dataSize; i++){
		data[i] = rand() % 100;
	}
}

//ArraySort class destructor
ArraySort::~ArraySort() {
	delete data;
}

//Function to scramble data stored in the array
void ArraySort::Scramble() {

	for (int i = 0; i < dataSize; i++){
		data[i] = rand() % 100;
	}

}

//Function to print the array
void ArraySort::PrintArray() {

	cout << "The array contains the following values" << endl;
	for (int i = 0; i < dataSize; i++) {
		cout << data[i] << " ";
	}
	cout << endl;
}

//Function to initialize MergeSort
void ArraySort::MergeSort() {

	MergeSortPrivate(data, dataSize);

}

//Function to perform a merge sort
void ArraySort::MergeSortPrivate(int* A, int sA){

	if (sA < 2) {
		return;
	}

	int mid = sA / 2;

	int* L = new int[mid];
	int* R = new int[sA - mid];

	for (int i = 0; i < mid; i++) {
		L[i] = A[i];
	}
	for (int i = mid; i < sA; i++) {
		R[i - mid] = A[i];
	}
	MergeSortPrivate(L, mid);
	MergeSortPrivate(R, sA - mid);
	Merge(L, R, A, mid, sA - mid, sA);

}

//Function to merge a left and right vector together
void ArraySort::Merge(int* L, int* R, int* A, int sL, int sR, int sA) {

	int i = 0, j = 0, k = 0;

	while (i < sL && j < sR) {

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
	while (i < sL) {
		A[k] = L[i];
		i++;
		k++;
	}
	while (j < sR) {
		A[k] = R[j];
		j++;
		k++;
	}
}

//Function to initialize a QuickSort
void ArraySort::QuickSort() {

	QuickSortPrivate(data, 0, dataSize-1);

}

//Function to perform a QuickSort
void ArraySort::QuickSortPrivate(int* A, int start, int end) {

	if (start < end) {
		int pIndex = Partition(A, start, end);
		QuickSortPrivate(A, start, pIndex - 1);
		QuickSortPrivate(A, pIndex + 1, end);
	}
}

//Function to partition an array
int ArraySort::Partition(int* A, int start, int end) {

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