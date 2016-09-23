// BinaryTreePractice.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include "binarytree.h"

using namespace std;


int _tmain(int argc, _TCHAR* argv[])
{

	int TreeKeys[16] = {50, 76, 21, 4, 32, 64, 15, 52, 14, 100, 83, 2, 3, 70, 87, 80};

	BST myTree;

	cout << "Printing the tree in order\nBefore adding numbers" << endl;

	myTree.PrintInOrder();

	for (int i = 0; i < 16; i++) {
		myTree.AddLeaf(TreeKeys[i]);
	}
	cout << "Printing the tree in order\nAfter adding numbers" << endl;
	myTree.PrintInOrder();
	myTree.PrintInLevelOrder();

	//for (int i = 0; i < 16; i++) {
	//	myTree.PrintChildren(TreeKeys[i]);
	//	cout << endl;
	//}

	cout << "The smallest value is " << myTree.FindSmallest() << endl;

	//int input = 0;;

	//cout << "Enter a value to delete" << endl;
	//while (input != -1) {
	//	cout << "Delete node: ";
	//	cin >> input;
	//	if (input != -1) {
	//		cout << endl;
	//		myTree.RemoveNode(input);
	//		myTree.PrintInOrder();
	//		cout << endl;
	//	}
	//}
	return 0;
}

