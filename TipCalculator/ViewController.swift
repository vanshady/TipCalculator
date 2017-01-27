//
//  ViewController.swift
//  TipCalculator
//
//  Created by 徐旻威 on 1/27/17.
//  Copyright © 2017 Minwei Xu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    let defaults = UserDefaults.standard
    
    func changeTipLevel() {
        var tipIndex:Int
        if (defaults.object(forKey: "tipLevel") != nil) {
            tipIndex = defaults.integer(forKey: "tipLevel")
        } else {
            tipIndex = 1
        }
        
        if (tipIndex != tipControl.selectedSegmentIndex) {
            tipControl.selectedSegmentIndex = tipIndex
        }
    }
    
    func changeBill() {
        var bill:Int
        if (defaults.object(forKey: "bill") != nil && defaults.object(forKey: "time") != nil) {
            bill = defaults.integer(forKey: "bill")
            let time = defaults.object(forKey: "time") as! NSDate
            if (abs(time.timeIntervalSinceNow / 60) < 10 && billField.text != String(bill)) {
                billField.text = String(bill)
                calculateTip()
            }
        }
    }
    
    func saveBill() {
        let bill = Int(billField.text!)
        if ((bill) != nil) {
            defaults.set(bill, forKey: "bill")
            defaults.set(NSDate(), forKey: "time")
            defaults.synchronize()
        }
    }
    
    func calculateTip() {
        let tipPercentages = [0.18, 0.2, 0.25]
        
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = NSLocale.current
        tipLabel.text = formatter.string(from: tip as NSNumber)
        totalLabel.text = formatter.string(from: total as NSNumber)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeTipLevel()
        changeBill()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        billField.becomeFirstResponder()
        changeTipLevel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }

    
    @IBAction func calculateTip(_ sender: AnyObject) {
        calculateTip()
        saveBill()
    }
}

