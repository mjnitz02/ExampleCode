#include "stdafx.h"
#include "stack.h"

using namespace std;

Stack::Stack() {

	stackPtr = NULL;

}

Stack::~Stack() {
	while (stackPtr != NULL){
		item* delItem = stackPtr;
		stackPtr = stackPtr->prev;
		delItem->prev = NULL; //optional line
		delete delItem;
	}
}

void Stack::Push(string name, int value){

	item* n = new item;
	n->name = name;
	n->value = value;

	if (stackPtr == NULL) {
		n->prev = NULL;
		stackPtr = n;
	}
	else {
		n->prev = stackPtr;
		stackPtr = n;
	}
}

void Stack::Pop() {

	if (stackPtr == NULL) {
		cout << "The stack is empty" << endl;
	}
	else {
		item* delPtr = stackPtr;
		cout << "The following item was popped off the stack" << endl;
		ReadItem(delPtr);

		stackPtr = stackPtr->prev;
		delPtr->prev = NULL; //optional
		delete delPtr;
	}
}

void Stack::ReadItem(item* r) {
	cout << "Name = " << r->name << ", Value = " << r->value << endl;
}

void Stack::Print() {

	item* curr = stackPtr;
	if (curr == NULL) {
		cout << "The stack is empty" << endl;
	}
	else {
		cout << "The stack contains the following items" << endl;
		while (curr != NULL) {
			ReadItem(curr);
			curr = curr->prev;
		}
	}
}