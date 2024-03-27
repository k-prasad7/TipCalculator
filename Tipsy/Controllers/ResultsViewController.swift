//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by Kiran Prasad on 3/26/24.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    var totalPerPerson : Decimal?
    var tipPercentage : Int = 0
    var numberOfPeople : Int = 0
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        totalLabel.text = "\(totalPerPerson ?? 0.0)"
        settingsLabel.text = "Split between \(numberOfPeople) people, with \(tipPercentage)% tip."
    }
    

    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
