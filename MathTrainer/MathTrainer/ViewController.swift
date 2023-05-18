//
//  ViewController.swift
//  MathTrainer
//
//  Created by Азалия Халилова on 30.03.2023.
//

import UIKit

enum MathTypes: Int, CaseIterable {
    case add, subtract, multiply, divide
    
    var key: String {
        switch self {
        case .add:
            return "addCount"
        case .subtract:
            return "subtractCount"
        case .multiply:
            return "multiplyCount"
        case .divide:
            return "divideCount"
        }
    }
}

class ViewController: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet var buttonsCollection: [UIButton]!
    @IBOutlet weak var addCountLabel: UILabel!
    @IBOutlet weak var subtractCountLabel: UILabel!
    @IBOutlet weak var multiplyCountLabel: UILabel!
    @IBOutlet weak var divideCountLabel: UILabel!
    @IBOutlet weak var totalScoreLabel: UILabel!
    
    //MARK: - Properties
    var addCount: Int = 0
    var subtractCount: Int = 0
    var multiplyCount: Int = 0
    var divideCount: Int = 0
    var totalScore: Int = 0 
    
    private var selectedType: MathTypes = .add
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButtons()
        setCountLabel()
        
        totalScoreLabel.text = "Score: \(totalScore)"
    }
    
    //MARK: - Actions
    
    @IBAction func ClearAction(_ sender: Any) {
        MathTypes.allCases.forEach { type in
            let key = type.key
            UserDefaults.standard.removeObject(forKey: key)
            addCountLabel.text = "0"
            subtractCountLabel.text = "0"
            multiplyCountLabel.text = "0"
            divideCountLabel.text = "0"
            totalScore = 0
            totalScoreLabel.text = "0"
        }
    }
    
    @IBAction func buttonsAction(_ sender: UIButton) {
        selectedType = MathTypes(rawValue: sender.tag) ?? .add
        performSegue(withIdentifier: "goToNext", sender: sender)
    }
    
    @IBAction func unwindAction(unwindSegue: UIStoryboardSegue) {
        setCountLabel()
        //        guard let viewContoller = unwindSegue.source as? TrainViewController else { return }
        //            switch viewContoller.type {
        //            case .add:
        //                addCount += viewContoller.count
        //                addCountLabel.text = String(addCount)
        //            case .subtract:
        //                subtractCount += viewContoller.count
        //                subtractCountLabel.text = String(subtractCount)
        //            case .multiply:
        //                multiplyCount += viewContoller.count
        //                multiplyCountLabel.text = String(multiplyCount)
        //            case .divide:
        //                divideCount += viewContoller.count
        //                divideCountLabel.text = String(divideCount)
        //            }
        
    }
    
    //MARK: - Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? TrainViewController {
            viewController.type = selectedType
        }
    }
    
    private func setCountLabel(){
        totalScore = 0
        MathTypes.allCases.forEach { type in
            guard let count = UserDefaults.standard.object(forKey: type.key) as? Int else { return }
            switch type {
            case .add:
                addCountLabel.text = String(count)
            case .subtract:
                subtractCountLabel.text = String(count)
            case .multiply:
                multiplyCountLabel.text = String(count)
            case .divide:
                divideCountLabel.text = String(count)
            }
            totalScore += count
            totalScoreLabel.text = "Score: \(totalScore)"
        }
    }
    
    private func configureButtons() {
        // Add shadow
        buttonsCollection.forEach { button in
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOffset = CGSize.init(width: 0, height: 2)
            button.layer.shadowOpacity = 0.4
            button.layer.shadowRadius = 3
        }
    }
}
