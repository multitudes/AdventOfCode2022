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

//print(program)

var cycles = 1
var maxCycles = 240
var sumSignalStrengths = 0
var X = 1
var instrCnt = 0 // the counter for the instructions (my input)
var currentInstr = (instruction: "", value: 0)
var addxFlag = false
var maxInstrCount = program.count
let cyclesToCheckForSignalStrength = [20,60,100,140,180,220]
// part2
var spriteRange: Range = 0..<3
var CRTRow = 0 // the row to write to
var CRTRowLength = 40  // magic number- it is 40 pixels wide
var CRTRows = 6  // magic number- it is 40 pixels wide
var CRTScreen: [[String]] = Array(repeating: [],count: CRTRows)

// these are the character eventually drawn to the screen
var dot: String = "."
var hash: String = "#"

while cycles <= maxCycles {
  //check the signal strength for solution part 1
  // if the cycle is not one of the below the result is 0
  func checkSignalStrength() -> Int {
   if cyclesToCheckForSignalStrength.contains(cycles) {
        return X * cycles
   }   
   return 0
  }

  // for part 2 this will get the pixel to write on the screen
  // the parameter of the functions are the cycles number and X 
  // and the row number which are being updated during the loop
  func getPixel() -> String {
    // The sprite is three pixel and X is the middle pixel therefore:
    let sprite: ClosedRange = X-1...X+1   
    // cycles needs to be adjusted because they start from 1 
    // while the sprites and pixel from 0 !! :)
    let currentPixel = cycles-1 - (CRTRow * 40)
    if sprite ~= currentPixel {
      return hash
    }
    return dot
  } 

  // part 2 - every 40 pixel the CRT starts a new row
  // this is to know which row I am in
  CRTRow = (cycles - 1) / CRTRowLength 
  // the write function 
  let pixel = getPixel()
  CRTScreen[CRTRow].append(pixel)
 
  // I keep iterating as long as I have instructions?
  if instrCnt < maxInstrCount {
    currentInstr = program[instrCnt]
  } else { break } 

  // first check the signal strength
  sumSignalStrengths += checkSignalStrength()
  
  switch currentInstr.instruction {
    // case 'noop' doesnt do anything to the value
    case "noop":
      // update the cycles and instruction counter
      cycles += 1
      instrCnt += 1
    case "addx":
    // addx has 2 cycle - I check the flag - 
    // if true I am in the second loop
    if addxFlag {
       // if flag is true I update the instruction counter
      instrCnt += 1
       // the 'addx' instruction adds the value
      X += currentInstr.value
      //reset the flag
      addxFlag = false
    } else {
      // I am in the first ADDX loop and change 
      // the flag to true for the next iteration - I do nothing here
      addxFlag = true
    }
      //  update the cycles
      cycles += 1

    default:
      print("illegal instruction")
  }
}

print("Solution 1", sumSignalStrengths)
print("Solution 2", "\n")

for line in CRTScreen {
  print(line.joined(separator:""))
}
