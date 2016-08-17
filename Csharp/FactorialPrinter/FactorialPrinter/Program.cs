//	File: Program.cs
//	Author: Matt Nitzken
//	<summary>
//		Class file for Program.
//	</summary>
namespace FactorialPrinter
{
	/// <summary>
    /// Class to calculate and print factorials of numbers from 0 to 100.
    /// </summary>
    public static class Program
    {
        /// <summary>
        /// Calculate the factorial of a number using dynamic programming and
        /// display the result in the console window.
        /// </summary>
        public static void Main()
        {
            System.Numerics.BigInteger number = 1;

            for (System.Numerics.BigInteger index = 1; index <= 100; index++)
            {
                number *= index;
                System.Console.WriteLine(number);
            }
        }
    }
}