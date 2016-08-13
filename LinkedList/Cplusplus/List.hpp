// Name: List.hpp
// Author : Matt Nitzken
// Description : Single linked list class header
#ifndef LIST_HPP
#define LIST_HPP

//List class
class List{
private:
	//Node structure
	typedef struct node{
		int data;
		node* next;
	}* nodePtr;

	//List variables
	nodePtr head;
	nodePtr curr;
	nodePtr temp;

	//Private functions
	void ReverseListPrivate(node* Ptr);

public:
	//Constructors
	List();

	//Public functions
	void AddNode(int addData);
	void DeleteNode(int delData);
	void PrintList();
	void ReverseList();
	void ReverseListRecursive();

};
#endif