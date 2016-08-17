// Name: ArraySort.hpp
// Author : Matt Nitzken
// Description : ArraySort class header

#pragma once
#ifndef ARRAYSORT_HPP
#define ARRAYSORT_HPP

//ArraySort class
class ArraySort{

private:
	//Variables
	int dataSize = 20;
	int* data;

	//Private functions
	void MergeSortPrivate(int* A, int sA);
	void Merge(int* L, int* R, int* A, int sL, int sR, int sA);
	void QuickSortPrivate(int* A, int start, int end);
	int Partition(int* A, int start, int end);

public:
	//Constructors
	ArraySort();

	//Destructors
	~ArraySort();

	//Public functions
	void Scramble();
	void PrintArray();
	void MergeSort();
	void QuickSort();
};
#endif