#include "stdafx.h"
#include "hash.h"

using namespace std;

HASH::HASH() {
	for(int i = 0; i < tableSize; i++) {
		HashTable[i] = new item;
		HashTable[i]->name = "empty";
		HashTable[i]->drink = "empty";
		HashTable[i]->next = NULL;
	}
}

int HASH::Hash(string key) {

	int hashval = 0;
	int bucket;

	for(int i = 0; i < key.length(); i++) {
		hashval = (hashval + (int)key[i]) * 7;
	}

	bucket = hashval % tableSize;

	return bucket;
}

void HASH::AddItem(string name, string drink){

	int bucket = Hash(name);
	
	if (HashTable[bucket]->name == "empty"){
		HashTable[bucket]->name = name;
		HashTable[bucket]->drink = drink;
	}
	else {
		item* Ptr = HashTable[bucket];
		item* n = new item;
		n->name = name;
		n->drink = drink;
		n->next = NULL;

		while (Ptr->next != NULL) {
			Ptr = Ptr->next;
		}
		Ptr->next = n;
	}
}

int HASH::NumberOfItemsInIndex(int bucket){
	
	int count = 0;
	

	if (HashTable[bucket]->name == "empty"){
		return count;
	}
	else {
		count++;
		item* Ptr = HashTable[bucket];
		while (Ptr->next != NULL) {
			count++;
			Ptr = Ptr->next;
		}
	}

	return count;
}

void HASH::PrintTable() {

	int number;

	for (int i = 0; i < tableSize; i++) {
		number = NumberOfItemsInIndex(i);
		cout << "---------------------" << endl;
		cout << "index = " << i << endl;
		cout << "name = " << HashTable[i]->name << endl;
		cout << "drink = " << HashTable[i]->drink << endl;
		cout << "# of items = " << number << endl;
		cout << "---------------------" << endl;
	}

}

void HASH::PrintItemsinIndex(int bucket) {

	item* Ptr;

	Ptr = HashTable[bucket];

	if (Ptr->name == "empty")
		cout << "index = " << bucket << " is empty" << endl;
	else {
		cout << "index = " << bucket << " contains the following items" << endl;
		while (Ptr != NULL) {
			cout << "---------------------" << endl;
			cout << "name = " << Ptr->name << endl;
			cout << "drink = " << Ptr->drink << endl;
			cout << "---------------------" << endl;
			Ptr = Ptr->next;
		}
	}
}

void HASH::FindDrink(string name) {

	bool foundName = false;
	int bucket = Hash(name);

	item* Ptr = HashTable[bucket];
	if (Ptr->name == "empty") {
		cout << "The name " << name << " was not found" << endl;
	}
	else {
		while (Ptr != NULL) {
			if (Ptr->name == name) {
				cout << Ptr->name << " enjoys " << Ptr->drink << endl;
				foundName = true;
			}
			Ptr = Ptr->next;
		}
		if (!foundName) {
			cout << "The name " << name << " was not found" << endl;
		}
	}

}

void HASH::RemoveItem(string name){

	int bucket = Hash(name);

	item* delPtr;
	item* P1;
	item* P2;

	//Case 0 - bucket is empty
	if (HashTable[bucket]->name == "empty") { //No buckets to target
		cout << "The bucket is empty" << endl;
	}
	else if(HashTable[bucket]->name == name) { //First bucket is target

		if (HashTable[bucket]->next == NULL) { //only 1 item
			cout << "The head was set to null" << endl;
			HashTable[bucket]->name = "empty";
			HashTable[bucket]->drink = "empty";
		}
		else { //remove the head
			cout << "The head was removed" << endl;
			delPtr = HashTable[bucket]; //take the head
			HashTable[bucket] = HashTable[bucket]->next;

			delete delPtr; //delete the old head
		}
	}
	else {
		P1 = HashTable[bucket]->next;
		P2 = HashTable[bucket];

		while (P1 != NULL && P1->name != name) {
			P2 = P1;
			P1 = P1->next;
		}
		if (P1 == NULL) {
			cout << "The item was not found in the bucket" << endl;
		}
		else {
			cout << "Interior node was removed" << endl;
			delPtr = P1; //take the item
			P1 = P1->next; //iterate to the next node in the list
			P2->next = P1;

			delete delPtr; //delete the item
		}
	}
}