#include "stdafx.h"
#include "SkeletonAnalyzer.h"

using namespace std;

SkeletonAnalyzer::SkeletonAnalyzer(JointType _joint1, JointType _joint2, JointType _joint3) {
	joint1 = _joint1; //left joint
	joint2 = _joint2; //target joint
	joint3 = _joint3; //right joint
}

	//methods
double SkeletonAnalyzer::GetSkeletonAngle(IBody* body, bool reverseJoint, double jointOffset) {
	//This method identifies the angle of the three joints
	//Example: Joints-> HipLeft, KneeLeft, AngleLeft
	//Function will return the current angle of the knee
	//Will return -999.0 if the knee is not tracked

	HRESULT hr; //kinect sensor success/fail responses

	if (body) { //check if the body is valid
		BOOLEAN isTracked = false; //check body tracking
		hr = body->get_IsTracked(&isTracked); //attempt to retrieve body tracking status

		if (SUCCEEDED(hr) && isTracked) { //check if body is successfully tracking

			Joint joints[JointType_Count]; //kinect joints
			hr = body->GetJoints(_countof(joints), joints); //attempt to retrieve joints

			if (SUCCEEDED(hr)) //check if kinect retrieved joints
			{
				//retrieve the joints
				Joint _j1 = joints[joint1];
				Joint _j2 = joints[joint2];
				Joint _j3 = joints[joint3];

				//construct left vector
				SkeletonVector vector12 = SkeletonVector(
					_j1.Position.X - _j2.Position.X,
					_j1.Position.Y - _j2.Position.Y,
					_j1.Position.Z - _j2.Position.Z);
				//construct right vector
				SkeletonVector vector23 = SkeletonVector(
					_j2.Position.X - _j3.Position.X,
					_j2.Position.Y - _j3.Position.Y,
					_j2.Position.Z - _j3.Position.Z);

				//normalize the vectors
				vector12.NormalizeVector();
				vector23.NormalizeVector();

				//calculate the dot product
				double dot = vector12.DotProduct(vector23);

				//calculate the cross product
				vector3 crossVector = vector12.CrossProduct(vector23);
				double cross = crossVector.z;

				//compute the angle of the joint
				double angle = atan2(cross, dot);
				angle *= (180 / 3.14159); //convert the angle to degrees

				if (reverseJoint) { //check if angle should be reversed
					angle *= -1.0; //reverse the angle
				}
				angle += jointOffset; //add the angle offset

				return angle;
			}
		}
	}
	return -999.0; //function failed at a check, return no angle
}

double SkeletonAnalyzer::GetBodyBalance(IBody* body) {
	//This method identifies the current balance of the body
	//Return is between -100 and +100 depending on if the body is tilted left or right
	//Return of 0 is perfectly balanced, return of -999.0 indicates no tracking

	HRESULT hr; //kinect sensor success/fail responses

	if (body) { //check if the body is valid
		BOOLEAN isTracked = false; //check body tracking
		hr = body->get_IsTracked(&isTracked); //attempt to retrieve body tracking status

		if (SUCCEEDED(hr) && isTracked) { //check if body is successfully tracking

			Joint joints[JointType_Count]; //kinect joints
			hr = body->GetJoints(_countof(joints), joints); //attempt to retrieve joints

			if (SUCCEEDED(hr)) //check if kinect retrieved joints
			{

				double balanceUp = joints[JointType_ShoulderLeft].Position.Y - joints[JointType_ShoulderRight].Position.Y;
				double balanceMid = joints[JointType_HipLeft].Position.Y - joints[JointType_HipRight].Position.Y;
				double balanceBot = joints[JointType_KneeLeft].Position.Y - joints[JointType_KneeRight].Position.Y;

				return ((balanceUp + balanceMid + balanceBot) / 3) * 100; //return a balance percentage
			}
		}
	}
	return -999.0; //function failed at a check, return no percentage
}

int SkeletonAnalyzer::GetBodyPosition(IBody* body)
{
	//This method identifies the current balance of the body
	//Return is between -100 and +100 depending on if the body is tilted left or right
	//Return of 0 is perfectly balanced, return of -999.0 indicates no tracking

	HRESULT hr; //kinect sensor success/fail responses

	if (body) { //check if the body is valid
		BOOLEAN isTracked = false; //check body tracking
		hr = body->get_IsTracked(&isTracked); //attempt to retrieve body tracking status

		if (SUCCEEDED(hr) && isTracked) { //check if body is successfully tracking

			Joint joints[JointType_Count]; //kinect joints
			hr = body->GetJoints(_countof(joints), joints); //attempt to retrieve joints

			if (SUCCEEDED(hr)) //check if kinect retrieved joints
			{
				double distanceUprightLeft = joints[JointType_SpineShoulder].Position.Y - joints[JointType_FootLeft].Position.Y;
				double distanceUprightRight = joints[JointType_SpineShoulder].Position.Y - joints[JointType_FootRight].Position.Y;

				joint1 = JointType_FootLeft;
				joint2 = JointType_KneeLeft;
				joint3 = JointType_HipLeft;
				double leftKneeAngle = abs(GetSkeletonAngle(body, false, 0));
				leftKneeAngle = (leftKneeAngle < 0) ? 0 : (leftKneeAngle > 360) ? 360 : leftKneeAngle;

				joint1 = JointType_FootRight;
				joint2 = JointType_KneeRight;
				joint3 = JointType_HipRight;
				double rightKneeAngle = abs(GetSkeletonAngle(body, false, 0));
				rightKneeAngle = (rightKneeAngle < 0) ? 0 : (rightKneeAngle > 360) ? 360 : rightKneeAngle;


				//NOTE THE KNEES ARE NOT CALIBRATED SO THIS CODE WILL NOT WORK RIGHT!!!!!
				if (leftKneeAngle > 60.0 && rightKneeAngle > 60.0) //knees are bent
				{
					return 2; //must be sitting, return 1
				}
				else if (leftKneeAngle < 20 && rightKneeAngle < 20) //knees are mostly straight
				{
					//check for body position because knees are mostly straight
					if (distanceUprightLeft < 6.0 && distanceUprightRight < 6.0) //height difference between points is small
					{
						return 3;
					}
					else //knees are mostly straight and height difference between points is large
					{
						return 1; //must be standing
					}
				}
				else//knees are in transition
				{
					return 0; //current body position is unsure
				}
			}
		}
	}
	return -999; //function failed at a check, return no idx
}