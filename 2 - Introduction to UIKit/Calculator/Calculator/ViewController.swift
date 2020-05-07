//
//  ViewController.swift
//  Calculator
//
//  Created by Terry Latanville on 2020-05-04.
//  Copyright © 2020 Tulip. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var calculatorLabel: UILabel!

    // MARK: - View Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK: - Helper Functions
    private func append(_ value: Int) {
        calculatorLabel.text = (calculatorLabel.text ?? "").appending("\(value)")
    }

    // MARK: - IBActions
    @IBAction func acTapped(_ sender: Any) {
    }
    @IBAction func signButtonTapped(_ sender: Any) {
    }
    @IBAction func percentButtonTapped(_ sender: Any) {
    }

    // MARK: - Math Functions
    @IBAction func divisionButtonTapped(_ sender: Any) {
    }
    @IBAction func multiplicationButtonTapped(_ sender: Any) {
    }
    @IBAction func subtractButtonTapped(_ sender: Any) {
    }
    @IBAction func additionButtonTapped(_ sender: Any) {
    }
    @IBAction func equalButtonTapped(_ sender: Any) {
    }

    // MARK: - Number Buttons
    @IBAction func numberTapped(_ sender: UIButton) {
        if let text = sender.titleLabel?.text,
            let number = Int(text) { // public init?(_ description: String)
            print("Couldn't find a label on \(sender)")
            append(number)
        }
    }
}

