
[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg?style=plastic)](https://opensource.org/licenses/MIT)
[![Swift](https://img.shields.io/badge/Swift-5.7-red.svg?style=plastic&logo=Swift&logoColor=white)](https://www.swift.org/)
[![twitter](https://img.shields.io/badge/twitter-wrmultitudes-blue.svg?style=plastic&logo=twitter&logoColor=white)](https://twitter.com/wrmultitudes)
[![hashnode](https://img.shields.io/badge/hashnode-laurentbrusa-blue?style=plastic&logo=hashnode&logoColor=white)](https://laurentbrusa.hashnode.dev)

# Advent Of Code 2022 in Swift   
 
## What is Advent of Code?
[Advent of Code](http://adventofcode.com) is an online event created by [Eric Wastl](https://twitter.com/ericwastl). Each year an advent calendar of small programming puzzles is unlocked once a day, they can be solved in any programming language you like. 

## Progress
| Day  | Part One | Part Two |
|---|:---:|:---:|
| ✅ [Day 1: Calorie Counting](https://adventofcode.com/2022/day/1)|⭐️|⭐️|
| ✅ [Day 2: Rock Paper Scissors](https://adventofcode.com/2022/day/2)|⭐️|⭐️|
| ✅ [Day 3: Rucksack Reorganization](https://adventofcode.com/2022/day/3)|⭐️|🌵|
| ✅ [Day 4: Camp Cleanup](https://adventofcode.com/2022/day/4)|🌵|🌵|
| ✅ [Day 5: Supply Stacks](https://adventofcode.com/2022/day/5)|🌵|🌵|
<!--
| ✅ [Day 6: Custom Customs](https://adventofcode.com/2020/day/6)|⭐️|⭐️|
| ✅ [Day 7: Handy Haversacks](https://adventofcode.com/2020/day/7)|⭐️|⭐️|
| ✅ [Day 8: Handheld Halting](https://adventofcode.com/2020/day/8)|⭐️|⭐️|
| ✅ [Day 9: Encoding Error](https://adventofcode.com/2020/day/9)|⭐️|⭐️|
| ✅ [Day 10: Adapter Array](https://adventofcode.com/2020/day/10)|⭐️|⭐️|
| ✅ [Day 11: Seating System](https://adventofcode.com/2020/day/11)|⭐️|⭐️|
| ✅ [Day 12: Rain Risk](https://adventofcode.com/2020/day/12)|⭐️|⭐️|
| ✅ [Day 13: Shuttle Search](https://adventofcode.com/2020/day/13)|⭐️|⭐️| 
| ✅ [Day 14: Docking Data](https://adventofcode.com/2020/day/14)|⭐️|⭐️| 
| ✅ [Day 15: Rambunctious Recitation](https://adventofcode.com/2020/day/15)|⭐️|⭐️| 
| ✅ [Day 16: Ticket Translation](https://adventofcode.com/2020/day/16)|⭐️|⭐️| 
| ✅ [Day 17: Conway Cubes](https://adventofcode.com/2020/day/17)|⭐️|⭐️| 
| ✅ [Day 18: Operation Order](https://adventofcode.com/2020/day/18)|⭐️|⭐️|
| ✅ [Day 19: Monster Messages](https://adventofcode.com/2020/day/19)|⭐️|⭐️|
| ✅ [Day 20: Jurassic Jigsaw](https://adventofcode.com/2020/day/20)|🌵||
| ✅ [Day 21: Allergen Assessment ](https://adventofcode.com/2020/day/21)|⭐️|⭐️|
| ✅ [Day 22: Crab Combat](https://adventofcode.com/2020/day/22)|⭐️|⭐️|
| ✅ [Day 23: Crab Cups ](https://adventofcode.com/2020/day/23)|⭐️||
| ✅ [Day 24: Lobby Layout](https://adventofcode.com/2020/day/24)|🌵||
| ✅ [Day 25: Combo Breaker](https://adventofcode.com/2020/day/25)|🌵||

-->
## Preparing the environment
Something I like to try every year, even this year I am traveling and dont have access to a mac! 
I will do the challenges in [replit.com](https://replit.com/@multiwheel)  
[Last year](https://github.com/multitudes/AdventOfCode2021/blob/main/README.md) I did the challenges in the Swift command line.  


## Advent of Code 2022 Story

Santa's reindeer typically eat regular reindeer food, but they need a lot of magical energy to deliver presents on Christmas. For that, their favorite snack is a special type of star fruit that only grows deep in the jungle. The Elves have brought you on their annual expedition to the grove where the fruit grows.

To supply enough magical energy, the expedition needs to retrieve a minimum of fifty stars by December 25th. Although the Elves assure you that the grove has plenty of fruit, you decide to grab any fruit you see along the way, just in case.

Collect stars by solving puzzles. Two puzzles will be made available on each day in the Advent calendar; the second puzzle is unlocked when you complete the first. Each puzzle grants one star. Good luck!

# A sort of diary

## Day 1 
```swift
import Foundation

// get the content of the input as a string
var contents: String = ""
do {
   contents = try String(contentsOfFile: "input.txt", encoding: .utf8)
} catch {
  print(error.localizedDescription)
} 

// here I split the input string by newline (keeping the empty strings!) then splitting on those empty strings (!)   
// and getting a array of array slices which need to be converted to an array and then individually reduces to a sum.   
// I sort to get the highest number of calories. 

var input = contents
  .split(separator: "\n",omittingEmptySubsequences: false)
  .split(separator: "")
  .map { 
      Array($0)
        .reduce(0){$0 + (Int($1) ?? 0) }
  }.sorted(by: >)

// the hiest number of calories is the first one because they are sorted
let solution1 = input.first ?? 0

//var input = contents.split(separator: "")
print("solution part1 is: ", solution1)

// I just use prefix which is safe from out of bounds error! :) 
let solution2 = input.prefix(3).reduce(0,+) 
print("solution part2 is: ", solution2)
```

## Day 2
My [Replit](https://replit.com/@multiwheel/adventDay2#main.swift).  
I used enums and the power of tuples to do the challenge. It was a bit finnicky to enter all the rules to be honest :)   
The enums helped to make for clearer code. 

```swift
// magic numbers!
let draw = 3
let win = 6
let lose = 0


var contents = ""
var totalScorePart1: Int = 0
var totalScorePart2: Int = 0

// I get a string as input but I do not need the whitespace in 
// the middle... so I filter it out 
do {
  contents = try String(contentsOfFile: "input.txt", encoding: .utf8).filter {$0 != " "}
} catch {
  print(error.localizedDescription)
}

// A hand shape can be one of the three types rock, paper, scissors
enum HandShape: Int {
  // the handshapes have associated values as points
  // therefore I use a enum with associated values
  case rock = 1, paper = 2, scissors = 3, invalid = 0
  
  // I use a failable custom init to create the enum from one 
  // of the characters I get in the input. 
  init?(hand: Character) {
    switch hand {
      case "A", "X":
        self = .rock
      case "B", "Y":
       self = .paper
      case "C", "Z":
       self = .scissors
      default:
       return nil
    }
  }
}

// part 2! What I thought it would be my hand was just my strategy!
enum Strategy {
  case lose, draw, win, invalid
  
  // I use a failable custom init to create the enum from the 
  // right hand character I get in the input.  
  init?(strategy: Character) {
    switch strategy {
      case "X":
        self = .lose
      case "Y":
       self = .draw
      case "Z":
       self = .win
      default:
        self = .invalid
         return nil
    }
  }
}

// I choose to create the input as an arraay of tuples.
var input: [(leftHand: HandShape, rightHand: HandShape, strategy: Strategy)] = contents.split(separator: "\n", omittingEmptySubsequences: true)
  .map {
    // this converts my input line to chars
    let round: [Character] = Array($0)
    // I return a tuple. I added for part 2 the strategy... 
    return (HandShape(hand: round[0]) ?? .invalid,
            HandShape(hand: round[1]) ?? .invalid,
            Strategy(strategy: round[1]) ?? .invalid)
}

// This will evaluate the game for part 1
func evaluate(left: HandShape, right: HandShape) -> Int {
  switch (left, right) {
    // draw
    case (.rock, .rock), (.paper, .paper),(.scissors, .scissors):
      return draw + right.rawValue
    // I lose
    case (.rock, .scissors), (.paper, .rock),(.scissors, .paper):
      return lose + right.rawValue
    // I win
    case (.rock, .paper), (.paper, .scissors),(.scissors, .rock):
      return win + right.rawValue
    default:
      print("invalid!")
      return 0
  }
}

func evaluateUpdatedPart2(left: HandShape, strategy: Strategy) -> Int {
  switch strategy {
    
    // If I draw I get 3 plus the value of my hand 
    // which is the same of my opponent's
    case .draw:
      return left.rawValue + draw 
    
     // If I win I get 6 plus the value of my hand 
    case .win:
      if left == .rock { return  win + HandShape.paper.rawValue } 
      if left == .paper { return  win + HandShape.scissors.rawValue } 
      if left == .scissors { return  win + HandShape.rock.rawValue } 
    
     // If I lose I get 0 plus the value of my hand 
    case .lose:
      if left == .rock { return HandShape.scissors.rawValue } 
      if left == .paper { return HandShape.rock.rawValue } 
      if left == .scissors { return  HandShape.paper.rawValue } 

    case .invalid:
      print("invalid game!")
      return 0
  }
  return 0
}

for round in input {
  print(round)
  totalScorePart1 += evaluate(left: round.leftHand, right: round.rightHand)
  // this is for part 2
  totalScorePart2 += evaluateUpdatedPart2(left: round.leftHand, strategy: round.strategy)
}

print("total part 1 : ", totalScorePart1)
print("total part 2 : ", totalScorePart2)
```

## Day 3
My [Replit](https://replit.com/@multiwheel/adventDay3#main.swift).  
For part 2 I needed to chunk my array, but i cannot use the swift algo package in replit.. or I could but it is a bit convoluted! :)
Therefore I took this extension by Paul Hudson :)
```swift
// https://www.hackingwithswift.com/example-code/language/how-to-split-an-array-into-chunks
extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
```
This is the code after getting the contents of the file:

```swift
var input = contents.split(separator: "\n", omittingEmptySubsequences: true)

// create the priorities as a dictionary because N(1), so it has a better performance, just in case I need it!
let allItems: [Character] = Array("abcdefghijklmnopqrstuvwxyz" + "abcdefghijklmnopqrstuvwxyz".uppercased())
// good resource! 
// https://developer.apple.com/documentation/swift/dictionary/init(uniquekeyswithvalues:)
let priorities: [Character: Int] = Dictionary(uniqueKeysWithValues: zip(items, 1...items.count))


// **** Part 1 ****

// convenience function to get the two halves of the input string and get the intersection, my item
func getCommonItem(from items: String.SubSequence) -> Character {
    let halfLength  = items.count / 2
    let a = Set(items.prefix(halfLength))
    let b = Set(items.suffix(halfLength))
    return a.intersection(b).first! 
}

var solutionPart1 = input.map {items in
   getCommonItem(from: items)
  }.reduce(0) { $0 + (priorities[$1] ?? 0 )} 
      
print("Solution Part 1", solutionPart1)

// **** Part 2 ****
let chunkedInput = input.chunked(into: 3)
//print(chunkedInput)
var solutionPart2: Int = 0
for group in chunkedInput {
  guard group.count == 3 else { continue }
  let a = Set(group[0]); let b = Set(group[1]); let c = Set(group[2])
  if let common = a.intersection(b).intersection(c).first {
   solutionPart2 += priorities[common] ?? 0 
  }
}
print("Solution Part 2", solutionPart2)
```
## Day 4

## Day 5

## Day 6
