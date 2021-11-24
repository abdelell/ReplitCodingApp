//
//  UserDefaultsFirstTime.swift
//  ReplitCodingApp
//
//  Created by user on 11/24/21.
//

import Foundation

extension UserDefaultsManager {
    static func isFirstTime() {
        let firstTime = defaults.object(forKey: "isFirstTime") as? Bool ?? false
        
        guard !firstTime else {
            return
        }
        
        defaults.setValue(true, forKey: "isFirstTime")
        
        let classCode =
        """
        class Parent:

            id = 0

            def __init__(self, k):
                print("I'm parent.")
                self.id = k

            def update(self, num):
                self.id = self.id + num

            def get(self):
                return self.id

        class Child(Parent):

            def __init__(self, k):
                print("I'm child.")
                self.id = k

            def update(self, num):
                self.id = self.id * num

        parent = Parent(5)
        parent.update(2)
        print(parent.get())

        child = Child(5)
        child.update(2)
        print(child.get())

        print(Child.id)
        
        """
        
        let classCode2 =
        """
        class Person:
            "This is a person class"
            age = 10

            def greet(self):
                print('Hello')


        # create a new object of Person class
        harry = Person()

        # Output: <function Person.greet>
        print(Person.greet)

        # Output: <bound method Person.greet of <__main__.Person object>>
        print(harry.greet)

        # Calling object's greet() method
        # Output: Hello
        harry.greet()
        """
        
        let fibSequenceCode =
        """
        # function to display the Fibonacci sequence up to n-th term

        def fibSequence(nterms):

        # first two terms
          n1 = 0
          n2 = 1
          count = 0

         # check if the number of terms is valid
          if nterms == 1:
            print("Fibonacci sequence upto",nterms,":")
            print(n1)
        # generate fibonacci sequence
          else:
            print("Fibonacci sequence:")
            while count < nterms:
              print(n1)
              nth = n1 + n2
        # update values
              n1 = n2
              n2 = nth
              count += 1


        """
        let playgrounds = [
            Playground(id: "\(UUID())", title: "Class Example", code: classCode),
            Playground(id: "\(UUID())", title: "Class Example 2", code: classCode2),
            Playground(id: "\(UUID())", title: "Fibonacci Sequence", code: fibSequenceCode)
        ]
        
        
        playgrounds.forEach { playground in
            addPlayground(playground: playground)
        }
    }
}
