#include "stdafx.h"
#include <math.h>

#ifndef VECTOR3_H
#define VECTOR3_H

using namespace std;

class Vector3
{
public:
	float x, y, z;

	Vector3(float _x, float _y, float _z)
		: x(_x), y(_y), z(_z)
	{

	}

	void inverse()
	{
		x = -x;
		y = -y;
		z = -z;
	}

	float dist(float p1[3], float p2[3])
	{
		float x = p1[0] - p2[0];
		float y = p1[1] - p2[1];
		float z = p1[2] - p2[2];
		return sqrt(x*x + y*y + z*z);
	}
};

// Usage example:
void test()
{
	Vector3 v(0.0f, 1.0f, 2.0f);
	v.inverse();
}

#endif