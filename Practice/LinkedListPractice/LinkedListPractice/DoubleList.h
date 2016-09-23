#ifndef DOUBLELIST_H
#define DOUBLELIST_H

class DoubleList{
private:
	typedef struct node {
		int data;
		node* next;
		node* prev;
	}* nodePtr;

	nodePtr head;
	nodePtr tail;
	nodePtr curr;
	nodePtr temp;

public:
	DoubleList();
	void AddNode(int addData);
	void DeleteNode(int delData);
	void PrintListForward();
	void PrintListReverse();
};

#endif