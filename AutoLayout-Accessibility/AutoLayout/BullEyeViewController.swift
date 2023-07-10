//
//  ViewController.swift
//  AutoLayout
//
//  Created by ROHIT MISHRA on 09/05/23.
//

import UIKit

class BullEyeViewController: UIViewController {
    private let bullEyeModel = BullEyeModel()
    private let bullEyeView = BullEyeView()

    private var randomNumber: Int = Int.random(in: 1...100) {
        didSet {
            let text = bullEyeModel.mainTitle +
            String(randomNumber)
            bullEyeView.mainLabel.text = text
            setAccessibility(element: bullEyeView.mainLabel, text: text)
        }
    }
    
    private var currentScore: Int = 0 {
        didSet {
            if currentScore != 0{
                currentScore = oldValue + currentScore
            } else {
                currentScore = 0
            }
            let text = bullEyeModel.scoreLabel + String(currentScore)
            bullEyeView.scoreLabel.text = text
            setAccessibility(element: bullEyeView.scoreLabel, text: text)
        }
    }
    
    private var round: Int  = 1 {
        didSet{
            let text  = bullEyeModel.roundLabel + String(round)
            bullEyeView.roundLabel.text = text
            setAccessibility(element: bullEyeView.roundLabel, text: text)

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }

    // MARK: - Private methods
    
    private func setUpView() {
        // Configure subview.
        configureMainLabel()
        configureHitButton()
        configureStartOver()
        configureScoreLabel()
        configureRoundLabel()
        configureInfoButton()
        configureSlider()
        
        bullEyeView.frame = view.bounds
        view = bullEyeView
    }
    
    func configureMainLabel() {
        bullEyeView.mainLabel.text = bullEyeModel.mainTitle + String(randomNumber)
    }

    func configureHitButton() {
        setAccessibility(element: bullEyeView.hitMeButton, text: bullEyeModel.hitMeButton)
        bullEyeView.hitMeButton.setTitle(bullEyeModel.hitMeButton, for: .normal)
        bullEyeView.hitMeButton.addTarget(self, action: #selector(hitButtonTapped), for: .touchUpInside)
    }
    
    private func configureStartOver() {
        setAccessibility(element: bullEyeView.startOverButton, text: bullEyeModel.startOverLabel)
        bullEyeView.startOverButton.setTitle(bullEyeModel.startOverLabel, for: .normal)
        bullEyeView.startOverButton.addTarget(self, action: #selector(StartOverButtonTapped), for: .touchUpInside)
    }
    
    private func configureInfoButton() {
        setAccessibility(element: bullEyeView.infoButton, text: bullEyeModel.infoButton)
        bullEyeView.infoButton.setTitle(bullEyeModel.infoButton, for: .normal)
        bullEyeView.infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
    }
    
    private func configureScoreLabel() {
        bullEyeView.scoreLabel.text = bullEyeModel.scoreLabel + String(currentScore)
    }
    
    private func configureRoundLabel() {
        bullEyeView.roundLabel.text = bullEyeModel.roundLabel + String(round)
    }
    
    private func configureSlider() {
        bullEyeView.slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }
    
    // MARK: - Element  actions
    
    @objc func hitButtonTapped() {
        round += 1
        randomNumber = Int.random(in: 1...100)
        
        let currentValue = Int(bullEyeView.slider.value)
        if currentValue == randomNumber {
            currentScore = 100
        } else {
            currentScore = 100 - Int(abs(currentValue - randomNumber))
        }
    }
    
    @objc func StartOverButtonTapped() {
        round = 1
        randomNumber = Int.random(in: 1...100)
        currentScore = 0
    }
    
    @objc func infoButtonTapped() {
        let alertController = UIAlertController(title: "Bull Eye", message: "Current Score: \(currentScore) \n Round: \(round)" , preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // Handle OK button tap
        }
        
        alertController.addAction(okAction)

        present(alertController, animated: true, completion: nil)
    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        let value  = String(Int(sender.value))
        setAccessibility(
            element: bullEyeView.slider,
            text: bullEyeModel.sliderCurrentValue + value)
    }
    
    // MARK: - Set Accessibility

    public func setAccessibility(element: UIView, text:String) {
        element.isAccessibilityElement = true
        if element is UILabel {
            element.accessibilityTraits = .header
            element.accessibilityLabel = text
        } else if element is UIButton {
            element.accessibilityTraits = .button
            element.accessibilityLabel = text
        } else if element is UISlider {
            element.accessibilityTraits = .none
            element.accessibilityLabel = text
        }
    }
    
    // MARK: - public method

    public func appDidBecomeActive() {
        let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body)
        if fontDescriptor.pointSize > 33 {
            bullEyeView.changeStackAxisIfNeed(axis:true)
        } else {
            bullEyeView.changeStackAxisIfNeed(axis:false)
        }
    }
}

