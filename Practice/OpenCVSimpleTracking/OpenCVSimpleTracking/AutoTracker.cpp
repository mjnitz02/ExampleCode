#include "stdafx.h"

using namespace cv;
using namespace std;


class AutoTracker{


private:
	Mat* HSV; //our image as reference

	//internal hsv tracking
	int h_min = 0;
	int h_max = 256;
	int s_min = 0;
	int s_max = 256;
	int v_min = 0;
	int v_max = 256;

	bool thresholdIsSet; //threshold has been determined and is tracking

public:
	AutoTracker(Mat* _HSV){
		HSV = _HSV; //the input image we will operate on
		thresholdIsSet = false;
	};
	~AutoTracker(){
		//nothing really to clean up
	};

	bool locateObject() {
		return true;
	}




};