#include "stdafx.h"

using namespace std;

#ifndef STACK_H
#define STACK_H



class Stack{

private:
	struct item{
		string name;
		int value;
		item* prev;
	};

	item* stackPtr;

public:

	Stack();
	~Stack();
	void Push(string name, int value);
	void Pop();
	void ReadItem(item* r);
	void Print();

};


#endif