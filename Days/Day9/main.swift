// work in progress!
// part 1
import Foundation

// getting my input as a nested int array
var contents: [(direction: Character, steps: Int)] = []
do {
  contents = try String(contentsOfFile: "input.txt", encoding: .utf8)
  .split(separator: "\n")
  .compactMap { 
    // splitting the line in chars
    let characters = Array($0)
    // taking the first and last and returning then as tuple
    if let direction = characters.first, let lastChar = characters.last, let steps = Int(String(lastChar)) {
      return (direction: direction, steps: steps)
    } 
    print ("error ----------------------")
    return nil
    }
} catch {
  print(error.localizedDescription)
}

var head: (row: Int, col: Int) = (0,0)
var tail: (row: Int, col: Int) = (0,0)
var tails: [(row: Int, col: Int)] = []
func tailIsAdjacent(head: (row: Int, col: Int), tail: (row: Int, col: Int)) -> Bool {
  if abs(head.row - tail.row) <= 1 && 
     abs(head.col - tail.col) <= 1 {
    return true
  }
  return false
}

print(tailIsAdjacent(head: head, tail: tail ))
// create the map
//var map: [[Character]] = [[Character]](repeating: [Character](repeating: ".", count: 100), count: 100)
// putting my head
//map[50][50] = "H"
for line in contents {
  print(line)
  switch line.direction {
    case "R":
      for _ in 0..<line.steps {
        head.col += 1 
        if !tailIsAdjacent(head: head, tail: tail) {
          tail.col += 1; tail.row = head.row
        }
        if (!tails.contains { element in 
                           element.col == tail.col && 
                           element.row == tail.row }) {
          tails.append(tail)
        }
      }
    case "U":
    for _ in 0..<line.steps {
        head.row += 1
       if !tailIsAdjacent(head: head, tail: tail) {
          tail.row += 1; tail.col = head.col
        }
       if (!tails.contains { element in 
                           element.col == tail.col && 
                           element.row == tail.row }) {
          tails.append(tail)
        }
      }
    case "D":
    for _ in 0..<line.steps {
        head.row -= 1
      if !tailIsAdjacent(head: head, tail: tail) {
          tail.row -= 1; tail.col = head.col
        }
       if (!tails.contains { element in 
                           element.col == tail.col && 
                           element.row == tail.row }) {
          tails.append(tail)
        }
      }
    case "L":
    for _ in 0..<line.steps {
        head.col -= 1 
       if !tailIsAdjacent(head: head, tail: tail) {
          tail.col -= 1; tail.row = head.row
        }
       if (!tails.contains { element in 
                           element.col == tail.col && 
                           element.row == tail.row }) {
          tails.append(tail)
        }
      }
    default:
    print("hello")
  }
}
print(head)
print(tail)
print(tails)
print(tails.count)

