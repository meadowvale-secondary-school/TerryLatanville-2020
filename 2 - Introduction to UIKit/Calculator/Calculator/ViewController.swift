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
    @IBOutlet var operatorButtons: [UIButton]!

    // MARK: - Properties
    private var lastButtonPressed: UIButton?
    private var lastButtonOriginalColor: UIColor?
    private var lastValue: Double?
    private var currentValue: Double = 0 {
        didSet {
            if hasDecimal(currentValue) {
                calculatorLabel.text = String(currentValue)
            } else {
                calculatorLabel.text = String(format: "%.0f", currentValue)
            }
        }
    }
    private var currentOperator: ((Double, Double) -> Double)?

    // MARK: - Operator Functions
    private func add(lhs: Double, rhs: Double) -> Double {
        return lhs + rhs
    }
    private func subtract(lhs: Double, rhs: Double) -> Double {
        return lhs - rhs
    }
    private func multiply(lhs: Double, rhs: Double) -> Double {
        return lhs * rhs
    }
    private func divide(lhs: Double, rhs: Double) -> Double {
        return lhs / rhs
    }

    // MARK: - Helper Functions
    private func hasDecimal(_ value: Double) -> Bool {
        return Double(Int(value)) != value
    }

    private func append(_ value: Int, replaceText: Bool = false) {
        let originalText = calculatorLabel.text ?? ""
        if let textValue = Double(originalText), textValue == 0 {
            currentValue = Double(value)
        } else if replaceText {
            if let textValue = Double(originalText) {
                lastValue = textValue
            }
            currentValue = Double(value)
        } else {
            let updatedValue = originalText.appending(String(value))
            currentValue = Double(updatedValue) ?? 0
        }
    }

    private func buttonTapped(_ button: UIButton, autoDeselect: Bool = true) {
        lastButtonPressed?.backgroundColor = lastButtonOriginalColor
        lastButtonOriginalColor = button.backgroundColor
        lastButtonPressed = button
        button.backgroundColor = .white
        guard autoDeselect else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.lastButtonPressed?.backgroundColor = self.lastButtonOriginalColor
            self.lastButtonPressed = nil
            self.lastButtonOriginalColor = nil
        }
    }

    // MARK: - IBActions
    @IBAction func acTapped(_ sender: UIButton) {
        buttonTapped(sender)
        calculatorLabel.text = "0"
        currentValue = 0
    }
    @IBAction func signButtonTapped(_ sender: UIButton) {
        defer { buttonTapped(sender) }
        guard currentValue != 0
            else { return }
        currentValue = -currentValue
    }
    @IBAction func percentButtonTapped(_ sender: UIButton) {
        currentValue /= 100
        buttonTapped(sender)
    }

    // MARK: - Math Functions
    @IBAction func divisionButtonTapped(_ sender: UIButton) {
        currentOperator = divide
        buttonTapped(sender, autoDeselect: false)
    }
    @IBAction func multiplicationButtonTapped(_ sender: UIButton) {
        currentOperator = multiply
        buttonTapped(sender, autoDeselect: false)
    }
    @IBAction func subtractButtonTapped(_ sender: UIButton) {
        currentOperator = subtract
        buttonTapped(sender, autoDeselect: false)
    }
    @IBAction func additionButtonTapped(_ sender: UIButton) {
        currentOperator = add
        buttonTapped(sender, autoDeselect: false)
    }
    @IBAction func equalButtonTapped(_ sender: UIButton) {
        // Do nothing unless we have a valid last value, or
        defer { buttonTapped(sender) }
        guard let lastValue = lastValue,
            let currentOperator = currentOperator
            else { return }
        let calculatedValue = currentOperator(lastValue, currentValue)
        self.lastValue = currentValue
        currentValue = calculatedValue
        self.currentOperator = nil
    }

    // MARK: - Number Buttons
    @IBAction func decimalTapped(_ sender: UIButton) {
        defer { buttonTapped(sender) }
        guard !hasDecimal(currentValue) else { return } // Already a decimal
        calculatorLabel.text = String(format: "%.0f.", currentValue)
    }

    @IBAction func numberTapped(_ sender: UIButton) {
        if let text = sender.titleLabel?.text,
            let number = Int(text) { // public init?(_ description: String)
            let replaceText = (lastButtonPressed != nil && operatorButtons.contains(lastButtonPressed!))
            append(number, replaceText: replaceText)
        }
        buttonTapped(sender)
    }
}
