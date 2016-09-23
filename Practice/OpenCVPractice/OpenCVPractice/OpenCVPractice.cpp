// OpenCVPractice.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"

using namespace cv;
using namespace std;

int _tmain(int argc, _TCHAR* argv[])
{

	bool recording = false;
	bool startNewRecording = false;

	//VIDEO CAPTURE
	VideoCapture cap(0); // open the video camera no. 0

	if (!cap.isOpened())  // if not success, exit program
	{
		cout << "ERROR INITIALIZING VIDEO CAPTURE" << endl;
		return -1;
	}

	char* windowName = "Webcam Feed";
	namedWindow(windowName, CV_WINDOW_AUTOSIZE); //create a window to display our webcam feed

	//VIDEO WRITER
	VideoWriter writer;
	int videonumber = 0;
	string filename = "video"; //filename string
	string fileext = ".avi";
	int fcc = CV_FOURCC('D', 'I', 'V', '3'); //fourcc integer
	int fps = 20; //fps integer
	cv::Size frameSize(cap.get(CV_CAP_PROP_FRAME_WIDTH), cap.get(CV_CAP_PROP_FRAME_HEIGHT)); //frame size

	//RECORDING LOOP
	while (1) {

		if (startNewRecording) { //initialize a new recording
			startNewRecording = false;
			recording = true;

			videonumber++;
			writer.open((filename + to_string(videonumber) + fileext), fcc, fps, frameSize);

			if (!writer.isOpened()){
				cout << "ERROR OPENING FILE FOR WRITE" << endl;
				getchar();

				return -1;
			}
		}

		Mat frame;

		bool bSuccess = cap.read(frame); // read a new frame from camera feed

		if (!bSuccess) //test if frame successfully read
		{
			cout << "ERROR READING FRAME FROM CAMERA FEED" << endl;
			break;
		}

		if (recording) {
			writer.write(frame);
			putText(frame, "REC", Point(0,60),2,2,Scalar(0,0,255));
		}

		imshow(windowName, frame); //show the frame in "MyVideo" window
		

		//listen for 10ms for a key to be pressed
		switch (waitKey(10)){

		case 114:

			recording = !recording; //toggle recording

			break;


		case 110:

			//start new recording
			startNewRecording = true;
			break;


		case 27:
			//'esc' has been pressed (ASCII value for 'esc' is 27)
			//exit program.
			writer.release();
			return 0;

		}


	}

	return 0;
}

