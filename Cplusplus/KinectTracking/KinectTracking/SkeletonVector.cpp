#include "stdafx.h"
#include "SkeletonVector.h"

using namespace std;

SkeletonVector::SkeletonVector(double x, double y, double z) {
	coord.x = x;
	coord.y = y;
	coord.z = z;
}

	//methods
void SkeletonVector::NormalizeVector() {
	double len = sqrt(pow(coord.x, 2) + pow(coord.y, 2) + pow(coord.z, 2)); //get euclidean distance of vector
	if (len > 0) { //handle possible divide-by-zero condition
		coord.x /= len; //norm x
		coord.y /= len; //norm y
		coord.z /= len; //norm z
	}
	//if len is 0, x,y,z are also 0, so no normalization
}

vector3 SkeletonVector::CrossProduct(SkeletonVector _vector) {
	vector3 cross; //return variable

	cross.x = (coord.y * _vector.coord.z) - (coord.z * _vector.coord.y); //cross x
	cross.y = (coord.z * _vector.coord.x) - (coord.x * _vector.coord.z); //cross y
	cross.z = (coord.x * _vector.coord.y) - (coord.y * _vector.coord.x); //cross z

	return cross; //return cross product
}

double SkeletonVector::DotProduct(SkeletonVector _vector) {
	return (coord.x * _vector.coord.x) + (coord.y * _vector.coord.y) + (coord.z * _vector.coord.z); //return dot product
}