import Foundation

// magic numbers!
let draw = 3
let win = 6
let lose = 0

var contents = ""
var totalScorePart1: Int = 0
var totalScorePart2: Int = 0

// I get a string as input but I do not need the whitespace in 
// the middle... so I filter it out 
do {
  contents = try String(contentsOfFile: "input.txt", encoding: .utf8).filter {$0 != " "}
} catch {
  print(error.localizedDescription)
}

// A hand shape can be one of the three types rock, paper, scissors
enum HandShape: Int {
  // the handshapes have associated values as points
  // therefore I use a enum with associated values
  case rock = 1, paper = 2, scissors = 3, invalid = 0
  
  // I use a failable custom init to create the enum from one 
  // of the characters I get in the input. 
  init?(hand: Character) {
    switch hand {
      case "A", "X":
        self = .rock
      case "B", "Y":
       self = .paper
      case "C", "Z":
       self = .scissors
      default:
       return nil
    }
  }
}

// part 2! What I thought it would be my hand was just my strategy!
enum Strategy {
  case lose, draw, win, invalid
  
  // I use a failable custom init to create the enum from the 
  // right hand character I get in the input.  
  init?(strategy: Character) {
    switch strategy {
      case "X":
        self = .lose
      case "Y":
       self = .draw
      case "Z":
       self = .win
      default:
        self = .invalid
         return nil
    }
  }
}

// I choose to create the input as an arraay of tuples.
var input: [(leftHand: HandShape, rightHand: HandShape, strategy: Strategy)] = contents.split(separator: "\n", omittingEmptySubsequences: true)
  .map {
    // this converts my input line to chars
    let round: [Character] = Array($0)
    // I return a tuple. I added for part 2 the strategy... 
    return (HandShape(hand: round[0]) ?? .invalid,
            HandShape(hand: round[1]) ?? .invalid,
            Strategy(strategy: round[1]) ?? .invalid)
}

// This will evaluate the game for part 1
func evaluate(left: HandShape, right: HandShape) -> Int {
  switch (left, right) {
    // draw
    case (.rock, .rock), (.paper, .paper),(.scissors, .scissors):
      return draw + right.rawValue
    // I lose
    case (.rock, .scissors), (.paper, .rock),(.scissors, .paper):
      return lose + right.rawValue
    // I win
    case (.rock, .paper), (.paper, .scissors),(.scissors, .rock):
      return win + right.rawValue
    default:
      print("invalid!")
      return 0
  }
}

func evaluateUpdatedPart2(left: HandShape, strategy: Strategy) -> Int {
  switch strategy {
    
    // If I draw I get 3 plus the value of my hand 
    // which is the same of my opponent's
    case .draw:
      return left.rawValue + draw 
    
     // If I win I get 6 plus the value of my hand 
    case .win:
      if left == .rock { return  win + HandShape.paper.rawValue } 
      if left == .paper { return  win + HandShape.scissors.rawValue } 
      if left == .scissors { return  win + HandShape.rock.rawValue } 
    
     // If I lose I get 0 plus the value of my hand 
    case .lose:
      if left == .rock { return HandShape.scissors.rawValue } 
      if left == .paper { return HandShape.rock.rawValue } 
      if left == .scissors { return  HandShape.paper.rawValue } 

    case .invalid:
      print("invalid game!")
      return 0
  }
  return 0
}

for round in input {
  print(round)
  totalScorePart1 += evaluate(left: round.leftHand, right: round.rightHand)
  // this is for part 2
  totalScorePart2 += evaluateUpdatedPart2(left: round.leftHand, strategy: round.strategy)
}

print("total part 1 : ", totalScorePart1)
print("total part 2 : ", totalScorePart2)
