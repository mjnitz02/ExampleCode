#ifndef LIST_H
#define LIST_H


class List{
private: //this is where the private data goes
	
	typedef struct node{
		int data;
		node* next;
	}* nodePtr;

	nodePtr head;
	nodePtr curr;
	nodePtr temp;

	void ReverseListPrivate(node* Ptr);

public:  // this is where the functions go
	List();
	void AddNode(int addData);
	void DeleteNode(int delData);
	void PrintList();

	void ReverseList();
	void ReverseListRecursive();

};

#endif