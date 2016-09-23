#include "stdafx.h"
#include "VectorSort.h"

using namespace std;

VectorSort::VectorSort(){

	srand(time(0));

	for (int i = 0; i < dataSize; i++){
		data.push_back(rand() % 100);
	}
}

VectorSort::~VectorSort(){

	data.clear();
}

void VectorSort::Scramble() {

	data.clear();
	for (int i = 0; i < dataSize; i++){
		data.push_back(rand() % 100);
	}

}


void VectorSort::PrintArray() {
	cout << "The vector contains the following values" << endl;
	for (int i = 0; i < data.size(); i++) {
		cout << data.at(i) << " ";
	}
	cout << endl;
}

void VectorSort::Merge(vector<int>& L, vector<int>& R, vector<int>& A){

	int i = 0, j = 0, k = 0;

	while (i < L.size() && j < R.size()) {

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
	while (i < L.size()) {
		A[k] = L[i];
		i++;
		k++;
	}
	while (j < R.size()) {
		A[k] = R[j];
		j++;
		k++;
	}
}

void VectorSort::MergeSortPrivate(vector<int>& A){

	if (A.size() < 2) {
		return;
	}

	int mid = A.size() / 2;

	vector<int> L;
	vector<int> R;

	for (int i = 0; i < mid; i++) {
		L.push_back(A[i]);
	}
	for (int i = mid; i < A.size(); i++) {
		R.push_back(A[i]);
	}
	MergeSortPrivate(L);
	MergeSortPrivate(R);
	Merge(L, R, A);
}

void VectorSort::MergeSort() {

	MergeSortPrivate(data);
}

int VectorSort::Partition(vector<int>& A, int start, int end){

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

void VectorSort::QuickSortPrivate(vector<int>& A, int start, int end){

	if (start < end) {
		int pIndex = Partition(A, start, end);
		QuickSortPrivate(A, start, pIndex - 1);
		QuickSortPrivate(A, pIndex + 1, end);
	}
}

void VectorSort::QuickSort() {

	QuickSortPrivate(data, 0, data.size()-1);

}