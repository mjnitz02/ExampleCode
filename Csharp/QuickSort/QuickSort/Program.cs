//	File: Program.cs
//	Author: Matt Nitzken
//	<summary>
//		Class file for Program.
//	</summary>
namespace QuickSort
{
	using System;

	/// <summary>
    /// Implementation of QuickSort algorithm in C#.
    /// </summary>
    public static class Program
    {
        /// <summary>
        /// The main function for testing and running the QuickSort algorithm.
        /// </summary>
        public static void Main()
        {
            int[] values = { 2, 4, 1, 3, 6, 2, 1, 8, 9, 3 };

            foreach (int value in values)
            {
                Console.Write(value + Properties.Resources.SPACE);
            }

            Console.WriteLine();

            QuickSort(values); //perform the QuickSort.

            foreach (int value in values)
            {
                Console.Write(value + Properties.Resources.SPACE);
            }

            Console.WriteLine();
        }

        /// <summary>
        /// Quicksort Algorithm Interface Function.
        /// </summary>
        /// <param name="array">Integer array to be sorted.</param>
        public static void QuickSort(int[] array)
        {
            if (array == null)
            {
                throw new ArgumentNullException("array");
            }

            QuickSort(array, 0, array.Length - 1);
        }

        /// <summary>
        /// Implementation of the QuickSort Algorithm.
        /// </summary>
        /// <param name="array">Integer array to be sorted.</param>
        /// <param name="left">Left index of the partition.</param>
        /// <param name="right">Right index of the partition.</param>
        private static void QuickSort(int[] array, int left, int right)
        {
            int indexLeft = left, indexRight = right;
            int pivot = array[(left + right) / 2];
 
            while (indexLeft <= indexRight)
            {
                while (array[indexLeft] < pivot)
                {
                    indexLeft++;
                }
 
                while (array[indexRight] > pivot)
                {
                    indexRight--;
                }
 
                if (indexLeft <= indexRight)
                {
                    Swap<int>(ref array[indexLeft], ref array[indexRight]);
 
                    indexLeft++;
                    indexRight--;
                }
            }
 
            if (left < indexRight)
            {
                QuickSort(array, left, indexRight);
            }
 
            if (indexLeft < right)
            {
                QuickSort(array, indexLeft, right);
            }
        }

        /// <summary>
        /// Swap two variables by reference.
        /// </summary>
        /// <typeparam name="T">Type Template.</typeparam>
        /// <param name="a">First variable.</param>
        /// <param name="b">Second Variable.</param>
        private static void Swap<T>(ref T a, ref T b)
        {
            T temp = a;
            a = b;
            b = temp;
        }
    }
}
