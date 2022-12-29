import Foundation

// I make the Monkeys by hand because the Replit.com has 
// only the old version of Swift and doesnt have the new 
// regex of Swift 5.7! It is so cumbersome to use the old one
// just for a couple of monkeys and it would bring an extra 
// 200 line of code or more :) I will come back to this one 
// when I get my mac back. 
struct Monkey {
  var startingItems: [Int] = []
  var operation: String = "+"
  var operationValue: Int = 0
  var testDivisibleBy: Int = 0
  var monkeyIfTrue: Int = 0
  var monkeyIfFalse: Int = 0
  // this is being calculated in the program 
  var inspectedItems: Int = 0
}

var monkeys: [Monkey] = [Monkey(startingItems: [74, 73, 57, 77, 74], operation: "*", operationValue: 11, testDivisibleBy: 19, monkeyIfTrue: 6, monkeyIfFalse: 7),
                     Monkey(startingItems: [ 99, 77, 79], operation: "+", operationValue: 8,  testDivisibleBy: 2, monkeyIfTrue: 6, monkeyIfFalse: 0),
                        Monkey(startingItems: [ 64, 67, 50, 96, 89, 82, 82 ], operation: "+", operationValue: 1,  testDivisibleBy: 3, monkeyIfTrue: 5, monkeyIfFalse: 3),
                       Monkey(startingItems: [ 88 ], operation: "*", operationValue: 7,  testDivisibleBy: 17, monkeyIfTrue: 5, monkeyIfFalse: 4), 
                       Monkey(startingItems: [ 80, 66, 98, 83, 70, 63, 57, 66 ], operation: "+", operationValue: 4,  testDivisibleBy: 13, monkeyIfTrue: 0, monkeyIfFalse: 1), 
                         Monkey(startingItems: [ 81, 93, 90, 61, 62, 64 ], operation: "+", operationValue: 7,  testDivisibleBy: 7, monkeyIfTrue: 1, monkeyIfFalse: 4),
                         Monkey(startingItems: [69, 97, 88, 93], operation: "*old", operationValue: 0,  testDivisibleBy: 5, monkeyIfTrue: 7, monkeyIfFalse: 2),
                         Monkey(startingItems: [59, 80], operation: "+", operationValue: 6,  testDivisibleBy: 11, monkeyIfTrue: 2, monkeyIfFalse: 3)]

// test
var testMonkeys: [Monkey] = [Monkey(startingItems: [79, 98], operation: "*", operationValue: 19, testDivisibleBy: 23, monkeyIfTrue: 2, monkeyIfFalse: 3),
                     Monkey(startingItems: [54, 65, 75, 74], operation: "+", operationValue: 6,  testDivisibleBy: 19, monkeyIfTrue: 2, monkeyIfFalse: 0),
                        Monkey(startingItems: [79, 60, 97], operation: "*old", operationValue: 0,  testDivisibleBy: 13, monkeyIfTrue: 1, monkeyIfFalse: 3),
                       Monkey(startingItems: [ 74 ], operation: "+", operationValue: 3,  testDivisibleBy: 17, monkeyIfTrue: 0, monkeyIfFalse: 1)]

// testing
monkeys = testMonkeys
var round = 1
let monkeyCount = monkeys.count

while round <= 20 {
  print("\nround :", round, " --------------------\n")
print("monkey worry levels ", "\n")
  for i in 0..<monkeyCount {
    print("monkey \(i) worry levels ", monkeys[i].startingItems)
  }
  for index in 0..<monkeyCount {
      //print("monkey ", index, monkeys[index], "\n")
    for item in monkeys[index].startingItems {
      monkeys[index].inspectedItems += 1
      var worryLevel = item 
      monkeys[index].startingItems.removeFirst()
      switch monkeys[index].operation {
        case "+":
         worryLevel += monkeys[index].operationValue
         worryLevel /= 3
        case "*":
         worryLevel *= monkeys[index].operationValue
         worryLevel /= 3
        case "*old":
         worryLevel *= worryLevel
         worryLevel /= 3
        default:
        print("unknown op")
      }
      if worryLevel % monkeys[index].testDivisibleBy == 0 { 
monkeys[monkeys[index].monkeyIfTrue].startingItems.append(worryLevel)
      } else {
monkeys[monkeys[index].monkeyIfFalse].startingItems.append(worryLevel)
      }
    }
}
  round += 1
} 

// for part 1 
var monkeyBusinesses: [Int] = []
for i in 0..<monkeyCount {
  print("monkey \(i) inspected ", monkeys[i].inspectedItems)
  monkeyBusinesses.append(monkeys[i].inspectedItems)
}
monkeyBusinesses.sort(by: >)
let firstMonkeyBusiness = monkeyBusinesses.removeFirst() 
let secondMonkeyBusiness = monkeyBusinesses.removeFirst() 

let solutionPart1 =  firstMonkeyBusiness * secondMonkeyBusiness

print("solution Part 1: ", solutionPart1 ) //69918
