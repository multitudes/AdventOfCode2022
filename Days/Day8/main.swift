import Foundation

// rotate a 2D array flipping rows to columns
func rotate(nestedArray: [[Int]]) -> [[Int]] {
  var newArray = Array(repeating: Array(repeating: 0, count: nestedArray[0].count), count: nestedArray.count)
  for i in 0..<nestedArray.count {
    for k in 0..<nestedArray[0].count {
      newArray[k][i] = nestedArray[i][k]
    }
  }
  return newArray
}

// getting my input as a nested int array
var contents: [[Int]] = []
do {
  contents = try String(contentsOfFile: "input.txt", encoding: .utf8)
  .split(separator: "\n")
  .map { Array(String($0))
        .compactMap { Int(String($0)) }
       }
} catch {
  print(error.localizedDescription)
}

// I need to rotate the input array to simplify
// and get a better performance
var rotatedContents = rotate(nestedArray:contents)

// creating another nested int array of the same size of my input but initializing with -1 
// this will allow to skipthe part that I already found
// to be highest
var VisibleTrees = Array(repeating: Array(repeating: -1, count: contents[0].count), count: contents.count)

// this will be the solution of part 1
var visibleTrees = 0

func checkHeights(treeMap: [[Int]]) {
  // the bounds of my array
  let lastRow = treeMap.count - 1
  let lastCol = treeMap[0].count - 1
  for (indexRow, row) in treeMap.enumerated() { 
    var highestSoFarInRow = row[0]
    // the starting value of the other side - 
    // starting from the end of the row
    let inversedRow = Array(row.reversed())
    var highestSoFarInRowReversed = row[lastCol]
    // starting iterating the heights in the current row
    for (indexCol, height) in row.enumerated() { 
     // the first and last row are visible by default
     if indexRow == 0 || indexRow == lastRow {
       if VisibleTrees[indexRow][indexCol] != height{
         visibleTrees += 1
         VisibleTrees[indexRow][indexCol] = height
         continue
       }
     }    
     // the first and last column are visible too 
     if indexCol == 0 || indexCol == lastCol {
       if VisibleTrees[indexRow][indexCol] != height{
          visibleTrees += 1
          VisibleTrees[indexRow][indexCol] = height
          continue
      }
    }
    // check going west - east
    if height > highestSoFarInRow {
       highestSoFarInRow = height 
       if VisibleTrees[indexRow][indexCol] != height{
        visibleTrees += 1
        VisibleTrees[indexRow][indexCol] = height
     }
    }
    // I reuse the current incrementing indexCol but on the reversed array!
    if inversedRow[indexCol] > highestSoFarInRowReversed {
      highestSoFarInRowReversed = inversedRow[indexCol]
      if VisibleTrees[indexRow][lastCol-indexCol] != inversedRow[indexCol]{
      visibleTrees += 1
      VisibleTrees[indexRow][lastCol-indexCol] = inversedRow[indexCol]
     }
    }
  }
 }
}

// first go iterating through the input map from left to right
checkHeights(treeMap: contents)
// then rotate both arrays and go again from left to right
VisibleTrees = rotate(nestedArray:VisibleTrees)
checkHeights(treeMap: rotatedContents)


print("solution 1", visibleTrees)
