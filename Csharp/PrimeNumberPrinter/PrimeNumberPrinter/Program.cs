//	File: Program.cs
//	Author: Matt Nitzken
//	<summary>
//		Class file for Program.
//	</summary>
namespace PrimeNumberPrinter
{
	/// <summary>
    /// Class to print all prime numbers from 1 to 100.
    /// </summary>
    public static class Program
    {
        /// <summary>
        /// The main method will display prime numbers from 1 to 100.
        /// </summary>
        public static void Main()
        {
            for (int number = 1; number <= 100; number++)
            {
                if (IsNumberPrime(number))
                {
                    System.Console.WriteLine(number);
                }
            }
        }

        /// <summary>
        /// Function to perform a test on a number and determine if it is prime.
        /// </summary>
        /// <param name="checkNumber">The number that will be checked to be prime.</param>
        /// <returns>Returns result of the prime test.</returns>
        public static bool IsNumberPrime(int checkNumber)
        {
            int index;

            if (checkNumber <= 1)
            {
                return false;
            }

            for (index = 2; index <= checkNumber / 2; index++)
            {
                if ((checkNumber % index) == 0)
                {
                    return false;
                }
            }

            return true;
        }
    }
}
