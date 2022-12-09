import Foundation

// from Hacking with swift - I need chunks for part 2 but i cannot use the swift algo package in replit.. or I could but it is a bit convoluted! :)
// https://www.hackingwithswift.com/example-code/language/how-to-split-an-array-into-chunks
extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

var contents = ""

do {
  contents = try String(contentsOfFile: "input.txt", encoding: .utf8)
} catch {
  print(error.localizedDescription)
}

var input = contents.split(separator: "\n", omittingEmptySubsequences: true)

// create the priorities as a dictionary because N(1), so it has a better performance, just in case I need it!
let allItems: [Character] = Array("abcdefghijklmnopqrstuvwxyz" + "abcdefghijklmnopqrstuvwxyz".uppercased())
// good resource! 
//https://developer.apple.com/documentation/swift/dictionary/init(uniquekeyswithvalues:)
let priorities: [Character: Int] = Dictionary(uniqueKeysWithValues: zip(allItems, 1...allItems.count))

// convenience function to get the two halves of the input string and get the intersection, my item
func getCommonItem(from items: String.SubSequence) -> Character {
    let halfLength  = items.count / 2
    let a = Set(items.prefix(halfLength))
    let b = Set(items.suffix(halfLength))
    return a.intersection(b).first! 
}

// **** Part 1 ****
var solutionPart1 = input.map {items in
   getCommonItem(from: items)
  }.reduce(0) { $0 + (priorities[$1] ?? 0) } 

print("Solution Part 1", solutionPart1)

// **** Part 2 ****
let chunkedInput = input.chunked(into: 3)
//print(chunkedInput)
var solutionPart2 = chunkedInput.map { group in
  let a = Set(group[0]); let b = Set(group[1])
  let c = Set(group[2])
  return a.intersection(b).intersection(c).first! }
    .reduce(0) {
      $0 + (priorities[$1] ?? 0)
    } 
print("Solution Part 2", solutionPart2)

