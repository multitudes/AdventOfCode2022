import Foundation

// Need to define an extra method on ClosedRange :)
extension ClosedRange {
    func contains(other: ClosedRange) -> Bool {
        lowerBound <= other.lowerBound && 
        upperBound >= other.upperBound
    }
}

var contents = ""

do {
  contents = try String(contentsOfFile: "input.txt", encoding: .utf8)
} catch {
  print(error.localizedDescription)
}

var input = contents.split(separator: "\n", omittingEmptySubsequences: true)

// Closed Ranges at the rescue!
// https://developer.apple.com/documentation/swift/closedrange

// got a line in input and get two closed ranges
func createTwoClosedRanges(from line: Substring) -> (ClosedRange<Int>,ClosedRange<Int>)? {
   let stringRanges: [Substring] = line.split(separator: ",")
   guard stringRanges.count == 2 else {return nil}
   if let firstClosedRange = createClosedRange(from: stringRanges.first!) , let secondClosedRange = createClosedRange(from: stringRanges.last!)  {
   return (firstClosedRange, secondClosedRange) }
  return nil
}

// Convenience function converting from a substring like "2-4" to a ClosedRange instance such as 2...4
func createClosedRange(from stringRange: Substring) -> ClosedRange<Int>? {
  let bounds = stringRange.split(separator: "-")
  guard bounds.count == 2 else {return nil }
  if let lower = Int(bounds.first!), let upper = Int(bounds.last!) {
    return lower...upper
  } 
  return nil
} 

let inputRanges: [(ClosedRange<Int>,ClosedRange<Int>)] = input.compactMap { line in
           createTwoClosedRanges(from: line) }

// The function returns one if one of the ranges is contained in the other.
func rangeIsContained(first: ClosedRange<Int>, second: ClosedRange<Int>) -> Int {
    if first.contains(other: second) ||                              second.contains(other: first) {  
        return 1 }         
    return 0  
}

let solution1 = inputRanges
    .map {(first,second) in
      rangeIsContained(first: first, second: second)}
    .reduce(0,+)

print(solution1)

// ********* part 2 ***********

func checkOverlaps(first: ClosedRange<Int>, second: ClosedRange<Int>) -> Int {
   if first.overlaps(second) ||                                     second.overlaps(first) {  
        return 1 }         
    return 0  
}

let solution2 = inputRanges
    .map {(first,second) in
      checkOverlaps(first: first, second: second)}
    .reduce(0,+)

print(solution2)
