//	File: Program.cs
//	Author: Matt Nitzken
//	<summary>
//		Class file for Program.
//	</summary>
namespace DisplayTextFile
{
	using System;

	/// <summary>
    /// Program that will read a text file and print each line to the console.
    /// </summary>
    public static class Program
    {
        /// <summary>
        /// This is the main function that will read and display the file.
        /// </summary>
        public static void Main()
        {
            string filePath, lineInFile;

            Console.WriteLine(Properties.Resources.QueryPathPrompt);
            filePath = Console.ReadLine();

            if (System.IO.File.Exists(filePath))
            {
                using (System.IO.StreamReader fileToBeRead = new System.IO.StreamReader(filePath))
                {
                    while ((lineInFile = fileToBeRead.ReadLine()) != null)
                    {
                        Console.WriteLine(lineInFile);
                    }
                }
            }
            else
            {
                Console.WriteLine(Properties.Resources.ErrorPathDoesNotExist);
            }
        }
    }
}