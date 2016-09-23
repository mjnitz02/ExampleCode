#include "stdafx.h"

using namespace std;

#ifndef BINARYTREE
#define BINARYTREE


class BST {

private:
	struct node{
		int key;
		node* left;
		node* right;
	};

	node* root;
	
	node* CreateLeaf(int key);
	node* ReturnNode(int key);
	node* ReturnNodePrivate(int key, node* Ptr);

	void AddLeafPrivate(int key, node* Ptr);
	
	void PrintInOrderPrivate(node* Ptr);
	int FindSmallestPrivate(node* Ptr);
	int FindLargestPrivate(node* Ptr);

	void RemoveNodePrivate(int key, node* parent);
	void RemoveRootMatch();
	void RemoveMatch(node* parent, node* match, bool left);
	void RemoveSubtree(node* Ptr);

	void PrintInLevelOrderPrivate(node* Ptr);


public:
	BST();
	~BST();
	void AddLeaf(int key);
	void RemoveNode(int key);

	void PrintInOrder();
	void PrintChildren(int key);
	int ReturnRootKey();
	
	int FindSmallest();
	int FindLargest();

	void PrintInLevelOrder();
};


#endif // !BINARYTREE