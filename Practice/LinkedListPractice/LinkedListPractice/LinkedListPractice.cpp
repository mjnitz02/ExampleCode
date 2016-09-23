// LinkedList.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include "List.h"
#include "DoubleList.h"
#include <iostream>

using namespace std;

struct node{
	int data;
	node* next;
};

void SearchList(node* Ptr, int searchValue);
void SearchRecursive(node* Ptr, int searchValue);


int _tmain(int argc, _TCHAR* argv[])
{
	//node* n = new node;
	//node* head = n;
	//node* t = n;

	//n->data = 1;

	//for (int i = 2; i < 10; i++) {
	//	n = new node;
	//	n->data = i;
	//	t->next = n;
	//	t = n;
	//}
	//n->next = NULL;

	//t = head;
	//while (t != NULL) {
	//	cout << t->data << " ";
	//	t=t->next;
	//}
	//cout << endl;
	//
	//SearchList(head,5);
	//SearchRecursive(head,6);

	//SearchList(head,11);
	//SearchRecursive(head,12);

	List temp;
	temp.AddNode(1);
	temp.AddNode(2);
	temp.AddNode(3);
	temp.AddNode(4);
	temp.AddNode(5);
	temp.PrintList();
	temp.ReverseListRecursive();
	temp.PrintList();

	return 0;
}

void SearchList(node* Ptr, int searchValue) {

	while (Ptr != NULL && Ptr->data != searchValue) {
		Ptr = Ptr->next;
	}
	if (Ptr == NULL) {
		cout << "Search value " << searchValue << " was not found in the list\n";
	}
	else {
		cout << "We found the vale " << searchValue << " in the node " << Ptr << endl;
	}

}

void SearchRecursive(node* Ptr, int searchValue) {

	if (Ptr == NULL) {
		cout << "Search value " << searchValue << " was not found in the list\n";
	}
	else if (Ptr->data == searchValue) {
		cout << "We found the vale " << searchValue << " in the node " << Ptr << endl;
	}
	else {
		SearchRecursive(Ptr->next, searchValue);
	}

}