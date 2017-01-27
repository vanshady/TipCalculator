//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by 徐旻威 on 1/27/17.
//  Copyright © 2017 Minwei Xu. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var tipControl: UISegmentedControl!
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()

        // Sets the title in the Navigation Bar
        self.title = "Tip Calculator"
        
        var tipIndex:Int
        if (defaults.object(forKey: "tipLevel") != nil) {
            tipIndex = defaults.integer(forKey: "tipLevel")
        } else {
            tipIndex = 1
        }
        
        tipControl.selectedSegmentIndex = tipIndex
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateDefaultTip(_ sender: Any) {
        defaults.set(Int(tipControl.selectedSegmentIndex), forKey: "tipLevel")
        defaults.synchronize()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
