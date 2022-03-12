//
//  FlightDetailViewController.swift
//  HiFlight
//
//  Created by shuai.wang on 2022/3/12.
//

import UIKit

class FlightDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func next(_ sender: UIButton) {
        performSegue(withIdentifier: "PaymentViewController", sender: nil)
    }
}
