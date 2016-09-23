#include "stdafx.h"
#include <math.h>

#ifndef SEARCHCELL_H
#define SEARCHCELL_H

using namespace std;

#define WORLD_SIZE 64

struct SearchCell {

public:
	int m_xcoord, m_zcoord;
	int m_id;
	float G; //distance from start to finish
	float H; //estimated distance to goal
	SearchCell *parent;

	SearchCell() : parent(NULL) {};
	SearchCell(int x, int z, SearchCell *_parent = NULL) : m_xcoord(x), m_zcoord(z),
		parent(_parent), m_id(z * WORLD_SIZE + z), G(0), H(0) {};

	float GetF() {
		return G + H;
	}
	float ManhattanDistance(SearchCell *nodeEnd) {
		float x = (float)(fabs((float)this->m_xcoord - (float)nodeEnd->m_xcoord));
		float z = (float)(fabs((float)this->m_zcoord - (float)nodeEnd->m_zcoord));

		return x + z;
	}

};

#endif