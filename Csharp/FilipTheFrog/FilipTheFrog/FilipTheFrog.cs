//	File: FilipTheFrog.cs
//	Author: Matt Nitzken
//	<summary>
//		Class file for FilipTheFrog.
//	</summary>
namespace FilipTheFrogNS
{
	using System;

	/// <summary>
    /// A class that will solve the Filip The Frog algorithm.
    /// </summary>
    public static class FilipTheFrog
    {
        /// <summary>
        /// The main function will be used to test the algorithm.
        /// </summary>
        public static void Main()
        {
            int[] positionTest1 = new int[5] { 4, 7, 1, 3, 5 };
            int jumpDistanceTest1 = 1;
            Console.WriteLine(CountReachableIslands(positionTest1, jumpDistanceTest1));

            int[] positionTest2 = new int[5] { 100, 101, 103, 105, 107 };
            int jumpDistanceTest2 = 2;
            Console.WriteLine(CountReachableIslands(positionTest2, jumpDistanceTest2));

            int[] positionTest3 = new int[8] { 17, 10, 22, 14, 6, 1, 2, 3 };
            int jumpDistanceTest3 = 4;
            Console.WriteLine(CountReachableIslands(positionTest3, jumpDistanceTest3));

            int[] positionTest4 = new int[1] { 0 };
            int jumpDistanceTest4 = 1000;
            Console.WriteLine(CountReachableIslands(positionTest4, jumpDistanceTest4));
        }

        /// <summary>
        /// Count the number of islands that Filip can reach.
        /// </summary>
        /// <param name="positions">The positions of each island.</param>
        /// <param name="jumpDistance">The distance Filip can jump.</param>
        /// <returns>The number of islands that Filip can reach.</returns>
        public static int CountReachableIslands(int[] positions, int jumpDistance)
        {
            if (positions == null)
            {
                throw new ArgumentNullException("positions");
            }

            int numberOfIslandsReached = 1;
            int startingPosition = 0;
            int startingPositionValue = positions[0];

            //Sort the islands
            Array.Sort(positions);

            //Find where the starting island has moved to
            int count = 0;
            foreach (int i in positions)
            {
                if (i == startingPositionValue)
                {
                    startingPosition = count;
                    break;
                }

                count++;
            }

            //Examine islands moving forward from starting position
            for (int i = startingPosition; i < positions.Length - 1; i++)
            {
                if ((positions[i + 1] - positions[i]) <= jumpDistance)
                {
                    numberOfIslandsReached++;
                }
                else
                {
                    break;
                }
            }

            //Examine islands movign backwards from starting position
            for (int i = startingPosition; i > 0; i--)
            {
                if ((positions[i] - positions[i - 1]) <= jumpDistance)
                {
                    numberOfIslandsReached++;
                }
                else
                {
                    break;
                }
            }

            return numberOfIslandsReached;
        }
    }
}