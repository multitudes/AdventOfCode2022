import Foundation

var contents: String = ""
do {
   contents = try String(contentsOfFile: "input.txt", encoding: .utf8)
} catch {
  print(error.localizedDescription)
} 

var input = contents
  .split(separator: "\n",omittingEmptySubsequences: false)
  .split(separator: "")
  .map { 
      Array($0)
        .reduce(0){$0 + (Int($1) ?? 0) }
  }.sorted(by: >)
// print(input)

let solution1 = input.first ?? 0
//var input = contents.split(separator: "")
print("solution part1 is: ", solution1)
let solution2 = input.prefix(3).reduce(0,+) 
print("solution part2 is: ", solution2)
