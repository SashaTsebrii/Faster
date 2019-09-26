//
//  WelcomViewController.swift
//  Faster
//
//  Created by Aleksandr Tsebrii on 9/5/19.
//  Copyright © 2019 Aleksandr Tsebrii. All rights reserved.
//

import UIKit

class WelcomViewController: UIViewController {
    
    // MARK: - Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Outlets
    
    private let highScoreLabel: TopLabel = {
        let label = TopLabel()
        label.text = "High Score"
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
    
    private let startGameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start Game", for: .normal)
        button.titleLabel?.font = UIFont.init(name: Constant.Font.Name.medium,
                                              size: Constant.Font.Size.medium)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.clear
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(startGameButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = UIColor.Design.blue
                
        /// High Score Stack View
        
        let highScoreStackView = UIStackView(arrangedSubviews: [highScoreLabel, scoreValueLabel])
        highScoreStackView.axis = .vertical
        highScoreStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(highScoreStackView)
        
        NSLayoutConstraint.activate([
            highScoreLabel.heightAnchor.constraint(equalToConstant: 60)
            ])
        
        NSLayoutConstraint.activate([
            scoreValueLabel.heightAnchor.constraint(equalToConstant: 60)
            ])
        
        NSLayoutConstraint.activate([
            highScoreStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            highScoreStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            highScoreStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
            ])
        
        /// Start Game Button
        
        view.addSubview(startGameButton)
        NSLayoutConstraint.activate([
            startGameButton.heightAnchor.constraint(equalToConstant: 60),
            startGameButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            startGameButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            startGameButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        
        UIView.animate(withDuration: 0.6,
                       delay: 1,
                       options: .curveLinear,
                       animations: {
                        self.startGameButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.6) {
                            self.startGameButton.transform = CGAffineTransform.identity
                        }
        })
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let userDefaults = UserDefaults.standard
        if let highScoreData = userDefaults.string(forKey: Constant.kUserDefaults.highScoreData) {
            scoreValueLabel.text = highScoreData
        } else {
            scoreValueLabel.text = "0"
        }
        
    }
    
    // MARK: - Actions
    
    @objc func startGameButtonTapped() {
        let gameViewController = GameViewController()
        present(gameViewController, animated: false, completion: nil)
    }
    
}
