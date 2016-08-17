// Name: List.cpp
// Author : Matt Nitzken
// Description : Single linked list class body

#include "stdafx.h"
#include <cstdlib>
#include <iostream>
#include "List.hpp"

using namespace std;

//List class
List::List() {
	head = NULL;
	curr = NULL;
	temp = NULL;
}

//Function to add a node to the list
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

//Function to delete a node from the list
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

//Function to print the list
void List::PrintList(){
	curr = head;

	while(curr != NULL){
		cout << curr->data << endl;
		curr = curr->next;
	}
	cout << endl;
}

//Function to reverse the list
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

//Function to reverse the list using recursion
void List::ReverseListRecursive() {
	ReverseListPrivate(head);
}

//Private function to reverse the list using recursion
void List::ReverseListPrivate(node* Ptr) {

	if (Ptr->next == NULL) {
		head = Ptr;
		return;
	}
	ReverseListPrivate(Ptr->next);
	Ptr->next->next = Ptr;
	Ptr->next = NULL;
}