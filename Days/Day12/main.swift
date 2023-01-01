import Foundation

//  I will fill a map with squares
var map: [[Square]] = []

// convenience variables
// the height of starting point S or Ascii for a
let start = 96
// the height of the end point E or Ascii for z 
let end = 122 // 122
// to test
//let file = "inputTest.txt"
//let startCoord: (row: Int, col: Int) = (0,0)
//let endCoord: (row: Int, col: Int) = (2,5)
let file = "input.txt"
let startCoord: (row: Int, col: Int) = (20,0)
let endCoord: (row: Int, col: Int) = (20,88)

do {
  // getting my input as a nested array of letters first
  var contents: [[String]] = []
  contents = try String(contentsOfFile: file, encoding: .utf8)
  .split(separator: "\n")
  .map { Array(String($0)).map {String($0)}}
// from this first nested 2D array I create the Squares
// Square is a class passed as reference therefore I cannot 
// initialize the Array like `Array(repeating: count)`
// because that would create the same object. I need separate objects for every square...
  for row in 0..<contents.count {
    let newRow: [Square] = [] 
    map.append(newRow)
    for col in 0..<contents[0].count {
     // I convert the letters to their ASCII values
     var height = 0
      // set 96 start
     if row == startCoord.row && col == startCoord.col {
       height = start } 
         //  as end 123
      else if row == endCoord.row && col == endCoord.col {
       height = end
     } else { 
    height = Int(UnicodeScalar(contents[row][col])?.value ?? 0)  
     }
    // create the new instance
    let sq = Square(row: row, col: col, height: height )
    // and add it to the grid
    map[row].append(sq)
  }
 }
} catch {
  print(error.localizedDescription)
}


var lastCol = map[0].count - 1
var lastRow = map.count - 1
var startPosition = map[startCoord.row][startCoord.col] // 0,0 test / 20 0 real
var endPosition =  map[startCoord.row][startCoord.col] // test // 2,5 // 20,88 real 
//my end heihgt will be just above z 

// count my step at the end regressing 
var counter = 0

// squares to be considered.
var openList: Set<Square> = [startPosition]
// squares already visited.
var closedList: Set<Square> = []
// my start square
var currentSquare = startPosition

var visited: [[String]] = Array(repeating: Array(repeating: ".", count: map[0].count ), count: map.count)

// this function just do one thing... check if I am stii
// within limits of the map
func inMapLimits(_ direction: Dir)-> Bool {
  switch direction {
    case .up:
      return currentSquare.row - 1 >= 0
    case .down:
      return currentSquare.row + 1 <= lastRow
    case .left:
      return currentSquare.col - 1 >= 0
    case .right:
      return currentSquare.col + 1 <= lastCol
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
    // if on the open list already and I arrived to this
    // square from somewhere maybe shorter 
    // I check if my G value is better and if so
    // I update the adj sq and put myself as parent
    if currentSquare.G <= adjSquare.G   {
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
  // here I check that the height diff is not bigger than one
  if (adjSquare.height - currentSquare.height) <= 1  {
          return true
  } else { return false }
}
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

// ************** main logic ****************

while true {
  // get the current square from the open list
  // we choose the lowest F score square from all 
  // those that are on the open list. 
  currentSquare = openList.min(by: { (a, b) -> Bool in
    return a.F < b.F 
    })!
  
  // update the lists 
  openList.remove(currentSquare)
  closedList.insert(currentSquare)
  
  // test
  //print("\ncurr height ********************", currentSquare.height, "(", currentSquare.row, currentSquare.col, ")")
  //print("openList.count ",openList.count)
  
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

// Here I found my end square and count the steps back
counter = 0
while currentSquare.parent != nil {
  counter += 1
  currentSquare = currentSquare.parent! 
}
print("solution 1 ", counter)

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

// convenience enum
enum Dir: String {
  case up = "^", down = "v", left = "<", right = ">"
}
