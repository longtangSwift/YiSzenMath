//
//  MathBrain.swift
//  YiSzenMath
//
//  Created by CT MacBook Pro on 7/19/15.
//  Copyright © 2015 CT MacBook Pro. All rights reserved.
//

import Foundation

class MathBrain{
    private let randX: LinearCongruentialGenerator = LinearCongruentialGenerator()
    private var rand: Int{get {return Int(randX.random(12))+1}}
    private var go: Bool = false
    private var AnsArr = [(num1: Int, num2: Int, op: String, correct: Int, times: [Int])]()
    func formProblem (operations: String)-> (num1: Int, num2: Int, op: String) {
        var opArr = Array(operations.characters)
        var num1: Int = rand
        var num2: Int = rand
        //we don't want these numbers to be 1 more the 33% of the time
        while (num1 == 1 && randX.random(100) > 27){num1 = rand}
        while num2 == 1 && randX.random(100) > 27{num2 = rand}
        let index = Int(randX.random(operations.characters.count))
        let op = "\(opArr[index])"
        if op == "D" {num1 *= num2}
        return (num1: num1, num2: num2, op: op)
    }

    //The viewController will be talking to this one to get the problem
    func sendProblem (operations: String) -> (num1: Int, num2: Int, op: String){
        var i = 0
        var num1 = 0
        var num2 = 0
        var op = ""
        while i++ < 1000{
            let x = formProblem(operations)
            num1 = x.num1
            num2 = x.num2
            op = x.op
            if shouldWeGo(num1, num2: num2, op: op){break}
        }
        return (num1: num1, num2: num2, op: op)
    }
    
    
    //- looks at if we should go with this problem
    func shouldWeGo(num1: Int, num2: Int, op: String)->Bool{
        return true
    }
    
    func checkAnswer(userAnswer: String, problem: (num1: Int, num2: Int, op: String, time: Double)) -> Bool{
        var correct = false
        var answer = 0
        let userAnsInt = NSNumberFormatter().numberFromString(userAnswer)?.integerValue ?? 5
        switch problem.op{
        case "D": answer = performOperation(problem.num1, num2: problem.num2){$0 / $1}
        case "A": answer = performOperation(problem.num1, num2: problem.num2){$0 + $1}
        case "M": answer = performOperation(problem.num1, num2: problem.num2){$0 * $1}
        case "S": answer = performOperation(problem.num1, num2: problem.num2){$0 - $1}
            default: break
        }
        if userAnsInt == answer {correct = true; print("userAnsInt= \(userAnsInt) and answer = \(answer)")}
        
        return correct
    }
    
    func performOperation(num1: Int, num2: Int, operation: (Int, Int) -> Int) -> Int{
        var x = 0
        x = operation(num1, num2)
        return x
    }
    
}
