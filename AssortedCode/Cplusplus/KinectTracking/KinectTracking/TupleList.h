//windows header files
#include "stdafx.h"
#include <vector>
#include <tuple>

using namespace std;

#ifndef TUPLELIST
#define TUPLELIST

struct TupleList{

	unsigned idx = 0;
	vector<tuple<string, string>> tuple_list;

	void add(string _s1, string _s2) {
		tuple<string, string> data(_s1, _s2);
		tuple_list.push_back(data);
	}

	tuple<string, string> get(unsigned idx) {
		if (idx < tuple_list.size()) {
			return tuple_list.at(idx);
		}
		else
		{
			return tuple < string, string > (NULL, NULL);
		}
	}

	tuple<string, string> next() {
		if (idx < tuple_list.size()) {
			tuple<string, string> data = tuple_list.at(idx);
			idx++;
			return data;
		}
		else
		{
			return tuple < string, string >(NULL, NULL);
		}
	}

	void Reset() {
		idx = 0;
	}

	void Clear() {
		tuple_list.clear();
	}
};

#endif // !VECTOR3