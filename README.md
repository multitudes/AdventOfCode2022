
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
| ✅ [Day 2: Rock Paper Scissors](https://adventofcode.com/2022/day/2)|🌵|🌵|
<!--
| ✅ [Day 3: Toboggan Trajectory](https://adventofcode.com/2020/day/3)|⭐️|⭐️|
| ✅ [Day 4: Passport Processing](https://adventofcode.com/2020/day/4)|⭐️|⭐️|
| ✅ [Day 5: Binary Boarding](https://adventofcode.com/2020/day/5)|⭐️|⭐️|
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

// here I split the input string by newline (keeping the empty strings!) then splitting on those empty strings (!) and getting a array of array slices which need to be converted to an array and then individually reduces to a sum. I sort to get the highest number of calories. 

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
