#include "stdafx.h"
#include "TimeTrack.h"

using namespace std;

TimeTrack::TimeTrack() {
	idx = 0;
}

void TimeTrack::start(){

	timestore.clear();
	tracker = clock();
	timestore.push_back(tracker);
}

void TimeTrack::flag(){
	tracker = clock();
	timestore.push_back(tracker);
}

void TimeTrack::Reset(){
	idx = 0;
}

int TimeTrack::nextElapsed() {
	idx++;
	if (idx < timestore.size()) {
		return timestore.at(idx) - timestore.at(idx - 1);
	}
	return -1;
}

int TimeTrack::nextAbsElapsed() {
	idx++;
	if (idx < timestore.size()) {
		return timestore.at(idx) - timestore.at(0);
	}
	return -1;
}

int TimeTrack::getElapsed(unsigned _idx) {
	if (_idx < timestore.size() && _idx > 0) {
		return timestore.at(_idx) - timestore.at(_idx - 1);
	}
	return -1;
}

int TimeTrack::getAbsElapsed(unsigned _idx) {
	if (_idx < timestore.size() && _idx > 0) {
		return timestore.at(_idx) - timestore.at(0);
	}
	return -1;
}