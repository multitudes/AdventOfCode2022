// work in progress!
import Foundation

// getting my input as a nested array 
var contents: [[String]] = []
do {
  contents = try String(contentsOfFile: "inputTest.txt", encoding: .utf8)
  .split(separator: "\n")
  .map { Array(String($0)).map {String($0)}}
} catch {
  print(error.localizedDescription)
}

// check
for line in contents {
  print(line)
}

// create a mnested array squares with 
var map: [[Square]] = []
for row in 0..<contents.count {
  let newRow: [Square] = [] 
  map.append(newRow)
  for col in 0..<contents[0].count {
    let height = Int(UnicodeScalar(contents[row][col])?.value ?? 0)   
    let sq = Square(row: row, col: col, height: height )
     map[row].append(sq)
  }
}

for row in 0..<map.count {
  for col in 0..<map[0].count {
    print(map[row][col].height)  
  }
}

// convenience variables
var lastCol = map[0].count - 1
var lastRow = map.count - 1
var startPosition = map[0][0]
//var startPosition = Square(row: 20, col: 0)
//var endPosition = Square(row: 20 , col: 89)
var endPosition =  map[2][6] // test


enum Dir: String {
  case up = "^", down = "v", left = "<", right = ">"
}

var steps = 1

// a case of A* pathfinding
class Square: Hashable {
  var row: Int = 0
  var col: Int = 0
  var parent: Square? = nil
  
  init(row: Int, col: Int, height: Int ) {
    self.row = row
    self.col = col
    self.height = height
  }

  var height: Int = 0
  
  // G 
  var G: Int {
    if let parent = self.parent {
      return parent.G
    } else { return 0 }
  }

  // H
  var H: Int {
    abs(endPosition.row - self.row) + 
    abs(endPosition.col - self.col)
  }

  // F
  var F: Int { H + G }
  
  // conform to hashable
  static func ==(lhs: Square, rhs: Square) -> Bool {
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
  }
  
  func hash(into hasher: inout Hasher) { 
    return hasher.combine(ObjectIdentifier(self))
  }
}

// this function just do one thing...
func inMapLimits(_ direction: Dir)-> Bool {
  switch direction {
    case .up:
      return currentSquare.row - 1 >= 0
    case .down:
      return currentSquare.row + 1 < lastRow
    case .left:
      return currentSquare.col - 1 >= 0
    case .right:
      return currentSquare.col + 1 < lastCol
  }
}

func checkIfSummit(_ adjSquare: Square) {
  if adjSquare.height == end {
    print("*****************************\nEND**********\n")
  }
}

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
    // if on the open list already 
    // I check if my G value is better and if so
    // I update the parent
    if adjSquare.G < currentSquare.G   {
        adjSquare.parent = currentSquare
       } 
    }
}
// check if walkable and if so add to open list
func walkable(_ adjSquare: Square) -> Bool {
  // check if in closed list - if so exit!
  if closedList.contains(adjSquare) {
    return false
  }
  if (adjSquare.height - currentSquare.height) <= 1 || 
         currentSquare.height == start || 
  currentSquare.height == end {
          return true
  } else { return false }
}
// check the adjacent squares and add them to the open list
// also making the current square the parent of the adj square
func checkAdjacentSquaresUpdateOpenList() {
  // check up
  if inMapLimits(.up) {
    let adjSquare = map[currentSquare.row - 1][currentSquare.col] 
    checkIfSummit(adjSquare)
    if walkable(adjSquare) {
      addToOpenList(adjSquare)
      }
    }
  // check down
  if inMapLimits(.down) {
    let adjSquare = map[currentSquare.row + 1][currentSquare.col] 
    checkIfSummit(adjSquare)
    if walkable(adjSquare) {
      addToOpenList(adjSquare)
      }
  } 
  // check left
  if inMapLimits(.left) {
    let adjSquare = map[currentSquare.row][currentSquare.col - 1]
    checkIfSummit(adjSquare)
    if walkable(adjSquare) {
      addToOpenList(adjSquare)
      }
  } 
  // check right
  if inMapLimits(.right) {
    let adjSquare = map[currentSquare.row][currentSquare.col + 1]   
    checkIfSummit(adjSquare)
    if walkable(adjSquare) {
      addToOpenList(adjSquare)
      }
  } 
  // update the lists 
  openList.remove(currentSquare)
  closedList.insert(currentSquare)
}

// ************** main logic ****************


// squares to be considered.
var openList: Set<Square> = [startPosition]
// squares already visited.
var closedList: Set<Square> = [startPosition]
// my start square
var currentSquare = startPosition
// the height of starting point or Ascii for S
var start = 83 
// the ascii value for the "E" char I am looking for
var end = 69 

for _ in 0..<2 {
  print("curr height", currentSquare.height)
// check the adj squares and update the open list
 checkAdjacentSquaresUpdateOpenList()

print("open List")
 for square in openList {
   print("parent ",square.parent?.height ?? 0, "square ",square.height, square.H, 
 "+", square.G, "=", square.F)
 }
print("closed List")
 for square in closedList {
   print("parent ",square.parent?.height ?? 0, "square ",square.height, square.H, 
 "+", square.G, "=", square.F)
 }
// for each open square calculate F  G  and H
// G - take the G cost from parent and add 10
// H is estimated = distance to E manhattan method
// F is the sum of G and H
//we choose the lowest F score square from all those that are on the open list. 
currentSquare = openList.min(by: { (a, b) -> Bool in
    return a.F < b.F
    })!
}
