//
//  ViewController.swift
//  YiSzenMath
//
//  Created by CT MacBook Pro on 7/19/15.
//  Copyright © 2015 CT MacBook Pro. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    let math: MathBrain = MathBrain()
    lazy var problem: (num1: Int, num2: Int, op: String) = (6,9,"M")
    var time1: NSTimeInterval = 1
    var time2: NSTimeInterval = 1
    var time3: NSTimeInterval = 1
    var time4: NSTimeInterval = 1
    @IBOutlet weak var DisplayScreen1: UILabel!
    @IBOutlet weak var DisplayScreen2: UILabel!
    @IBOutlet weak var DisplayScreen3: UILabel!
    @IBOutlet weak var DisplayBottom1: UILabel!
    @IBOutlet weak var DisplayBottom2: UILabel!
    @IBOutlet weak var DisplayBottom3: UILabel!
    @IBOutlet weak var DivisionLabel: UILabel!
    @IBOutlet weak var AdditionLabel: UILabel!
    @IBOutlet weak var MultiplicationLabel: UILabel!
    @IBOutlet weak var SubstractionLabel: UILabel!
    @IBAction func NumberButtonTheUserPresses(sender: UIButton) {
        let Digit = sender.currentTitle!
        DisplayScreen2.text? += Digit
    }
    override func viewDidLoad() {
        displayProblem()
        var str = ""
        for _ in 1 ... 30{str += "🐹"}
        DisplayBottom1.text = str
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "interval", userInfo: nil, repeats: true)
    }
    
    @IBAction func Enter(sender: UIButton){
        var str = ""
        if let txt = DisplayScreen2.text{
            str = txt
            time2 = (NSDate(timeIntervalSinceNow: 1)).timeIntervalSinceReferenceDate
            let time = time2 - time1
            let correct = math.checkAnswer(str, problem: (problem.num1, problem.num2, problem.op, time))
            if correct {displayProblem(); DisplayScreen2.text = ""; DisplayScreen3.text = DisplayScreen3.text! + "😃"; NSTimer.scheduledTimerWithTimeInterval(10, target:self, selector: "pauseThreeCorrect", userInfo: nil, repeats: false)}
            else {
                DisplayBottom3.text = DisplayScreen1.text!
                DisplayScreen1.text = "We'll come back to it"
                
                NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: "pauseThree", userInfo: nil, repeats: false)
            }
        }
    }

    
    @IBAction func BackSpace(sender: UIButton) {
        if let txt = DisplayScreen2.text{
            var x = txt
            if x.characters.count > 0 {
                x.removeAtIndex(x.endIndex.predecessor())
            }
            DisplayScreen2.text = x
        }
    }
    @IBAction func OperaterChoiceButton(sender: UIButton) {
        switch sender.currentTitle!{
        case "Div": if DivisionLabel.text != "✔️" {DivisionLabel.text = "✔️"} else {DivisionLabel.text = " "}
        case "Add": if AdditionLabel.text != "✔️" {AdditionLabel.text = "✔️"} else {AdditionLabel.text = " "}
        case "Mul": if MultiplicationLabel.text != "✔️" {MultiplicationLabel.text = "✔️"} else {MultiplicationLabel.text = " "}
        case "Sub": if SubstractionLabel.text != "✔️" {SubstractionLabel.text = "✔️"} else {SubstractionLabel.text = " "}
        default: break
        }
    }
    @IBAction func Neg(sender: UIButton) {
        var sign = ""
        var str = ""
        var x = Array("".characters)
        if let txt = DisplayScreen2.text {
            x = Array(txt.characters)
            if x.count == 0 {sign = "-"}
            if x.count > 0 && x[0] != "-" {
                sign = "-"
            }else{if x.count>0{x.removeAtIndex(0)}}
        }
        for i in x{str += "\(i)"}
        DisplayScreen2.text = sign + str
    }
    func gatherOperations () -> String{
        var dams = ""
        if DivisionLabel.text == "✔️"{dams += "D"}
        if AdditionLabel.text == "✔️"{dams += "A"}
        if MultiplicationLabel.text == "✔️"{dams += "M"}
        if SubstractionLabel.text == "✔️"{dams += "S"}
        if dams == "" {dams = "DAMS"}
        return dams
    }
    
    
    func getOperationSymbol(operation: String) -> String{
        var x = ""
        switch operation{
            case "D": x = "➗"
            case "A": x = "➕"
            case "M": x = "✖️"
            case "S": x = "➖"
        default: x = " Error; Try Again"
        }
        return x
    }
    
    func displayProblem(){
        let operation = gatherOperations()
        problem = math.sendProblem(operation)
        let opStr = getOperationSymbol(problem.2)
        DisplayScreen1.text = "\(problem.0) \(opStr) \(problem.1)"
        time1 = (NSDate(timeIntervalSinceNow: 1)).timeIntervalSinceReferenceDate
    }
    func interval(){
        time2 = (NSDate(timeIntervalSinceNow: 1)).timeIntervalSinceReferenceDate
        let time = time2 - time1
        DisplayBottom2.text = "\(Int(time))"
    }
    
    func pauseThree(){
        DisplayScreen1.text = ""
        DisplayScreen2.text = ""
        //waiting 3 seconds before coming to this func.
        displayProblem()
        
    }
    //chops off one of the smiley faces
    func pauseThreeCorrect(){
        var txt = DisplayScreen3.text!
        txt.removeAtIndex(txt.endIndex.predecessor())
        DisplayScreen3.text = txt
    }
    
}

