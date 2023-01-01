
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
| ✅ [Day 3: Rucksack Reorganization](https://adventofcode.com/2022/day/3)|⭐️|⭐️|
| ✅ [Day 4: Camp Cleanup](https://adventofcode.com/2022/day/4)|⭐️|⭐️|
| ✅ [Day 5: Supply Stacks](https://adventofcode.com/2022/day/5)|⭐️|⭐️|
| ✅ [Day 6: Tuning Trouble](https://adventofcode.com/2022/day/6)|⭐️|⭐️|
| ✅ [Day 7: No Space Left On Device](https://adventofcode.com/2022/day/7)|🌵|🌵|
| ✅ [Day 8: Treetop Tree House](https://adventofcode.com/2022/day/8)|⭐️|⭐️|
| ✅ [Day 9: Rope Bridge](https://adventofcode.com/2022/day/9)|⭐️|🌵|
| ✅ [Day 10: Cathode-Ray Tube](https://adventofcode.com/2022/day/10)|⭐️|⭐️|
| ✅ [Day 11: Monkey in the Middle](https://adventofcode.com/2022/day/11)|⭐️|⭐️|
| ✅ [Day 12: Hill Climbing Algorithm](https://adventofcode.com/2022/day/12)|🌵|🌵|
| ✅ [Day 13: Distress Signal](https://adventofcode.com/2022/day/13)|🌵|🌵| 
| ✅ [Day 14: Regolith Reservoir](https://adventofcode.com/2022/day/14)|🌵|🌵| 
| ✅ [Day 15: Beacon Exclusion Zone](https://adventofcode.com/2022/day/15)|🌵|🌵|  
| ✅ [Day 16: Proboscidea Volcanium](https://adventofcode.com/2022/day/16)|🌵|🌵| 
| ✅ [Day 17: Pyroclastic Flow](https://adventofcode.com/2022/day/17)|🌵|🌵| 
| ✅ [Day 18: Boiling Boulders](https://adventofcode.com/2022/day/18)|🌵|🌵| 
| ✅ [Day 19: Not Enough Minerals](https://adventofcode.com/2022/day/19)|🌵|🌵| 
| ✅ [Day 20: Grove Positioning System](https://adventofcode.com/2022/day/20)|🌵|🌵| 
| ✅ [Day 21: Monkey Math](https://adventofcode.com/2022/day/21)|🌵|🌵| 
| ✅ [Day 22: Monkey Map](https://adventofcode.com/2022/day/22)|🌵|🌵| 
| ✅ [Day 23: Unstable Diffusion](https://adventofcode.com/2022/day/23)|🌵|🌵| 
| ✅ [Day 24: Blizzard Basin](https://adventofcode.com/2022/day/24)|🌵|🌵| 
| ✅ [Day 25: Full of Hot Air](https://adventofcode.com/2022/day/25)|🌵|🌵| 

## Preparing the environment  

Something I like to try every year, even this year I am traveling and dont have access to a mac and will not have as much time but will do my best!  

I will do the challenges in [replit.com](https://replit.com/@multiwheel)  
[Last year](https://github.com/multitudes/AdventOfCode2021/blob/main/README.md) I did the challenges in the Swift command line.  

## Advent of Code 2022 Story

Santa's reindeer typically eat regular reindeer food, but they need a lot of magical energy to deliver presents on Christmas. For that, their favorite snack is a special type of star fruit that only grows deep in the jungle. The Elves have brought you on their annual expedition to the grove where the fruit grows.

To supply enough magical energy, the expedition needs to retrieve a minimum of fifty stars by December 25th. Although the Elves assure you that the grove has plenty of fruit, you decide to grab any fruit you see along the way, just in case.

Collect stars by solving puzzles. Two puzzles will be made available on each day in the Advent calendar; the second puzzle is unlocked when you complete the first. Each puzzle grants one star. Good luck!

# A sort of diary

## Day 1 
Day 1 is always kinda of easy. Good to troubleshoot the system :)  

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

This challenge is ideal to work with ClosedRange. I need an extra method though. I wrote an extension to check wether the one is contained in the other.
```swift
extension ClosedRange {
    func contains(other: ClosedRange) -> Bool {
        lowerBound <= other.lowerBound && 
        upperBound >= other.upperBound
    }
}
```

Then the rest is just about decoding and splitting. I get my input lines as substrings and   
need converting from a substring like "2-4" to a ClosedRange instance such as 2...4

```swift

var input = contents.split(separator: "\n", omittingEmptySubsequences: true)

// Closed Ranges at the rescue!
// https://developer.apple.com/documentation/swift/closedrange

// got a line in input and get two closed ranges
func createTwoClosedRanges(from line: Substring) -> (ClosedRange<Int>,ClosedRange<Int>)? {
   let stringRanges: [Substring] = line.split(separator: ",")
   guard stringRanges.count == 2 else {return nil}
   if let firstClosedRange = createClosedRange(from: stringRanges.first!) , let secondClosedRange = createClosedRange(from: stringRanges.last!)  {
   return (firstClosedRange, secondClosedRange) }
  return nil
}

// Convenience function converting from a substring like "2-4" to a ClosedRange instance such as 2...4
func createClosedRange(from stringRange: Substring) -> ClosedRange<Int>? {
  let bounds = stringRange.split(separator: "-")
  guard bounds.count == 2 else {return nil }
  if let lower = Int(bounds.first!), let upper = Int(bounds.last!) {
    return lower...upper
  } 
  return nil
} 

let inputRanges: [(ClosedRange<Int>,ClosedRange<Int>)] = input.compactMap { line in
           createTwoClosedRanges(from: line) }

// The function returns one if one of the ranges is contained in the other.
func rangeIsContained(first: ClosedRange<Int>, second: ClosedRange<Int>) -> Int {
    if first.contains(other: second) ||                              second.contains(other: first) {  
        return 1 }         
    return 0  
}

let solution1 = inputRanges
    .map {(first,second) in
      rangeIsContained(first: first, second: second)}
    .reduce(0,+)
```
And part 2 is similar, but I get the overlap method for free.

```swift
func checkOverlaps(first: ClosedRange<Int>, second: ClosedRange<Int>) -> Int {
   if first.overlaps(second) ||                                     second.overlaps(first) {  
        return 1 }         
    return 0  
}
let solution2 = inputRanges
    .map {(first,second) in
      checkOverlaps(first: first, second: second)}
    .reduce(0,+)
```

## Day 5

Helpfully this challenge has stack in its name. So I will start by creating some stacks :)  
```swift
// create a data structure to emulate stacks
// and then update it for part 2 
struct Stack {
  fileprivate var array:[String] = []

  init(_ array: [String]) {
    self.array = array 
  }
  
  init() {}
  
  mutating func push(_ element: String) {
    array.append(element)
  }

  // This one is for part 2 with craneMover9001!
  mutating func push(_ element: [String]) {
    array += element
  }

  mutating func pop() -> String? {
    return array.popLast()
  }

  // This one is for part 2 with craneMover9001!
  mutating func pop(_ number: Int) -> [String]? {
    let removed = Array(array.suffix(number))
    array.removeLast(number)
    return removed
  }
  
  func peek() -> String? {
    return array.last
  }
}
```
I like to create a dictionary for the input stacks:
```swift
var testStacksdic: [Int: Stack] = [
                        1:Stack(["Z","N"]),
                        2:Stack(["M","C","D"]),
                        3:Stack(["P"])]
                        
// the main puzzle
var stacksdict: [Int: Stack] = [
    1:Stack(["S", "Z", "P", "D", "L", "B", "F", "C"]),
    2:Stack(["N","V","G", "P", "H", "W", "B"]),
    3:Stack(["F", "W", "B", "J", "G"]),
    4:Stack(["G", "J", "N", "F", "L", "W", "C", "S"]),
    5:Stack(["W", "J", "L", "T", "P", "M", "S", "H"]),
    6:Stack(["B", "C", "W", "G", "F", "S"]),
    7:Stack(["H", "T", "P", "M", "Q", "B", "W"]),
    8:Stack(["F", "S", "W", "T"]),
    9:Stack(["N", "C", "R"])
]

// My move function for part 1 and updated for part 2 with the cratemover 9001
func move(numberOfCrates: Int,
          from currentStackNumber: Int,
          to otherStackNumber: Int,
          type9001: Bool = false) {
  var current = stacksdict[currentStackNumber] ?? Stack()
  var other = stacksdict[otherStackNumber] ?? Stack()
  if type9001 {
    let crates = current.pop(numberOfCrates) ?? []
    other.push(crates) 
    print("crates", crates)
  } else {
    for _ in 1...numberOfCrates {
      if let crate = current.pop() {
          other.push(crate) 
          print(crate)
      }
    }
  }
  // popping element is fine but the dict needss to 
  // be updated as well !
  stacksdict[currentStackNumber] = current 
  stacksdict[otherStackNumber] = other
}

```
and my input is straight away converted from a string to an array of tuples like this `[(move: Int, from: Int, to: Int)]`.  
The code for this is trivial. I split and tokenize each line of the input with a compactMap function (not map because I consider the conversion to be failable and I keep the optional in case something goes wrong :)  
Code will be like `.compactMap { line -> (Int,Int,Int)? in ... }

for part 1:
```swift
let _ = input.map { line in
  move(numberOfCrates: line.move, 
       from: line.from, to: line.to)
}
```
for part 2:
```swift
let _ = input.map { line in
  move(numberOfCrates: line.move, 
       from: line.from, to: line.to, type9001: true)
}
```
## Day 6
This was very easy. 
Part 1:
```swift
var inSync = false
var i = 0
var tempBuffer: [String] = []

while !inSync {
  let char = String(datastreamBuffer[i])
  if !tempBuffer.contains(char) {
    tempBuffer.append(char)
    print("buffer ", tempBuffer, "char ", char)
    tempBuffer.count == 4 ? (inSync = true) : (inSync = false) 
  } else {
    print("buffer ", tempBuffer, "char ", char)
    if let index = tempBuffer.firstIndex(of: char) {
    tempBuffer.removeFirst(index+1)  
      tempBuffer.append(char)
    }
  }
  i += 1
}
print("solution ", i)
```
Part 2 I will just change the line `tempBuffer.count == 4` to `tempBuffer.count == 14`!  

## Day 6
Very short code today. I chose to do a simple while loop. An iterator would probably have been a more sophisticated option.  
Basically the buffer does not care about the length of the input signal, therefore a while loop seems the way to go. Feels too easy but it works.

```swift
let datastreamBuffer = Array("mjqjpqmgbljsphdztnvjfqwrcgsmlb ... ")

var inSync = false
var i = 0
var tempBuffer: [String] = []

while !inSync {
  let char = String(datastreamBuffer[i])
  if !tempBuffer.contains(char) {
    tempBuffer.append(char)
    tempBuffer.count == 14 ? (inSync = true) : (inSync = false) 
  } else {
    if let index = tempBuffer.firstIndex(of: char) {
    tempBuffer.removeFirst(index+1)  
      tempBuffer.append(char)
    }
  }
  i += 1
}
print("solution ", i)
```

## Day 8
Fairly easy but easy to overccomplicate the answers. At first I was concerned with the performance and tried to minimise the loops using a second map where I enter the results that are already know like a sort of cache. Turn out that this was not needed and also when I read part 2 I realised that this was the wrong approach.  
I really needed to go to every tree on the map O(N^2) and from there look in all directions if I am visible..  
I made 4 functions called `checkWest`, `checkEast` etc. with a while loop with an early exit if the tree is not visible. Also at the same time I check the scenic score.

```swift
// convenience variables
var lastRow = contents[0].count - 1
var lastCol = contents.count - 1

// I use a tuple as return value to have the answers both for
// part 1 and 2
func checkWest(row: Int, col: Int) -> (isVisible: Bool, scenicScore:Int) {
  if col == 0 { return (true, 0) }
  var index = col; var scenicScore = 0
  while (index > 0) {
    scenicScore += 1; index -= 1
    // early exit if the contents of the new position are 
    // bigger or equal of the tree in consideration
    // this will be valid for part 2 as well - the scenic score 
    // will not be increased
    if (contents[row][col] <= contents[row][index]) {
      return (false, scenicScore)
    }
  }
  // finishing the loop and going all the way without finding 
  // taller trees I return that the tree is visible and the score
  return (true, scenicScore)
}

// [...]


// convenience function to test the code
func checkScores(row: Int, col: Int) -> (visible: Bool, scenicScore: Int) {
      var scenicScore = 0; var isVisibleTree: Bool = false
      let east = checkEast(row: row, col: col)
      let west = checkWest(row: row, col: col)
      let north = checkNorth(row: row, col: col)
      let south = checkSouth(row: row, col: col) 
      //calculating part of the solution for part 1
      if east.isVisible || west.isVisible || north.isVisible || south.isVisible {
        isVisibleTree = true
      }
      //calculating part of the solution for part 2
      scenicScore = east.scenicScore * west.scenicScore * north.scenicScore * south.scenicScore
     return (visible: isVisibleTree, scenicScore: scenicScore)
}


// looping over every position of the map
for i in 0..<contents.count {
    for k in 0..<contents[0].count {
      var scenicScore = 0
      let scores = checkScores(row: i, col: k)
      //solution for part 1
      if scores.visible {
        visibleTrees += 1
      }
      //solution for part 2
      scenicScore = scores.scenicScore
      if scenicScore > totalScenicScore {
        totalScenicScore = scenicScore
      }
    }
  }

print("solution 1", visibleTrees)
print("solution 2", totalScenicScore)


```

## Day 9

## Day 10
I did a while loop simulating the cycles and for part 1 I check the signal strength at certain cycles. Not difficult but I could not resist skipping a cycle for the addx instruction. (incrementing the cycles count by 2 instead by 1! :)  
For part 2 I had to change that! so I used a flag to indicate that addx is two cycles long of course but I need every cycle now!  

Part of the fun was to synchronise the ray with the pixels and the values... 
like Eric said:"So, by carefully timing the CPU instructions and the CRT drawing operations, you should be able to determine whether the sprite is visible the instant each pixel is drawn. If the sprite is positioned such that one of its three pixels is the pixel currently being drawn, the screen produces a lit pixel (#); otherwise, the screen leaves the pixel dark (.). "

Good fun!

```swift
while cycles <= maxCycles {
  //check the signal strength for solution part 1
  // if the cycle is not one of the below the result is 0
  func checkSignalStrength() -> Int {
   if cyclesToCheckForSignalStrength.contains(cycles) {
        return X * cycles
   }   
   return 0
  }

  // for part 2 this will get the pixel to write on the screen
  // the parameter of the functions are the cycles number and X 
  // and the row number which are being updated during the loop
  func getPixel() -> String {
    // The sprite is three pixel and X is the middle pixel therefore:
    let sprite: ClosedRange = X-1...X+1   
    // cycles needs to be adjusted because they start from 1 
    // while the sprites and pixel from 0 !! :)
    let currentPixel = cycles-1 - (CRTRow * 40)
    if sprite ~= currentPixel {
      return hash
    }
    return dot
  } 

  // part 2 - every 40 pixel the CRT starts a new row
  // this is to know which row I am in
  CRTRow = (cycles - 1) / CRTRowLength 
  // the write function 
  let pixel = getPixel()
  CRTScreen[CRTRow].append(pixel)
 
  // I keep iterating as long as I have instructions?
  if instrCnt < maxInstrCount {
    currentInstr = program[instrCnt]
  } else { break } 

  // first check the signal strength
  sumSignalStrengths += checkSignalStrength()
  
  switch currentInstr.instruction {
    // case 'noop' doesnt do anything to the value
    case "noop":
      // update the cycles and instruction counter
      cycles += 1
      instrCnt += 1
    case "addx":
    // addx has 2 cycle - I check the flag - 
    // if true I am in the second loop
    if addxFlag {
       // if flag is true I update the instruction counter
      instrCnt += 1
       // the 'addx' instruction adds the value
      X += currentInstr.value
      //reset the flag
      addxFlag = false
    } else {
      // I am in the first ADDX loop and change 
      // the flag to true for the next iteration - I do nothing here
      addxFlag = true
    }
      //  update the cycles
      cycles += 1

    default:
      print("illegal instruction")
  }
}

print("Solution 1", sumSignalStrengths)
print("Solution 2", "???")

for line in CRTScreen {
  print(line.joined(separator:""))
}
```

## Day 11  

Getting the data from the monkey input files is the first challenge. Swift 5.7 has a new Regex engine but the Replit.com playground has not yet upgraded to the new swift version. Using the old regex framework is monkey work! it would take quite a few hundred line of code. Since I have only a few monkeys I decided to extract the data manually.  
The second "ah ah" moment is realizing that in a loop like `for line in lines {}` the whole lines struct is actually copied and will not be updated anymore in later loops. I need to loop with indices only :)

## Day 12
A case of A* Pathfinding :)  
I made a class `Square` to populate my input map. A class because a struct would not allow me to have itself nested as parent. Probably it is possible to solve this challenge with a struct, but classes as reference type are easier to pass around and track when a struct would do a copy everytime.

The algorythm works like the dijkstra one with some difference. One is the optimisation with the heuristic parameter H which estimates the distance to the target.  
In the class below the H and G param are updated automatically.

```swift
// a class for A* pathfinding
public class Square: Hashable {
  private(set) var row: Int = 0
  private(set) var col: Int = 0
  // important to get the path back
  public var parent: Square? = nil
  
  public init(row: Int, col: Int, height: Int ) {
    self.row = row
    self.col = col
    self.height = height
  }

  let height: Int

  // G is the distance alreasy travelled. It is the G cost 
  // of the parent plus 1 
  var G: Int { (self.parent?.G ?? 0) + 1  }

  // H stays for "Heuristic" and tries to estimate 
  // the distance to E with the Manhattan method
  var H: Int {
    abs(endPosition.row - self.row) + 
    abs(endPosition.col - self.col)
  }

  // F is the sum of the Heuristic
  var F: Int { H + G }
  
  // need this to conform to hashable
  public static func ==(lhs: Square, rhs: Square) -> Bool {
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
  }
  
  public func hash(into hasher: inout Hasher) { 
    return hasher.combine(ObjectIdentifier(self))
  }
}
```
Also to find the best path I crucially update the parent of a square when I find a shorter path for it. I can see this with the G value which counts the distance from the start poin.  
I created two sets, called closed and open list. The closed list will not be taken into consideration again while the open one is the pool from which I pick up the best next square based on the sum of the heuristic prediction H and the distance from the start G.  

```swift

// add to open list and update parent if necessary
func addToOpenList(_ adjSquare: Square) {
   // check if the adj sq is already on the open list
   let result: (inserted: Bool, 
                memberAfterInsert: Square) = 
                  openList.insert(adjSquare)
    // if not on the open list I add me as parent
    if result.inserted {
       adjSquare.parent = currentSquare
    } else {
    // if on the open list already and I arrived to this
    // square from somewhere maybe shorter 
    // I check if my G value is better and if so
    // I update the adj sq and put myself as parent
    if currentSquare.G <= adjSquare.G   {
        adjSquare.parent = currentSquare
       } 
    }
}
```
The main function checks in all directions checking if the square is `walkable`
```swift
// check if walkable and if so add to open list
func walkable(_ adjSquare: Square) -> Bool {
  // check if in closed list - if so exit!
  if closedList.contains(adjSquare) {
    return false
  }
  // here I check that the height diff is not bigger than one
  if (adjSquare.height - currentSquare.height) <= 1  {
          return true
  } else { return false }
}
```

and updates the open list
```swift
// check the adjacent squares and add them to the open list
// also making the current square the parent of the adj square
func checkAdjacentSquaresUpdateOpenList() {
  // check up
  if inMapLimits(.up) {
    let adjSquare = map[currentSquare.row - 1][currentSquare.col] 
    if walkable(adjSquare) {
      addToOpenList(adjSquare)
      }
    }
  // check down
  if inMapLimits(.down) {
    let adjSquare = map[currentSquare.row + 1][currentSquare.col] 
    if walkable(adjSquare) {
      addToOpenList(adjSquare)
      }
  } 
  // check left
  if inMapLimits(.left) {
    let adjSquare = map[currentSquare.row][currentSquare.col - 1]
    if walkable(adjSquare) {
      addToOpenList(adjSquare)
      }
  } 
  // check right
  if inMapLimits(.right) {
    let adjSquare = map[currentSquare.row][currentSquare.col + 1]   
    if walkable(adjSquare) {
      addToOpenList(adjSquare)
      }
  } 
}
```

The main logic:  
```swift
while true {
  // get the current square from the open list
  // we choose the lowest F score square from all 
  // those that are on the open list. 
  if let bestOption = openList.min(by: { (a, b) -> Bool in
    return a.F < b.F }) {
    currentSquare = bestOption
    }
  
  // update the lists 
  openList.remove(currentSquare)
  closedList.insert(currentSquare)
  // check if summit
 if currentSquare.height == end && 
  currentSquare.row == endCoord.row &&
  currentSquare.col == endCoord.col  {
    //print("****************END**********\n")
    break
  }
// check the adj squares and update the open list
 checkAdjacentSquaresUpdateOpenList()
}
```

And counting the steps backward...
```swift
// Here I found my end square and count the steps back
counter = 0
while currentSquare.parent != nil {
  counter += 1
  currentSquare = currentSquare.parent! 
}
print("solution 1 ", counter)
```
