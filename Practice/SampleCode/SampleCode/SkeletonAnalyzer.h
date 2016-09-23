//!  SkeletonAnalyzer class. 
/*!
Author: Matt Nitzken
Description: Computes angles and balance for a body detected by the Microsoft Kinect
Dependencies: SkeletonVector, vector3
*/

#include "vector3.h"
#include "SkeletonVector.h"

#ifndef SKELETONANALYZER
#define SKELETONANALYZER

class SkeletonAnalyzer {

private:
	//private variables
	JointType joint1, joint2, joint3; //joint types

public:
	//constructor
	SkeletonAnalyzer(JointType _joint1, JointType _joint2, JointType _joint3);

	//methods
	double GetSkeletonAngle(IBody* body, bool reverseJoint, double jointOffset);
	double GetBodyBalance(IBody* body);
};

#endif // !SKELETONANALYZER