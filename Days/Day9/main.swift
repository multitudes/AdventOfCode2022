import Foundation

// getting my input as a nested int array
var contents: [(direction: Character, steps: Int)] = []
do {
  contents = try String(contentsOfFile: "input.txt", encoding: .utf8)
  .split(separator: "\n")
  .compactMap { 
    // splitting the line in 2 - character for direction and steps
    let line = $0.split(separator: " ")
    // the line should always be divided by a space like "U 5" 
    assert(line.count == 2, "error : missing data")
    // taking the first and last and returning then as tuple
    if let direction = String(line[0]).first, 
       let steps = Int(line[1]) {
       return (direction: direction, steps: steps)
    } 
    return nil
    }
} catch {
  print(error.localizedDescription)
}

var head: (row: Int, col: Int) = (0,0)
var tail: (row: Int, col: Int) = (0,0)
var tails: [(row: Int, col: Int)] = [(0,0)]

func tailIsAdjacent(head: (row: Int, col: Int), tail: (row: Int, col: Int)) -> Bool {
  if abs(head.row - tail.row) <= 1 && 
     abs(head.col - tail.col) <= 1 {
    return true
  }
  return false
}

// Here I take every line in input and process the data
// according to the 4 cases - directions and storing the 
// position of the tail in an array with unique elements
for line in contents {
  switch line.direction {
    case "R":
      for _ in 0..<line.steps {
        head.col += 1 
        if !tailIsAdjacent(head: head, tail: tail) {
          tail.col += 1; tail.row = head.row
        }
        if !(tails.contains { $0 == tail }) {
          tails.append(tail)
        }
      }
    case "U":
      for _ in 0..<line.steps {
        head.row += 1
        if !tailIsAdjacent(head: head, tail: tail) {
          tail.row += 1; tail.col = head.col
        }
        if !(tails.contains { $0 == tail }) {
          tails.append(tail)
        }
      }
    case "D":
      for _ in 0..<line.steps {
        head.row -= 1
        if !tailIsAdjacent(head: head, tail: tail) {
          tail.row -= 1; tail.col = head.col
        }
        if !(tails.contains { $0 == tail }) {
          tails.append(tail)
        }
      }
    case "L":
      for _ in 0..<line.steps {
        head.col -= 1 
        if !tailIsAdjacent(head: head, tail: tail) {
          tail.col -= 1; tail.row = head.row
        }
        if !(tails.contains { $0 == tail }) {
          tails.append(tail)
        }
      }
    default:
    print("invalid data")
  }
}

print("Solution part 1: ", tails.count)
