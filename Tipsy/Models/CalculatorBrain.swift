//
//  CalculatorBrain.swift
//  Tipsy
//
//  Created by Kiran Prasad on 3/26/24.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import Foundation

struct CalculatorBrain{
    var tipValue : Int
    var stepperValue : Int
    var totalPerPerson : Decimal
    
    init(tipValue: Int, stepperValue: Int, totalPerPerson: Decimal = 0) {
        self.tipValue = tipValue
        self.stepperValue = stepperValue
        self.totalPerPerson = totalPerPerson
    }
    mutating func updateTip(tipValue: Int){
        self.tipValue = tipValue
    }
    mutating func updateStepper(stepperValue: Int){
        self.stepperValue = stepperValue
    }
    
    mutating func calculate(billAmount: Decimal) {
        let tipPercentage = Decimal(tipValue) / 100
        let tipAmount = billAmount * tipPercentage
        let totalAmount = billAmount + tipAmount
        let calculatedValue = totalAmount / Decimal(stepperValue)
        totalPerPerson = calculatedValue.rounded(2, .plain)
    }
    
    func returnTotalAmountDue()-> Decimal{
        return totalPerPerson
    }

}

extension Decimal {
    /// Rounds the decimal to a specified number of decimal places.
    /// - Parameters:
    ///   - places: The number of decimal places to round to.
    ///   - roundingMode: The rounding mode to use.
    /// - Returns: The rounded decimal.
    func rounded(_ places: Int, _ roundingMode: NSDecimalNumber.RoundingMode) -> Decimal {
        var result = Decimal()
        var original = self
        NSDecimalRound(&result, &original, places, roundingMode)
        return result
    }
}

