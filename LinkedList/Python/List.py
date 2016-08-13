# Name: List.py
# Author: Matt Nitzken
# Description: Single linked list class.

#Node class
class Node(object):

    #Function to initialize a new Node
    def __init__(self, data = None, next = None):
        self.data = data
        self.next = next

    #Function to retrieve the data of a node
    def GetData(self):
        return self.data

    #Function to retrieve the connected node
    def GetNext(self):
        return self.next

#List class
class List(object):

    #Function to initialize a new List
    def __init__(self, head = None):
        self.head = head

    #Function to add a node to the list
    def AddNode(self, data = None):
        n = Node(data)
        curr = self.head
        
        if curr is None:
            self.head = n
        else:
            while curr.next is not None:
                curr = curr.next

            curr.next = n

    #Function to delete a node from the list
    def DeleteNode(self, data = None):
        prev = None
        curr = self.head

        while (curr.next is not None) and (curr.data != data):
            prev = curr
            curr = curr.next

        if curr is None:
            print "The value " + str(data) + " was not in the list"

        else:
            if prev is None:
                self.head = self.head.next
            else:
                prev.next = curr.next
            print "The value " + str(data) + " was deleted"

    #Function to print the list
    def PrintList(self):
        curr = self.head
        while curr is not None:
            print str(curr.GetData())
            curr = curr.next

    #Function to iteratively reverse the list
    def ReverseList(self):
        prev = None
        curr = self.head

        while curr is not None:
            nxt = curr.next
            curr.next = prev
            prev = curr
            curr = nxt
            
        self.head = prev
