//!  TimeTrack class. 
/*!
Author: Matt Nitzken
Description: Store time positioning elements
*/

#include <vector>
#include <time.h>

#ifndef TIMETRACK
#define TIMETRACK

class TimeTrack {

private:
	//private variables
	vector<int> timestore;
	clock_t tracker;
	unsigned idx;

public:
	//constructor
	TimeTrack();

	//methods
	void start();
	void flag();

	void Reset();
	int nextElapsed();
	int nextAbsElapsed();
	int getElapsed(unsigned _idx);
	int getAbsElapsed(unsigned _idx);
};

#endif // !SKELETONANALYZER