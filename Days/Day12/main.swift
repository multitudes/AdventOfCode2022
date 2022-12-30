// work in progress!
import Foundation

// getting my input as a nested int array
var map: [[String]] = []
do {
  map = try String(contentsOfFile: "inputTest.txt", encoding: .utf8)
  .split(separator: "\n")
  .map { Array(String($0))
        .compactMap { String($0) }
       }
} catch {
  print(error.localizedDescription)
}

for line in map {
  print(line)
}

// convenience variables
var lastCol = map[0].count - 1
var lastRow = map.count - 1
var startPosition = Square(row: 0, col: 0)
//var startPosition = Square(row: 20, col: 0)
//var endPosition = Square(row: 20 , col: 89)
var endPosition = Square(row: 2 , col: 6) // test
var up = "^"; var down = "v"; var left = "<"; var right = ">"
var steps = 1

// a case of A* pathfinding
class Square: Hashable {
  var row: Int = 0
  var col: Int = 0
  var parent: Square? = nil
  
  init(row: Int, col: Int ) {
    self.row = row
    self.col = col
  }
  
  var height: Int {
       return Int(UnicodeScalar(
                map[self.row][self.col])?
                 .value ?? 0)
  }
  // G 
  var G: Int {
    if let parent = self.parent {
      return parent.G
    } else { return 0 }
  }

  var H: Int {
    abs(endPosition.row - self.row) + 
    abs(endPosition.col - self.col)
  }

  var F: Int { H + G}
  // conform to hashable
  static func ==(lhs: Square, rhs: Square) -> Bool {
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
  }
  func hash(into hasher: inout Hasher) { 
    return hasher.combine(ObjectIdentifier(self))
  }
}
// squares to be considered.
var openList: Set<Square> = [startPosition]
var closedList: Set<Square> = [startPosition]
var currentSquare = startPosition

// check the adjacent squares and add them to the open list
func checkAdjacentSquares(currentSquare: Square) {
  // check up
  if currentSquare.row - 1 >= 0 {
    let adjSquare = Square(row: currentSquare.row - 1, 
                           col: currentSquare.col )  
     if (adjSquare.height - currentSquare.height) <= 1 || 
         currentSquare.height == 83 {
            openList.insert(adjSquare)
            adjSquare.parent = currentSquare
     }
  }
  // check down
  if currentSquare.row + 1 < lastRow {
    let adjSquare = Square(row: currentSquare.row + 1, 
                           col: currentSquare.col )   
     if (adjSquare.height - currentSquare.height) <= 1 || 
         currentSquare.height == 83 {
          openList.insert(adjSquare)
          adjSquare.parent = currentSquare
     }
  } 
  // check left
  if currentSquare.col - 1 >= 0 {
    let adjSquare = Square(row: currentSquare.row, 
                           col: currentSquare.col - 1)
     if (adjSquare.height - currentSquare.height) <= 1 || 
         currentSquare.height == 83 {
           openList.insert(adjSquare)
           adjSquare.parent = currentSquare
     }
  } 
  // check right
  if currentSquare.col + 1 < lastCol {
    let adjSquare = Square(row: currentSquare.row, 
                           col: currentSquare.col + 1 )   
     if (adjSquare.height - currentSquare.height) <= 1 || 
        currentSquare.height == 83 {
           openList.insert(adjSquare)
           adjSquare.parent = currentSquare
    }
  } 
}
checkAdjacentSquares(currentSquare: currentSquare)
print(openList)
// for each of them add the first square as a parent 
openList.remove(currentSquare)
closedList.insert(currentSquare)
print(openList)

for square in openList {
  print(square.parent?.height, square.height, square.H, "+",  square.G, "=", square.F)
}
// for each open square calculate F  G  and H
// G - take the G cost from parent and add 10
// H is estimated = distance to E manhattan method
// F is the sum of G and H
//we choose the lowest F score square from all those that are on the open list. 
if let currentSquare = openList.min(by: { (a, b) -> Bool in
    return a.F <= b.F
    }) {
  openList.remove(currentSquare)
  closedList.insert(currentSquare)
  checkAdjacentSquares(currentSquare: currentSquare)
  for square in openList {
  print(square.parent?.height, square.height, square.H, "+",  square.G, "=", square.F)
}
    }
