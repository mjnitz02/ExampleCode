#include "stdafx.h"
#include "binarytree.h"

using namespace std;

BST::BST() {

	root = NULL;

}

BST::~BST() {
	RemoveSubtree(root);
}

BST::node* BST::CreateLeaf(int key){

	node* n = new node;
	n->key = key;
	n->left = NULL;
	n->right = NULL;

	return n;

}

void BST::AddLeaf(int key) {
	AddLeafPrivate(key, root);
}

void BST::AddLeafPrivate(int key, node* Ptr) {

	if (root == NULL) {
		root = CreateLeaf(key);
	}
	else if (key < Ptr->key) {
		if (Ptr->left != NULL) {
			AddLeafPrivate(key, Ptr->left);
		}
		else {
			Ptr->left = CreateLeaf(key);
		}
	}
	else if (key > Ptr->key) {
		if (Ptr->right != NULL) {
			AddLeafPrivate(key, Ptr->right);
		}
		else {
			Ptr->right = CreateLeaf(key);
		}
	}
	else {
		cout << "The key " << key << " has already been added to the tree" << endl;
	}
}

void BST::PrintInOrder() {
	PrintInOrderPrivate(root);
	cout << endl;
}

void BST::PrintInOrderPrivate(node* Ptr) {

	if (root == NULL) {
		cout << "The tree is empty" << endl;
	}
	else {
		if (Ptr->left != NULL) {
			PrintInOrderPrivate(Ptr->left);
		}
		cout << Ptr->key << " ";
		if (Ptr->right != NULL) {
			PrintInOrderPrivate(Ptr->right);
		}
	}
}

BST::node* BST::ReturnNode(int key) {
	return ReturnNodePrivate(key, root);
}

BST::node* BST::ReturnNodePrivate(int key, node* Ptr) {
	if (Ptr != NULL) {
		if (Ptr->key == key)
		{
			return Ptr;
		}
		else {
			if (key < Ptr->key) {
				return ReturnNodePrivate(key, Ptr->left);
			}
			else {
				return ReturnNodePrivate(key, Ptr->right);
			}
		}
	}
	else {
		return NULL;
	}
}

int BST::ReturnRootKey() {

	if (root != NULL) {
		return root->key;
	}
	else {
		return -1;
	}
}

void BST::PrintChildren(int key) {
	node* Ptr = ReturnNode(key);

	if (Ptr != NULL) {
		cout << "Parent Node = " << Ptr-> key << endl;
		Ptr->left == NULL ? 
			cout << "Left Child = NULL" << endl :
			cout << "Left Child = " << Ptr->left->key << endl;

		Ptr->right == NULL ?
			cout << "Right Child = NULL" << endl :
			cout << "Right Child = " << Ptr->right->key << endl;
	}
	else {
		cout << "Key " << key << " is not in the tree" << endl;
	}
}

int BST::FindSmallest() {
	return FindSmallestPrivate(root);
}

int BST::FindSmallestPrivate(node* Ptr) {

	if (root == NULL) {
		cout << "The tree is empty" << endl;
		return -1;
	}
	else {
		if (Ptr->left != NULL) {
			return FindSmallestPrivate(Ptr->left);
		}
		else {
			return Ptr->key;
		}
	}
}

int BST::FindLargest() {
	return FindLargestPrivate(root);
}

int BST::FindLargestPrivate(node* Ptr) {

	if (root == NULL) {
		cout << "The tree is empty" << endl;
		return -1;
	}
	else {

		if (Ptr->right != NULL) {
			return FindLargestPrivate(Ptr->right);
		}
		else {
			return Ptr->key;
		}
	}
}

void BST::RemoveNode(int key) {
	RemoveNodePrivate(key, root);
}

void BST::RemoveNodePrivate(int key, node*parent) {

	if (root == NULL) {
		cout << "The tree is empty" << endl;
	}
	else {
		if (root->key == key) {
			RemoveRootMatch();
		}
		else {
			if (key < parent->key && parent->left != NULL) {
				parent->left->key == key ? 
					RemoveMatch(parent, parent->left, true) : 
					RemoveNodePrivate(key, parent->left);
			}
			else if (key > parent->key && parent->right != NULL) {
				parent->right->key == key ?
					RemoveMatch(parent, parent->right, false) :
					RemoveNodePrivate(key, parent->right);
			}
			else {
				cout << "The key " << key << " was not found in the tree" << endl;
			}
		}
	}

}

void BST::RemoveRootMatch() {
	if (root == NULL) {
		cout << "Cannot remove root. Tree is empty" << endl;
	}
	else {
		node* delPtr = root;
		int rootKey = root->key;
		int smallestinRightSubtree;

		if (root->left == NULL && root->right == NULL) {
			root = NULL;
			delete delPtr;
			cout << "The root was deleted" << endl;
		}
		else if (root->left == NULL && root->right != NULL) {
			root = root->right;
			delPtr->right = NULL;
			delete delPtr;
			cout << "The root with key " << rootKey << " was deleted." << endl;
			cout << "The new root key contains " << root->key << endl;
		}
		else if (root->left != NULL && root->right == NULL) {
			root = root->left;
			delPtr->left = NULL;
			delete delPtr;
			cout << "The root with key " << rootKey << " was deleted." << endl;
			cout << "The new root key contains " << root->left << endl;
		}
		else {
			smallestinRightSubtree = FindSmallestPrivate(root->right);
			RemoveNodePrivate(smallestinRightSubtree, root);
			root->key = smallestinRightSubtree;
			cout << "The root with key " << rootKey << " was overwritten." << endl;
			cout << "The new root key contains " << root->key << endl;
		}
	}
}

void BST::RemoveMatch(node* parent, node* match, bool left) {

	if (root == NULL) {
		cout << "The tree is empty" << endl;
	}
	else {
		node* delPtr;
		int matchkey = match->key;
		int smallestInRightSubtree;

		if (match->left == NULL && match->right == NULL) {
			delPtr = match;
			left == true ? parent->left = NULL : parent->right = NULL;
			delete delPtr;
			cout << "The node containing key " << matchkey << " was removed" << endl;
		}
		else if (match->left == NULL && match->right != NULL) {
			left == true ? parent->left = match->right : parent->right = match->right;
			match->right = NULL;
			delPtr = match;
			delete delPtr;
			cout << "The node containing key " << matchkey << " was removed" << endl;
		}
		else if (match->left != NULL && match->right == NULL) {
			left == true ? parent->left = match->left : parent->right = match->left;
			match->left = NULL;
			delPtr = match;
			delete delPtr;
			cout << "The node containing key " << matchkey << " was removed" << endl;
		}
		else {
			smallestInRightSubtree = FindSmallestPrivate(match->right);
			RemoveNodePrivate(smallestInRightSubtree, match);
			match->key = smallestInRightSubtree;
			cout << "The node with key " << matchkey << " was overwritten." << endl;
			cout << "The new root node contains " << match->key << endl;
		}
	}

}

void BST::RemoveSubtree(node* Ptr) {
	if (Ptr != NULL) {
		if (Ptr->left != NULL) {
			RemoveSubtree(Ptr->left);
		}
		if (Ptr->right != NULL) {
			RemoveSubtree(Ptr->right);
		}
		cout << "Deleteing the node containing key " << Ptr->key << endl;
		delete Ptr;
	}
}

void BST::PrintInLevelOrder() {
	PrintInLevelOrderPrivate(root);
}

void BST::PrintInLevelOrderPrivate(node* Ptr) {

	if (root == NULL) {
		cout << "The tree is empty" << endl;
	}
	else {
		queue<node*> currentlevel, nextlevel;
		currentlevel.push(Ptr);

		while(!currentlevel.empty()) {
			node* current = currentlevel.front();
			currentlevel.pop();

			cout << current->key << " ";
			if (current->left != NULL) {
				nextlevel.push(current->left);
			}
			if (current->right != NULL) {
				nextlevel.push(current->right);
			}
			if (currentlevel.empty()) {
				swap(currentlevel,nextlevel);
				cout << endl;
			}
		}
	}

}