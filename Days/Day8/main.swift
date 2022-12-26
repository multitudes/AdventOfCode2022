import Foundation

// getting my input as a nested int array
var contents: [[Int]] = []
do {
  contents = try String(contentsOfFile: "inputTest.txt", encoding: .utf8)
  .split(separator: "\n")
  .map { Array(String($0))
        .compactMap { Int(String($0)) }
       }
} catch {
  print(error.localizedDescription)
}

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

func checkEast(row: Int, col: Int) ->  (isVisible: Bool, scenicScore:Int) {
  if col == lastCol { return (true, 0) }
  var index = col; var scenicScore = 0
  while (index < lastCol) {
    scenicScore += 1; index += 1
    if (contents[row][col] <= contents[row][index]) {
      return (false, scenicScore)
    }
  }
  return (true, scenicScore)
}

func checkNorth(row: Int, col: Int) ->  (isVisible: Bool, scenicScore:Int) {
  if row == 0 { return (true, 0) }
  var index = row; var scenicScore = 0
  while (index != 0) {
    scenicScore += 1; index -= 1
    if (contents[row][col] <= contents[index][col]) {
      return (false, scenicScore)
    }
  }
  return (true, scenicScore)
}

func checkSouth(row: Int, col: Int) ->  (isVisible: Bool, scenicScore:Int) {
  if row == lastRow { return (true, 0) }
  var index = row; var scenicScore = 0
  while (index < (contents[0].count - 1)) {
    scenicScore += 1; index += 1
    if (contents[row][col] <= contents[index][col]) {
      return (false, scenicScore)
    }
  }
  return (true, scenicScore)
}

// this will be the solution of part 1
var visibleTrees = 0
// this will be the solution of part 1
var totalScenicScore = 0

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

print("solution 1", visibleTrees)
print("solution 2", totalScenicScore)
