//
//  ViewController.swift
//  Calculator
//
//  Created by admin on 06/12/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var result: UILabel!
    
    var numbers: [Double] = []
    var op = ""
    var newNumber = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addNumber(_ sender: UIButton) {
        guard let res = result.text else { return }
        
        if newNumber{
            newNumber = false
            result.text = String(sender.tag)
        }
        else{
            if res == "0"{
                result.text = String(sender.tag)
            }
            else{
                result.text = res + String(sender.tag)
            }
        }
    }
    
    
    @IBAction func addDot(_ sender: Any) {
        if result.text?.contains(".") == false{
            result.text = result.text! + "."
        }
    }
    
    @IBAction func clear(_ sender: Any) {
        numbers.removeAll()
        op = ""
        result.text = "0"
        newNumber = false
    }
    
    
    @IBAction func changeSign(_ sender: Any) {
        if let num = result.text{
            if num.contains("."){
                result.text = String(-1 * Double(num)!)
            }
            else{
                result.text = String(-1 * Int(num)!)
            }
        }
    }
    
    @IBAction func operation(_ sender: UIButton) {
        
        if let number = result.text {
            if number != "0"{
                if numbers.count == 1 && newNumber == false{
                    numbers.append(Double(number)!)
                    calculate()
                    switch(sender.tag){
                    case 11: op = "*"
                    case 12: op = "-"
                    case 13: op = "+"
                    case 10: op = "/"
                    default: print("")
                    }
                    newNumber = true
                }
                else{
                    if newNumber == false{
                        numbers.append(Double(number)!)
                    }
                    switch(sender.tag){
                    case 11: op = "*"
                    case 12: op = "-"
                    case 13: op = "+"
                    case 10: op = "/"
                    default: print("")
                    }
                    newNumber = true
                }
            }
        }
        
    }
    
    @IBAction func equal(_ sender: Any) {
        if newNumber == false && op != ""{
            if let num = result.text{
                numbers.append(Double(num)!)
            }
        }
        calculate()
    }
    
    func calculate(){
        if numbers.count == 2{
            let res = NSExpression(format: "\(numbers[0])\(op)\(numbers[1])")
            print("\(numbers[0])\(op)\(numbers[1])")
            if let r = res.expressionValue(with: nil, context: nil) as? NSNumber{
                numbers.removeAll()
                op = ""
                newNumber = true
                numbers.append(r.doubleValue)
                result.text = "\(r.doubleValue)"
            }
            
        }
    }
    
    @IBAction func percentage(_ sender: Any) {
        if let num = result.text{
            if numbers.count == 0 && result.text != "0"{
                result.text = "\(Double(num)! / 100)"
            }
            else if numbers.count == 1 && newNumber == false{
                result.text = String(numbers[0]/100.0 * Double(num)!)
            }
        }
    }
    
}

