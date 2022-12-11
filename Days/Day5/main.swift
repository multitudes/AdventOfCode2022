
import Foundation

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

// move 
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

var testStacksdict: [Int: Stack] = [
                        1:Stack(["Z","N"]),
                        2:Stack(["M","C","D"]),
                        3:Stack(["P"])]

// ************ stack **********
var contents = ""

do {
  contents = try String(contentsOfFile: "input.txt", encoding: .utf8)
} catch {
  print(error.localizedDescription)
}

var input: [(move: Int, from: Int, to: Int)] =     
      contents.split(separator: "\n",     
      omittingEmptySubsequences: true)
  .compactMap { line -> (Int,Int,Int)? in
      let tokens = line.split(separator: " ")
      if let move = Int(tokens[1]), 
        let a = Int(tokens[3]),
        let b = Int(tokens[5]) {
          return (move: move, from: a, to: b)
    } 
     return nil
}

print(input)

let _ = input.map { line in
  move(numberOfCrates: line.move, 
       from: line.from, to: line.to, type9001: true)
}

var solution = ""
let numberOfStacks = stacksdict.count
for i in 1...numberOfStacks {
  solution += stacksdict[i]?.peek() ?? ""
}

print("solution: ",solution)

