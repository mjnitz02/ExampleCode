#include "stdafx.h"
#include <cstdlib>
#include <iostream>

#include "DoubleList.h"

using namespace std;

DoubleList::DoubleList(){
	head = NULL;
	tail = NULL;
	curr = NULL;
	temp = NULL;
}

void DoubleList::AddNode(int addData) {
	nodePtr n = new node;
	n->next = NULL;
	n->data = addData;

	if (head != NULL) {
		n->prev = tail;
		tail->next = n;
		tail = n;
	}
	else {
		n->prev = NULL;
		head = n;
		tail = n;
	}
}

void DoubleList::DeleteNode(int delData) {
	nodePtr delPtr = new node;
	temp = head;
	curr = head;

	while (curr != NULL && curr->data != delData) {
		temp = curr;
		curr = curr->next;
	}
	if (curr == NULL) {
		cout << "The value " << delData << " was not found\n";
		delete delPtr;
	}
	else {
		delPtr = curr;

		if (delPtr == head) {
			head = head->next;
			head->prev = NULL;
			temp = NULL;
		}
		else if(delPtr == tail) {
			temp->next = NULL;
			tail = temp;
		}
		else {
			curr = curr->next;
			temp->next = curr;
			curr->prev = temp;
		}
		delete delPtr;
		cout << "The value " << delData << " was deleted from the list\n";
	}
}

void DoubleList::PrintListForward() {
	curr = head;

	while (curr != NULL) {
		cout << curr->data << " ";
		curr = curr->next;
	}
	cout << endl;
}

void DoubleList::PrintListReverse() {
	curr = tail;

	while (curr != NULL) {
		cout << curr->data << " ";
		curr = curr->prev;
	}
	cout << endl;
}