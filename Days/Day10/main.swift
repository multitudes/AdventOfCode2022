import Foundation

// getting my input as a nested int array
var program: [(instruction: String, value: Int)] = []
do {
  program = try String(contentsOfFile: "input.txt", encoding: .utf8)
  .split(separator: "\n")
  .compactMap { 
    // splitting the line in instruction and ev value
    let splitLine = $0.split(separator: " ")
    // check that my data is valid
    assert(splitLine.count > 0, "invalid data")
    let instruction = String(splitLine[0])
    if splitLine.count == 2 { // addx case
       //  returning the data as tuple
      let value = Int(splitLine[1])
      assert(value != nil, "invalid data")
      return (instruction: instruction, value: value!)
    } else if splitLine.count == 1 { //noop case
       return (instruction: instruction, value: 0)
    }  
    return nil
    }
} catch {
  print(error.localizedDescription)
}

print(program)

var cycles = 1
var maxCycles = 220
var sumSignalStrengths = 0
var X = 1
var instrCnt = 0 // the counter for the instructions (my input)
var currentInstr = (instruction: "", value: 0)
var maxInstrCount = program.count

while cycles <= maxCycles {
  //check the signal strength for solution part 1
  func checkCycles(cycles: Int, X: Int) -> Int {
   if cycles == 20 || 
     cycles == 60 || 
     cycles == 100 || 
     cycles == 140 || 
     cycles == 180 || 
     cycles == 220 {
        return X * cycles
   }   
    return 0
  }

  // I keep iterating as long as I have instructions?
  if instrCnt < maxInstrCount {
    currentInstr = program[instrCnt]
  } else { break }
  
  switch currentInstr.instruction {
    case "noop":
      // first check the signal strength
      sumSignalStrengths += checkCycles(cycles: cycles, X: X)
      // then update the cycles and instruction counter
      cycles += 1
      instrCnt += 1
    case "addx":
      for _ in 0..<2 {
       // first check the signal strength
      sumSignalStrengths += checkCycles(cycles: cycles, X: X)
      // then update the cycles
      cycles += 1
      }
    // at the end update the instruction counter
      instrCnt += 1
      X += currentInstr.value
    default:
      print("illegal instruction")
  }
}

print("Solution 1", sumSignalStrengths)
