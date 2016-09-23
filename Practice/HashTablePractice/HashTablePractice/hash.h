#include "stdafx.h"

using namespace std;

#ifndef HASH_H
#define HASH_H

class HASH{

private:
	static const int tableSize = 5;

	struct item{
		string name;
		string drink;
		item* next;
	};

	item* HashTable[tableSize];

public:
	HASH();
	int Hash(string key);
	void AddItem(string name, string drink);
	int NumberOfItemsInIndex(int bucket);
	void PrintTable();
	void PrintItemsinIndex(int bucket);
	void FindDrink(string name);
	void RemoveItem(string name);

};

#endif