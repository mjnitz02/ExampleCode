//!  SkeletonVector class. 
/*!
Author: Matt Nitzken
Description: Support class for quickly performing vector computations
Dependencies: vector3
*/

#include "vector3.h"

#ifndef SKELETONVECTOR
#define SKELETONVECTOR

class SkeletonVector {

public:
	//variables
	vector3 coord; //hold coordinates (allow public for cross & dot)

	//constructor
	SkeletonVector(double x, double y, double z);

	//methods
	void NormalizeVector();
	vector3 CrossProduct(SkeletonVector _vector);
	double DotProduct(SkeletonVector _vector);
};

#endif // !SKELETONVECTOR