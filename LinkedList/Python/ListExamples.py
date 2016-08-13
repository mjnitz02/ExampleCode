# Name: ListExamples.py
# Author: Matt Nitzken
# Description: Example construction of a formal linked list implementation in Python.

#import externals
from List import List

#Examples
if __name__ == "__main__":
    #Create a test list
    TestList = List()

    #Fill list with information
    print "Original List"
    TestList.AddNode(0)
    TestList.AddNode(1)
    TestList.AddNode(2)
    TestList.AddNode(3)
    TestList.AddNode(4)
    TestList.PrintList()

    #Reverse the list
    print "Reversed List"
    TestList.ReverseList()
    TestList.PrintList()

    #Remove a middle element
    TestList.DeleteNode(2)
    TestList.PrintList()

    #Remove the list head
    TestList.DeleteNode(4)
    TestList.PrintList()

    #Remove the list tail
    TestList.DeleteNode(0)
    TestList.PrintList()
