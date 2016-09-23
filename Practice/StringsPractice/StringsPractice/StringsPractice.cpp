// StringsPractice.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <string>
#include <iostream>
#include <math.h>
#include <vector>

using namespace std;

int XorSequenceEasy(int *A, int N) {

	int B = N - 1;

	cout << "Length of A: " << sizeof(&A) <<  endl;

	return 0;
}

bool decipher(string s, string t) {

	int i;
	int charcountS[26] = {};

	if (s.length() - 1 != t.length()) { //check for length
		cout << "Can only erase 1 character" << endl;
		return false;
	}
	else { //check if acceptable characters exist
		for (i = 0; i < s.length(); i++) {
			charcountS[(int)(s[i] - 'a')]++; //add if exists in s
		}
		for (i = 0; i < t.length(); i++) {
			charcountS[(int)(t[i] - 'a')]--; //remove if exists in t
		}

		int sum = 0;
		for (i = 0; i < 26; i++) {
			sum += abs(charcountS[i]); //if negative we had a char in t not found in s
		}

		if (sum != 1) {
			cout << "There are bad characters" << endl;
			return false; // we are not only 1 char short
		}
		else { //check the order
			for (i = 0; i < t.length(); i++) { //can only iterate as far as t
				if (t[i] != s[i]) { //are we equal?
					//is the next char equal?
					if (t[i] != s[i + 1]) {
						cout << "Flipped characters" << endl;
						return false;
					}
				}
				//else just continue walking
			}
			
			cout << "Possible!" << endl;
			return true;
		}
	}



}

void FizzBuzz() {

	for (int i = 1; i <= 100; ++i) {

		if ((!(i % 3)) && (!(i % 5))) {
			cout << "FizzBuzz" << endl;
		}
		else if (!(i % 3)) {
			cout << "Fizz" << endl;
		}
		else if (!(i % 5)) {
			cout << "Buzz" << endl;
		}
		else{
			cout << i << endl;
		}
	}
}

string removeSpace(string s) {

	if (s.empty()) {
		return s;
	}
	else {
		for (int i = 0; i < s.length() - 1; i++) {
			if (s[i + 1] == ' ') {
				cout << "REMOVE" << i << endl;
				s = s.substr(0, i + 1) + s.substr(i + 2);
			}
		}

		if (s[0] == ' ') {
			s = s.substr(1);
		}
		else if (s[s.length() - 1] == ' ') {
			s = s.substr(0, s.length() - 1);
		}

		return s;
	}
}

int _tmain(int argc, _TCHAR* argv[])
{

	int A[] = { 3, 2, 1, 0, 3, 2 };
	int out = XorSequenceEasy(A, 4);

	//bool test = decipher("sunuke", "snuke");
	//test = decipher("snuke", "skue");
	//test = decipher("snuke", "snuke");
	//test = decipher("snukent", "snuke");
	//test = decipher("aaaaa", "aaaa");
	//test = decipher("aaaaa", "aaa");
	//test = decipher("topcoder", "tpcoder");

	//FizzBuzz();
	//string testString = "Hello world  ";

	//string stringArray[50];

	//stringArray[0] = "test";
	//stringArray[1] = "yes!";

	//cout << testString << endl;
	//cout << stringArray[0] << endl;

	//cout << "A" << testString << "A" << endl;
	//testString = removeSpace(testString);
	//cout << "A" << testString << "A" << endl;

	return 0;
}

