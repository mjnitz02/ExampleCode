// DPFactorial.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <iostream>
#include <fstream>
#include <string>


int FactorialDP(int i, int* arr) {
	if (i < 1)
		return 0;
	if (i == 1) {
		arr[i] = i;
		return 1;
	}
		

	int ret = i * arr[i - 1];
	arr[i] = ret;
	return ret;
}

long FactorailRec(long i) {
	return(i == 1 ? i : i * FactorailRec(i- 1));
}

int _tmain(int argc, _TCHAR* argv[])
{

	//int n = 30;
	//int* arr = new int[n];

	//for (long i = 1; i < n; i++) {
	//	//std::cout << FactorialDP(i, arr) << std::endl;
	//	std::cout << FactorailRec(i) << std::endl;
	//}

	std::ifstream input("test.txt");

	//for (std::string line; std::getline(input, line);) {
	//	std::cout << line << std::endl;
	//}

	std::string line;

	while (std::getline(input, line)) {
		std::cout << line << std::endl;
	}



	return 0;
}

