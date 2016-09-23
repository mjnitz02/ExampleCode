// AlgorithmPractice.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <cstdlib>
#include <string>
#include <iostream>

using namespace std;

void swap(char *x, char* y) {
	char temp;
	temp = *x;
	*x = *y;
	*y = temp;
}

void permute(char* a, int i, int n) {

	if (i == n) {
		printf("%s\n", a);
	}
	else{
		for (int j = i; j <= n; ++j) {
			swap((a + i), (a + j));
			permute(a, i + 1, n);
			swap((a + i), (a + j));
		}
	}

}

char res[1001];

void print(int start, int high, int idx, char res[], char str[])
{
	if (start == high)
	{
		res[idx] = '\0';
		cout << res << endl;
		return;
	}

	if (start<high)
	{
		res[idx] = str[start];
		print(start + 1, high, idx + 1, res, str);
		if (start != high - 1){
			res[idx + 1] = ' ';
			print(start + 1, high, idx + 2, res, str);
		}
	}
}

void FindLength(char* str) {
	int n = strlen(str);
	int maxlen = 0;  // Initialize result

	// Choose starting point of every substring
	for (int i = 0; i<n; i++)
	{
		// Choose ending point of even length substring
		for (int j = i + 1; j<n; j += 2)
		{
			int length = j - i + 1;//Find length of current substr

			// Calculate left & right sums for current substr
			int leftsum = 0, rightsum = 0;
			for (int k = 0; k<length / 2; k++)
			{
				leftsum += (str[i + k] - '0');
				rightsum += (str[i + k + length / 2] - '0');
			}

			// Update result if needed
			if (leftsum == rightsum && maxlen < length)
				maxlen = length;
		}
	}

	cout << maxlen << endl;
}


void Reorder(int* a, int len) {
	
	for (int i = 0; i < len; i++) {
		cout << a[i] % len << endl;
		cout << i * len << endl;
		a[a[i] % len] += i * len;
	}
	for (int i = 0; i < len; i++) {
		a[i] = a[i] / len;
	}
}

int _tmain(int argc, _TCHAR* argv[])
{

	int vals[] = { 1, 3, 0, 2 };
	Reorder(vals, 4);
	for (int i = 0; i < 4; i++) {
		cout << vals[i];
	}
	cout << endl;

	//char test[] = "ASDJA";
	//permute(test, 0, 4);

	//char test[] = "12341234";
	////print(0,strlen(test),0,res,test);

	//cout << test[1] << endl;
	//cout << test[1] - '0' << endl;

	//FindLength(test);

	return 0;
}

