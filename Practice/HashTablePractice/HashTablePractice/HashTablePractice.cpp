// HashTablePractice.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include "hash.h"


int _tmain(int argc, _TCHAR* argv[])
{

	int index;
	HASH hashObj;
	
	hashObj.AddItem("Annie","carbonated water");
	hashObj.AddItem("Robert","green tea");
	hashObj.AddItem("Paul","cherry soda");
	hashObj.AddItem("Matthew","water");
	hashObj.AddItem("Matt","coke");
	hashObj.AddItem("ttaM","coke zero");
	hashObj.AddItem("tatM","cherry coke");
	hashObj.AddItem("Chelsea","diet dew");
	hashObj.AddItem("Chelsea","diet dew");
	hashObj.AddItem("Chelsea","diet dew");
	//
	//hashObj.PrintTable();

	//hashObj.PrintItemsinIndex(0);

	hashObj.RemoveItem("Annie");

	
	hashObj.PrintTable();
	hashObj.PrintItemsinIndex(0);

	return 0;
}

