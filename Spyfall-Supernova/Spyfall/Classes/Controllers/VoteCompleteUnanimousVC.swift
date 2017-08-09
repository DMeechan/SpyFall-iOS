//
//  VoteCompleteUnanimousVC.swift
//  Spyfall
//
//  Created by Daniel Meechan.
//  Copyright © 2017 Rogue Studios. All rights reserved.
//

// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
// MARK: - Import

import UIKit


// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
// MARK: - Class

class VoteCompleteUnanimousVC: UIViewController {


    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
    // MARK: - Properties

    @IBOutlet fileprivate weak var exitButtonButton: UIButton!
    @IBOutlet fileprivate weak var lobbyButtonButton: UIButton!


    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
    // MARK: - Setup

    override func viewDidLoad() {

        super.viewDidLoad()
        self.setupUI()
        self.setupGestureRecognizers()
        self.setupText()
        self.setupData()
    }

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
    }

    fileprivate func setupUI() {

        // exitButtonButton
        self.exitButtonButton.layer.borderColor = UIColor(red: 0.149, green: 0.196, blue: 0.220, alpha: 1.000).cgColor
        self.exitButtonButton.layer.borderWidth = 1.0
        self.exitButtonButton.layer.cornerRadius = 3.0
        
        // lobbyButtonButton
        self.lobbyButtonButton.layer.borderColor = UIColor(red: 0.149, green: 0.196, blue: 0.220, alpha: 1.000).cgColor
        self.lobbyButtonButton.layer.borderWidth = 1.0
        self.lobbyButtonButton.layer.cornerRadius = 3.0
    }

    fileprivate func setupGestureRecognizers() {

    }

    fileprivate func setupText() {

    }

    fileprivate func setupData() {

    }


    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
    // MARK: - Actions

    @IBAction func exitButtonTouchUpInside(sender: UIButton) {

    }

    @IBAction func lobbyButtonTouchUpInside(sender: UIButton) {

    }
}









