//
//  BullEyeView.swift
//  AutoLayout
//
//  Created by ROHIT MISHRA on 09/05/23.
//

import UIKit

class BullEyeView: UIView {
    
    let mainLabel: UILabel = {
     let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.numberOfLines = 3
        label.textAlignment = .center
        label.backgroundColor = .white
        return label
    }()
    
    let sliderStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    let slider: UISlider = {
        let slider  = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 100
        
        return slider
    }()
    
    let hitMeButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    let startOverButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    let scoreLabel: UILabel = {
       let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for:UIFont.systemFont(ofSize: 14, weight: .regular))
        return label
    }()
    
    let roundLabel: UILabel = {
       let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for:UIFont.systemFont(ofSize: 14, weight: .regular))
        return label
    }()
    
    let infoButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setUpSubView()
    }
    
    func setUpSubView() {
        addSubview(mainLabel)
        addSubview(slider)
        addSubview(hitMeButton)
        
        setUpSliderStackView()
        
        // Set up button label row.
        setpUpRow()
        
        // Adding required constraints.
        mainLabelConstraint()
        sliderStackViewConstraint()
        hitMeButtonConstaint()
        stackViewConstraints()
    }

    func setUpSliderStackView() {
        let minValueLabel = UILabel()
        let maxValueLabel = UILabel()
        
        minValueLabel.text = "1"
        maxValueLabel.text = "100"
        
        sliderStackView.addArrangedSubview(minValueLabel)
        sliderStackView.addArrangedSubview(slider)
        sliderStackView.addArrangedSubview(maxValueLabel)
        addSubview(sliderStackView)
    }
    
    func setpUpRow() {
        setUpView1()
        setUpView2()
        addSubview(stackView)
    }
    
    func setUpView1() {
        let view1 = UIView()
        view1.addSubview(startOverButton)
        view1.addSubview(scoreLabel)
        
        startOverButton.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            startOverButton.topAnchor.constraint(equalTo: view1.topAnchor),
            startOverButton.leadingAnchor.constraint(equalTo: view1.leadingAnchor),
            startOverButton.trailingAnchor.constraint(equalTo: scoreLabel.leadingAnchor, constant: -10),
            startOverButton.bottomAnchor.constraint(equalTo: view1.bottomAnchor),
            scoreLabel.topAnchor.constraint(equalTo: view1.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view1.trailingAnchor),
            scoreLabel.bottomAnchor.constraint(equalTo: view1.bottomAnchor)
        ])
        stackView.addArrangedSubview(view1)
    }
    
    func setUpView2() {
        let view2 = UIView()
        view2.addSubview(roundLabel)
        view2.addSubview(infoButton)
        
        roundLabel.translatesAutoresizingMaskIntoConstraints = false
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            roundLabel.topAnchor.constraint(equalTo: view2.topAnchor),
            roundLabel.leadingAnchor.constraint(equalTo: view2.leadingAnchor),
            roundLabel.trailingAnchor.constraint(equalTo: infoButton.leadingAnchor, constant: -10),
            roundLabel.bottomAnchor.constraint(equalTo: view2.bottomAnchor),
            infoButton.topAnchor.constraint(equalTo: view2.topAnchor),
            infoButton.trailingAnchor.constraint(equalTo: view2.trailingAnchor),
            infoButton.bottomAnchor.constraint(equalTo: view2.bottomAnchor)
        ])

        stackView.addArrangedSubview(view2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func mainLabelConstraint() {
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            mainLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            mainLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor , constant: 20.0)
        ])
    }
    
    func sliderStackViewConstraint() {
        sliderStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            sliderStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            sliderStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10.0),
            sliderStackView.topAnchor.constraint(equalTo:mainLabel.bottomAnchor , constant: 15.0)
        ])
    }
    
    func hitMeButtonConstaint() {
        hitMeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hitMeButton.topAnchor.constraint(greaterThanOrEqualTo: slider.bottomAnchor, constant: 50.0),
            hitMeButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            hitMeButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func stackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: hitMeButton.bottomAnchor, constant: 25.0),
            stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - public methods

    public func changeStackAxisIfNeed(axis: Bool) {
        if axis {
            stackView.axis = .vertical
        } else {
            stackView.axis = .horizontal
        }
    }
}
