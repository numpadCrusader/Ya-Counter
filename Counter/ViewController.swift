//
//  ViewController.swift
//  Counter
//
//  Created by Nikita Khon on 19.11.2024.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IB Outlets
    
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var changeHistoryLabel: UILabel!
    @IBOutlet weak var changeHistoryText: UITextView!
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var incrementButton: UIButton!
    
    // MARK: - Private Properties
    
    private let counterLabelPrefix = "Значение счётчика\n"
    private var count = 0
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateCounterLabelText("\(counterLabelPrefix)\(count)")
    }
    
    // MARK: - IB Actions
    
    @IBAction func decrementCounter(_ sender: Any) {
        if count == 0 {
            updateChangeHistory(with: .wrongDecrement)
            return
        }
        
        count -= 1

        updateCounterLabelText("\(counterLabelPrefix)\(count)")
        updateChangeHistory(with: .decrement)
    }
    
    @IBAction func refreshCounter(_ sender: Any) {
        count = 0
        
        updateCounterLabelText("\(counterLabelPrefix)\(count)")
        updateChangeHistory(with: .refresh)
    }
    
    @IBAction func incrementCounter(_ sender: Any) {
        count += 1
        
        updateCounterLabelText("\(counterLabelPrefix)\(count)")
        updateChangeHistory(with: .increment)
    }
    
    // MARK: - Private Methods
    
    private func updateCounterLabelText(_ newText: String) {
        counterLabel.text = newText
    }
    
    private func updateChangeHistory(with action: ButtonActions) {
        let currentDateAndTime = createFormattedDate()
        
        switch action {
        case .increment:
            changeHistoryText.text += "\n[\(currentDateAndTime)]: значение изменено на +1\n"
        case .decrement:
            changeHistoryText.text += "\n[\(currentDateAndTime)]: значение изменено на -1\n"
        case .wrongDecrement:
            changeHistoryText.text += "\n[\(currentDateAndTime)]: попытка уменьшить значение счётчика ниже 0\n"
        case .refresh:
            changeHistoryText.text += "\n[\(currentDateAndTime)]: значение сброшено\n"
        }
    }
    
    private func createFormattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy - HH:mm:ss.SSS"
        return formatter.string(from: Date())
    }
}

private enum ButtonActions {
    case increment
    case decrement
    case wrongDecrement
    case refresh
}
