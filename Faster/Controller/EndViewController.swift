//
//  EndViewController.swift
//  Faster
//
//  Created by Aleksandr Tsebrii on 9/7/19.
//  Copyright © 2019 Aleksandr Tsebrii. All rights reserved.
//

import UIKit
import Social
import MessageUI

class EndViewController: UIViewController {
    
    // MARK: - Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var scoreData: String!
    
    // MARK: - Outlets
    
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
    
    private let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Share", for: .normal)
        button.titleLabel?.font = UIFont.init(name: Constant.Font.Name.medium,
                                              size: Constant.Font.Size.medium)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.clear
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let emailButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Share Email", for: .normal)
        button.titleLabel?.font = UIFont.init(name: Constant.Font.Name.medium,
                                              size: Constant.Font.Size.medium)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.clear
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let smsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Share SMS", for: .normal)
        button.titleLabel?.font = UIFont.init(name: Constant.Font.Name.medium,
                                              size: Constant.Font.Size.medium)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.clear
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(smsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let restartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Restart Game", for: .normal)
        button.titleLabel?.font = UIFont.init(name: Constant.Font.Name.medium,
                                              size: Constant.Font.Size.medium)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.clear
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(restartButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        
        /// View
        
        view.backgroundColor = UIColor.Design.blue
        
        /// Time Stack View
        
        let scoreStackView = UIStackView(arrangedSubviews: [scoreLabel, scoreValueLabel])
        scoreStackView.axis = .vertical
        scoreStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scoreStackView)
        
        NSLayoutConstraint.activate([
            scoreLabel.heightAnchor.constraint(equalToConstant: 60)
            ])
        
        NSLayoutConstraint.activate([
            scoreValueLabel.heightAnchor.constraint(equalToConstant: 60)
            ])
        
        let topSpase = (view.bounds.height - 380) / 2
        
        NSLayoutConstraint.activate([
            scoreStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topSpase),
            scoreStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            scoreStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
            ])
        
        /// Buttons Stack View
        
        let buttonsStackView = UIStackView(arrangedSubviews: [shareButton, emailButton, smsButton, restartButton])
        buttonsStackView.axis = .vertical
        buttonsStackView.spacing = 8
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsStackView)
        
        NSLayoutConstraint.activate([
            shareButton.heightAnchor.constraint(equalToConstant: 60)
            ])
        
        NSLayoutConstraint.activate([
            emailButton.heightAnchor.constraint(equalToConstant: 60)
            ])
        
        NSLayoutConstraint.activate([
            smsButton.heightAnchor.constraint(equalToConstant: 60)
            ])
        
        NSLayoutConstraint.activate([
            restartButton.heightAnchor.constraint(equalToConstant: 60)
            ])
        
        NSLayoutConstraint.activate([
            buttonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
            ])
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreValueLabel.text = scoreData
        
        let userDefaults = UserDefaults.standard
        if let highScoreData = userDefaults.string(forKey: Constant.kUserDefaults.highScoreData) {
            if let previousValue = Int(highScoreData), let currentValue = Int(scoreData) {
                if currentValue > previousValue {
                    userDefaults.set(scoreData, forKey: Constant.kUserDefaults.highScoreData)
                    userDefaults.synchronize()
                }
            }
        } else {
            userDefaults.set(scoreData, forKey: Constant.kUserDefaults.highScoreData)
            userDefaults.synchronize()
        }
        
    }
    
    // MARK: - Actions
    
    @objc func shareButtonTapped() {
        
        // text to share
        let text = "I was able to make \(scoreData!) tapes in the game #fasterapp, but how much can you make?."
        
        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    @objc func emailButtonTapped() {
        
        sendEmail()
        
    }
    
    @objc func smsButtonTapped() {
        
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "I was able to make \(scoreData!) tapes in the game #fasterapp, but how much can you make?."
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Error", message: "You cannot send SMS from this device.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        
    }
    
    @objc func restartButtonTapped() {
        dismiss(animated: false, completion: nil)
        presentingViewController?.dismiss(animated: false, completion: nil)
    }
    
    // MARK: - Functions
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([""])
            mail.setMessageBody("<p>I was able to make \(scoreData!) tapes in the game #fasterapp, but how much can you make?.</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            let alert = UIAlertController(title: "Error", message: "You cannot send Email from this device.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
}

extension EndViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

extension EndViewController: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        //... handle sms screen actions
        self.dismiss(animated: true, completion: nil)
    }
}
