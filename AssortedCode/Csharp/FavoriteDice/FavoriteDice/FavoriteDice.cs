//	File: FavoriteDice.cs
//	Author: Matt Nitzken
//	<summary>
//		Class file for FavoriteDice.
//	</summary>

namespace FavoriteDiceNS
{
	using System;

	/// <summary>
    /// Solution to the FavoriteDice Problem on SPOJ.
    /// </summary>
    public static class FavoriteDice
    {
        /// <summary>
        /// The main function is used for testing the FavoriteDice Problem.
        /// </summary>
        public static void Main()
        {
            //A test case for N = 1.
            Console.WriteLine(DetermineNumberOfThrows(1));

			//A test case for N = 12.
            Console.WriteLine(DetermineNumberOfThrows(12));
        }

        /// <summary>
        /// Determine the number of throws that will be required to test all sides of the die.
        /// </summary>
        /// <param name="diceSides">The number of sides on the dice.</param>
        /// <returns>Return the number of throws required.</returns>
        public static double DetermineNumberOfThrows(double diceSides)
        {
            double numbberOfThrows = 0;

            for (int i = 1; i <= diceSides; i++)
            {
                numbberOfThrows += (double)diceSides / (double)i;
            }

            return numbberOfThrows;
        }
    }
}
