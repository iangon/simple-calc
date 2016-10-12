//
//  main.swift
//  SimpleCalc
//
//  Created by Ian on 10/4/16.
//  Copyright © 2016 Ian. All rights reserved.
//

import Foundation


/* 
 *  Evaluate two numbers
 */

func evaluateTwoNumbers(_ operand1 : Double, _ operand2 : Double, _ operation : String) -> Double? {
    var result : Double?;
    switch (operation) {
        case "+":
            result = operand1 + operand2
        case "-":
            result = operand1 - operand2
        case "/":
            result = operand1 / operand2
        case "*":
            result = operand1 * operand2
        case "%":
            result = operand1.truncatingRemainder(dividingBy:operand2)
        default:
            break
    }
    return result
    
}

/*
 * check to see if line contains multi-operand 
 */

func hasMultiOperand (_ line : String) -> Bool {
    let stringArray = line.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
    
    if stringArray.count < 1 {
        return false
    }
    
    let word = stringArray[stringArray.count-1];
    
    switch (word) {
        case "count", "avg", "fact":
            return true
        default:
            return false
    }
}

/*
 * check to see if line contains single number
 */

func isSingleNumber (_ line : String) -> Bool? {
    let stringArray = line.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
    if(stringArray.count >= 1 && (Double(stringArray[0]) != nil)) {
        return true
    }
    
    return nil
}

/*
 *  Calculate Count
 */

func calcCount(_ stringArray : Array<String>) -> Double {
    return Double(stringArray.count - 1)
}


/*
 *  Calculate average
 */

func calcAvg(_ stringArray : Array<String>) -> Double? {
    var sum = 0.0
    var count = 0
    for num in stringArray {
        if((Double(num)) != nil && num != "avg"){
            sum += Double(num)!
            count += 1
        } else if num != "avg" || stringArray.count < 2 {
            return nil
        }
    }
    return sum / Double(count)
}

/*
 *  Calculate factorial
 */

func calcFact(_ stringArray : Array<String>) -> Double? {
    let num = Int(stringArray[0])!
    
    if num == 1 {
        return 1
    } else if num > 1 && stringArray.count == 2 {
        var fact = num
        
        for i in 1...num-1 {
            fact *= num - i
        }
        return Double(fact)
    }
    
    return nil
}


var keepRunning = true;
repeat {
    print("Enter an expression separated by returns:")
    var result : String = ""

    let firstLine = readLine(strippingNewline: true)!
    
    if firstLine == "stop" {
        break
    }
    
    // check first line to see if it's a multi-oprand
    if(hasMultiOperand(firstLine)) {
        let stringArray = firstLine.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
        let operation = stringArray[stringArray.count-1];
        
        switch (operation) {
            case "count":
                result = String(calcCount(stringArray))
            case "avg":
                let avg = calcAvg(stringArray)
                if avg != nil {
                    result = String(avg!)
                } else {
                    result = "Please enter a single number and the word \"fact\" (ex. \"5 fact\" or \"100 fact\""
                }
            
            case "fact":
                let fact = calcFact(stringArray);
                
                if fact != nil {
                    result = String(fact!)
                } else {
                    result = "Please enter a single number and the word \"fact\" (ex. \"5 fact\" or \"100 fact\""
                }
            
            default:
                result = "Operation not recognized"
        }

        
    } else if(isSingleNumber(firstLine)!) {
        let operand1 =  Double(firstLine)!
        
        let secondLine = readLine(strippingNewline: true)!
        let operation = String(secondLine)!
        
        let thirdLine = readLine(strippingNewline: true)!
        let operand2 =  Double(thirdLine)!
        
        result = String(evaluateTwoNumbers(operand1, operand2, operation)!)
        
    }

    print(result + "\n")

} while (keepRunning)
