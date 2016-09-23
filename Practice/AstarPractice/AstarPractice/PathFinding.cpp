#include "PathFinding.h"

PathFinding::PathFinding(void) {
	m_initializeStartGoal = false;
	m_foundGoal = false;
}
PathFinding::~PathFinding(void) {

}

void PathFinding::FindPath(Vector3 currentPos, Vector3 targetPos) {

	if (!m_initializeStartGoal) {
		//clear openlist
		for (int i = 0; i < m_openList.size(); ++i) {
			delete m_openList[i];
		}
		m_openList.clear();

		//clear visitedlist
		for (int i = 0; i < m_visitedList.size(); ++i) {
			delete m_visitedList[i];
		}
		m_visitedList.clear();

		//clear pathtogoal
		for (int i = 0; i < m_pathToGoal.size(); ++i) {
			delete m_pathToGoal[i];
		}
		m_pathToGoal.clear();

		//Initialize start
		SearchCell start;
		start.m_xcoord = currentPos.x;
		start.m_zcoord = currentPos.z;

		SearchCell goal;
		goal.m_xcoord = targetPos.x;
		goal.m_zcoord = targetPos.z;

		SetStartAndGoal(start, goal);
		m_initializeStartGoal = true;
	}
	if (m_initializeStartGoal){
		ContinuePath();
	}
}

void PathFinding::SetStartAndGoal(SearchCell start, SearchCell goal) {
	m_startCell = new SearchCell(start.m_xcoord, start.m_zcoord, NULL);
	m_goalCell = new SearchCell(goal.m_xcoord, goal.m_zcoord, &goal);

	m_startCell->G = 0;
	m_startCell->H = m_startCell->ManhattanDistance(m_goalCell);
	m_startCell->parent = 0;

	m_openList.push_back(m_startCell);
}

SearchCell *PathFinding::GetNextCell(){

	float bestF = 999999.0f;
	int cellIndex = -1;
	SearchCell* nextCell = NULL;

	for (int i = 0; i < m_openList.size(); ++i) {
		if (m_openList[i]->GetF < bestF) {
			bestF = m_openList[i]->GetF;
			cellIndex = i;
		}
	}

	if (cellIndex >= 0) {
		nextCell = m_openList[cellIndex];
		m_visitedList.push_back(nextCell);
		m_openList.erase(m_openList.begin + cellIndex);
	}

	return nextCell;

}

void PathFinding::PathOpened(int x, int z, float newCost, SearchCell *parent) {

	//check for blocks

	int id = z * WORLD_SIZE + x;
	for (int i = 0; i < m_visitedList.size(); ++i) {
		if (id == m_visitedList[i]->m_id) {
			return;
		}
	}

	SearchCell *newChild = new SearchCell(x, z, parent);
	newChild->G = newCost;
	newChild->H = parent->ManhattanDistance(m_goalCell);

	for (int i = 0; i < m_openList.size(); ++i) {
		if (id == m_openList[i]->m_id) {
			float newF = newChild->G + newCost + m_openList[i]->H;

			if (m_openList[i]->GetF() > newF) {
				m_openList[i]->G = newChild->G + newCost;
				m_openList[i]->parent = newChild;
			}
			else { //if F is not better
				delete newChild;
				return;
			}
		}
	}

	m_openList.push_back(newChild);
}

void PathFinding::ContinuePath() {
	if (m_openList.empty())
	{
		return;
	}

	SearchCell *currentCell = GetNextCell();
	if (currentCell->m_id == m_goalCell->m_id) {
		m_goalCell->parent = currentCell->parent;

		SearchCell *getPath;
		for (getPath = m_goalCell; getPath != NULL; getPath = getPath->parent) {
			m_pathToGoal.push_back(SearchCell(getPath->m_xcoord, getPath->m_zcoord, NULL));
		}
	}
}