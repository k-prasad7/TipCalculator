//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import Foundation

class CalculatorViewController: UIViewController {

    var calcBrain = CalculatorBrain(tipValue: 10, stepperValue: 2)
    @IBOutlet weak var splitNumberLabel: UILabel!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var billTextField: UITextField!
    
    @IBAction func tipChanged(_ sender: UIButton) {
        let tipString = sender.titleLabel?.text // e.g., "10%"
        if let tipString = tipString {
            // Remove all characters that are not digits
            let filteredTipNumber = tipString.filter { "0123456789".contains($0) }
            // Convert the filtered string to an Int
            if let tipValue = Int(filteredTipNumber) {
                print(tipValue)
                calcBrain.updateTip(tipValue: tipValue)
                updateButtonBackgroundColor(forValue: tipValue)
            }
        }
    }
    

    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(sender.value)
        print(sender.value)
        calcBrain.updateStepper(stepperValue: Int(sender.value))
    }
    
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        // First, validate the bill amount and obtain a non-optional Decimal value for it
        let validationResult = isValidMonetaryAmount(billTextField.text ?? "")
        
        guard validationResult.0, let convertedBillTotal = validationResult.1 else {
            // Handle invalid input
            let alert = UIAlertController(title: "Invalid Bill Value(s)", message: "Please adjust the bill total to a valid value", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
            return
        }
        
        // Check for a valid stepper value
        if calcBrain.stepperValue == 0 {
            let alert = UIAlertController(title: "Invalid Stepper Value(s)", message: "Please adjust the stepper total to a valid value", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        } else {
            // Proceed with calculation
            calcBrain.calculate(billAmount: convertedBillTotal)
            print(calcBrain.returnTotalAmountDue())
            self.performSegue(withIdentifier: "goToResults", sender: self)

        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults"{
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.totalPerPerson = calcBrain.returnTotalAmountDue()
            destinationVC.tipPercentage = calcBrain.tipValue
            destinationVC.numberOfPeople = calcBrain.stepperValue
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func isValidMonetaryAmount(_ input: String) -> (Bool,Decimal?) {
        let regexPattern = "^[0-9]+(\\.[0-9]{1,2})?$"
        guard let _ = input.range(of: regexPattern, options: .regularExpression) else {
            return (false,0)
        }
        return (true,Decimal(string: input))
    }

    
    func updateButtonBackgroundColor(forValue value: Int) {
        resetButtonBackgrounds()
        switch value {
        case 10:
            tenPctButton.isSelected = true
        case 20:
            twentyPctButton.isSelected = true
        case 0:
            zeroPctButton.isSelected = true
        default:
            return
        }
    }
    
    func resetButtonBackgrounds() {
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
    }
}

