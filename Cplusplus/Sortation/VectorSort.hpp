// Name: VectorSort.hpp
// Author : Matt Nitzken
// Description : VectorSort class header

#pragma once
#include <vector>
#ifndef VECTORSORT_HPP
#define VECTORSORT_HPP

//VectorSort class
class VectorSort {

private:
	//Variables
	int dataSize = 20;
	std::vector < int > data;

	//Private functions
	void MergeSortPrivate(std::vector<int>& A);
	void Merge(std::vector<int>& L, std::vector<int>& R, std::vector<int>& A);
	void QuickSortPrivate(std::vector<int>& A, int start, int end);
	int Partition(std::vector<int>& A, int start, int end);

public:
	//Constructors
	VectorSort();

	//Destructors
	~VectorSort();

	//Public functions
	void Scramble();
	void PrintArray();
	void MergeSort();
	void QuickSort();
};
#endif