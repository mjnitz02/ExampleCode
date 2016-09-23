// StringReverse.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"

using namespace std;

void reverse(char* cstring);
void revstr(char *p);

int _tmain(int argc, _TCHAR* argv[])
{

	char teststring[100];

	printf("Enter a string\n");
	gets_s(teststring);
	reverse(teststring); //char pointer reverse
	printf("Reverse of entered string is: %s.\n", teststring);

	printf("Enter a string\n");
	gets_s(teststring);
	revstr(teststring); //char pointer reverse
	printf("Reverse of entered string is: %s.\n", teststring);

	string test;
	printf("Enter a string\n");
	cin >> test;
	test = string(test.rbegin(), test.rend()); //using string class
	cout << "Reverse of entered string is: " << test << endl;

	printf("Enter a string\n");
	cin >> test;
	std::reverse(test.begin(), test.end()); //using cstd reverse
	cout << "Reverse of entered string is: " << test << endl;

	return 0;
}

void reverse(char *string)
{
	if (*string != NULL) {
		char* begin = string;
		char* end = string;
		char temp;

		while (*(end + 1) != '\0')
			end++;

		while (begin < end)
		{
			temp = *end;
			*end = *begin;
			*begin = temp;

			begin++;
			end--;
		}
	}
}

void revstr(char *p)
{
	char *q = p;
	while (q && *q) ++q;
	for (--q; p < q; ++p, --q)
		*p ^= *q,
		*q ^= *p,
		*p ^= *q;
}