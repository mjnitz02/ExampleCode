#include "stdafx.h"
#include <cstdlib>
#include <iostream>

#include "List.h" //include the header information for our List

using namespace std;

List::List() { //constructor for List
	head = NULL;
	curr = NULL;
	temp = NULL;
}

void List::AddNode(int addData){
	nodePtr n = new node;
	n->next = NULL;
	n->data = addData;

	if (head != NULL) {
		curr = head;
		while(curr->next != NULL) {
			curr = curr->next;
		}
		curr->next = n;
	}
	else {
		head = n;
	}
}

void List::DeleteNode(int delData){
	nodePtr delPtr = NULL;
	temp = head;
	curr = head;

	while(curr != NULL && curr->data != delData){ //iterate through list searching for data to delete
		temp = curr; //lag temp
		curr = curr->next; //move current
	}
	if(curr == NULL){
		cout << "The value " << delData << " was not in the list\n";
		delete delPtr;
	}
	else {
		delPtr = curr; //node being deleted
		curr = curr->next; //take the next node
		temp->next = curr; //hook the previous node to next node (removing delPtr)

		if(delPtr == head) { //handle the front of the list
			head = head->next;
			temp = NULL;
		}

		delete delPtr; //delete the node
		cout << "The value " << delData << " was deleted\n";
	}
}

void List::PrintList(){
	curr = head;

	while(curr != NULL){
		cout << curr->data << endl;
		curr = curr->next;
	}
	cout << endl;
}

void List::ReverseList() {

	nodePtr curr = head;
	nodePtr prev = NULL;

	while (curr != NULL) {
		nodePtr next = curr->next;
		curr->next = prev;
		prev = curr;
		curr = next;
	}
	head = prev;
}

void List::ReverseListRecursive() {
	ReverseListPrivate(head);
}

void List::ReverseListPrivate(node* Ptr) {

	if (Ptr->next == NULL) {
		head = Ptr;
		return;
	}
	ReverseListPrivate(Ptr->next);
	Ptr->next->next = Ptr;
	Ptr->next = NULL;
}