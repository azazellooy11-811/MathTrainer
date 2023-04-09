//
//  ViewController.swift
//  MathTrainer
//
//  Created by Азалия Халилова on 30.03.2023.
//

import UIKit

enum MathTypes: Int {
    case add, subtract, multiply, divide
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
    private var selectedType: MathTypes = .add
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButtons()
    }
    
    //MARK: - Actions
    @IBAction func buttonsAction(_ sender: UIButton) {
        selectedType = MathTypes(rawValue: sender.tag) ?? .add
        performSegue(withIdentifier: "goToNext", sender: sender)
    }
    
    @IBAction func unwindAction(unwindSegue: UIStoryboardSegue) {
        guard let viewContoller = unwindSegue.source as? TrainViewController else { return }
            switch viewContoller.type {
            case .add:
                addCount += viewContoller.count
                addCountLabel.text = String(addCount)
            case .subtract:
                subtractCount += viewContoller.count
                subtractCountLabel.text = String(subtractCount)
            case .multiply:
                multiplyCount += viewContoller.count
                multiplyCountLabel.text = String(multiplyCount)
            case .divide:
                divideCount += viewContoller.count
                divideCountLabel.text = String(divideCount)
            }
        
        totalScoreLabel.text = "Total score: \(addCount + subtractCount + multiplyCount + divideCount)"
    }
    
    //MARK: - Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? TrainViewController {
            viewController.type = selectedType
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
