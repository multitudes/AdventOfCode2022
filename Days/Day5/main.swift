// WARNING - I am stuck today because Replit did not work! So still unfinished code below 

import Foundation

// create a data structure to emulate stacks
struct Stack {
  fileprivate var array:[String] = []

  init(_ array: [String]) {
    self.array = array 
  }
  
  init() {}
  
  mutating func push(_ element: String) {
    array.append(element)
  }

  mutating func pop() -> String? {
    return array.popLast()
  }

  func peek() -> String? {
    return array.last
  }
}

// move 
func move(numberOfCrates: Int,
          from currentStackNumber: Int,
          to otherStackNumber: Int) {
  var current = testStacksdic[currentStackNumber] ?? Stack()
  var other = testStacksdic[otherStackNumber] ?? Stack()
    for _ in 1...numberOfCrates {
      if let crate = current.pop() {
          other.push(crate) 
          print(crate)
    }
  testStacksdic[currentStackNumber] = current 
  testStacksdic[otherStackNumber] = other
  }
}

var testStacksdic: [Int: Stack] = [
                        1:Stack(["Z","N"]),
                        2:Stack(["M","C","D"]),
                        3:Stack(["P"])]


// ************ stack **********

var contents = ""

do {
  contents = try String(contentsOfFile: "inputTest.txt", encoding: .utf8)
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
       from: line.from, to: line.to)
}
//print(testStacksdic)

print(testStacksdic)
