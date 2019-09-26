//
//  GameViewController.swift
//  Faster
//
//  Created by Aleksandr Tsebrii on 9/7/19.
//  Copyright © 2019 Aleksandr Tsebrii. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    // MARK: - Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var tapCounter = 0
    var startCounter = 3
    var startTimer = Timer()
    var gameCounter = 10
    var gameTimer = Timer()
    
    // MARK: - Outlets
    
    private let timeRemainingLabel: TopLabel = {
        let label = TopLabel()
        label.text = "Time Remaining"
        label.font = UIFont.init(name: Constant.Font.Name.heavy,
                                 size: Constant.Font.Size.heavy)
        label.textColor = UIColor.Design.blue
        label.textAlignment = .center
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeValueLabel: BottomLabel = {
        let label = BottomLabel()
        label.text = "10"
        label.font = UIFont.init(name: Constant.Font.Name.heavy,
                                 size: Constant.Font.Size.heavy)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let scoreLabel: TopLabel = {
        let label = TopLabel()
        label.text = "Score"
        label.font = UIFont.init(name: Constant.Font.Name.heavy,
                                 size: Constant.Font.Size.heavy)
        label.textColor = UIColor.Design.blue
        label.textAlignment = .center
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let scoreValueLabel: BottomLabel = {
        let label = BottomLabel()
        label.text = "0"
        label.font = UIFont.init(name: Constant.Font.Name.heavy,
                                 size: Constant.Font.Size.heavy)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tapButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tap Me", for: .normal)
        button.titleLabel?.font = UIFont.init(name: Constant.Font.Name.medium,
                                              size: Constant.Font.Size.medium)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.clear
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        
        /// Variables
        
        let halfView = view.bounds.height / 2
        let labelHight = (halfView / 4) - 32
        
        /// View
        
        view.backgroundColor = UIColor.Design.blue
        
        navigationController?.navigationBar.topItem?.title = "New Game"
        
        /// Time Stack View
        
        let timeStackView = UIStackView(arrangedSubviews: [timeRemainingLabel, timeValueLabel])
        timeStackView.axis = .vertical
        timeStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timeStackView)
        
        NSLayoutConstraint.activate([
            timeRemainingLabel.heightAnchor.constraint(equalToConstant: labelHight)
            ])
        
        NSLayoutConstraint.activate([
            timeValueLabel.heightAnchor.constraint(equalToConstant: labelHight)
            ])
        
        NSLayoutConstraint.activate([
            timeStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            timeStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            timeStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
            ])
        
        /// Score Stack View
        
        let scoreStackView = UIStackView(arrangedSubviews: [scoreLabel, scoreValueLabel])
        scoreStackView.axis = .vertical
        scoreStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scoreStackView)
        
        NSLayoutConstraint.activate([
            scoreLabel.heightAnchor.constraint(equalToConstant: labelHight)
            ])
        
        NSLayoutConstraint.activate([
            scoreValueLabel.heightAnchor.constraint(equalToConstant: labelHight)
            ])
        
        NSLayoutConstraint.activate([
            scoreStackView.topAnchor.constraint(equalTo: timeStackView.bottomAnchor, constant: 16),
            scoreStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            scoreStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
            ])
        
        /// Tap Button
        
        view.addSubview(tapButton)
        NSLayoutConstraint.activate([
            tapButton.heightAnchor.constraint(equalToConstant: halfView - (16 * 2)),
            tapButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tapButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tapButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tapCounter = 0
        scoreValueLabel.text = String(tapCounter)
        
        startCounter = 3
        tapButton.setTitle(String(startCounter), for: .normal)
        tapButton.isEnabled = false
        
        startTimer = Timer.scheduledTimer(timeInterval: 1,
                                          target: self,
                                          selector: #selector(GameViewController.startGameTimer),
                                          userInfo: nil,
                                          repeats: true)
        
        gameCounter = 10
        timeValueLabel.text = String(gameCounter)
        
    }
    
    // MARK: - Actions
    
    @objc func tapButtonTapped() {
        
        tapCounter += 1
        scoreValueLabel.text = String(tapCounter)
        
    }
    
    // MARK: - Functions
    
    @objc func startGameTimer() {
        startCounter -= 1
        tapButton.setTitle(String(startCounter), for: .normal)
        
        if startCounter == 0 {
            
            startTimer.invalidate()
            
            tapButton.setTitle("Tap Me", for: .normal)
            tapButton.isEnabled = true
            
            gameTimer = Timer.scheduledTimer(timeInterval: 1,
                                             target: self,
                                             selector: #selector(GameViewController.game),
                                             userInfo: nil,
                                             repeats: true)
            
        }
    }
    
    @objc func game() {
        
        gameCounter -= 1
        timeValueLabel.text = String(gameCounter)
        
        if gameCounter == 0 {
            
            gameTimer.invalidate()
            tapButton.isEnabled = false
            
            Timer.scheduledTimer(timeInterval: 2,
                                 target: self,
                                 selector: #selector(GameViewController.end),
                                 userInfo: nil,
                                 repeats: false)
            
        }
        
    }
    
    @objc func end() {
        
        let endViewController = EndViewController()
        endViewController.scoreData = scoreValueLabel.text
        present(endViewController, animated: false, completion: nil)
        
    }
    
}
