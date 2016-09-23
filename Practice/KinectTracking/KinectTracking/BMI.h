//windows header files
#include "stdafx.h"
#include <iomanip>

using namespace std;

#ifndef BMI
#define BMI

struct BMI{

	double GetImperial(double weight, double height) {
		double bmi = (weight * 703) / pow(height, 2);
		return ceil(bmi * 10) / 10;
	}

	double GetMetric(double weight, double height) {
		double bmi = ((weight) / pow(height, 2) * 10000);
		return ceil(bmi * 10) / 10;
	}

	string GetStatus(double bmi) {
		if (bmi < 18.5)
		{
			return "Underweight";
		}
		else if (bmi > 18.50 & bmi < 24.9)
		{
			return "Normal";
		}
		else if (bmi > 25 & bmi < 29.9)
		{
			return "Overweight";
		}
		else if (bmi > 30)
		{
			return "Obese";
		}
	}
};

#endif // !VECTOR3