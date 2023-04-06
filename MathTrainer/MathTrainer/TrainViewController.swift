//
//  TrainViewController.swift
//  MathTrainer
//
//  Created by Азалия Халилова on 30.03.2023.
//

import UIKit

final class TrainViewController: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    
    //MARK: - Properties
    var type: MathTypes = .add {
        didSet {
            switch type {
            case .add:
                sign = "+"
            case .subtract:
                sign = "-"
            case .multiply:
                sign = "*"
            case .divide:
                sign = "/"
            }
        }
    }
    
    private var firstNumber: Int = 0
    private var secondNumber: Int = 0
    private var sign: String = ""
    private var count: Int = 0 {
        didSet {
            print("Count: \(count)")
        }
    }
    
    private var correctAnswer: Int {
        switch type {
        case .add:
            return firstNumber + secondNumber
        case .subtract:
            return firstNumber - secondNumber
        case .multiply:
            return firstNumber * secondNumber
        case .divide:
            return firstNumber / secondNumber
        }
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureQuestion()
        configureButtons()
    }
    //MARK: - IBActions
    @IBAction func leftAction(_ sender: UIButton) {
        check(correctAnswer: sender.titleLabel?.text ?? "",
              for: sender)
    }
    @IBAction func rightAction(_ sender: UIButton) {
        check(correctAnswer: sender.titleLabel?.text ?? "",
              for: sender)
    }
    
    //MARK: - Methods
    private func configureButtons() {
        let buttonsArray = [leftButton, rightButton]
        
        buttonsArray.forEach { button in
            button?.backgroundColor = .systemYellow
        }
        
        buttonsArray.forEach { button in
            button?.layer.shadowColor = UIColor.darkGray.cgColor
            button?.layer.shadowOffset = CGSize.init(width: 0, height: 2)
            button?.layer.shadowOpacity = 0.4
            button?.layer.shadowRadius = 3
        }
        
        let isRightButton: Bool = Bool.random()
        var randomIncorrectAnswer: Int
        repeat {
            randomIncorrectAnswer = Int.random(in: (correctAnswer - 5) ... (correctAnswer + 5))
        } while randomIncorrectAnswer == correctAnswer
        
        rightButton.setTitle(isRightButton ? String(correctAnswer) : String(randomIncorrectAnswer),
                             for: .normal)
        leftButton.setTitle(isRightButton ? String(randomIncorrectAnswer) : String(correctAnswer),
                            for: .normal)
    }
    
    private func configureQuestion() {
        firstNumber = Int.random(in: 1...99)
        secondNumber = Int.random(in: 1...99)
        
        questionLabel.text = "\(firstNumber) \(sign) \(secondNumber)="
    }
    
    private func getAnswer() -> Int {
        switch type {
        case .add:
            return firstNumber + secondNumber
        case .subtract:
            return firstNumber - secondNumber
        case .multiply:
            return firstNumber * secondNumber
        case .divide:
            return firstNumber / secondNumber
        }
    }
    
    private func check(correctAnswer: String, for button: UIButton) {
        let isRightAnswer = Int(correctAnswer) == self.correctAnswer
        
        button.backgroundColor = isRightAnswer ? .green : .red
        
        if isRightAnswer {
            let isSecondAttempt: Bool = leftButton.backgroundColor == .red ||
            rightButton.backgroundColor == .red
            count += isSecondAttempt ? 0 : 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.configureQuestion()
                self?.configureButtons()
            }
        }
    }
}
