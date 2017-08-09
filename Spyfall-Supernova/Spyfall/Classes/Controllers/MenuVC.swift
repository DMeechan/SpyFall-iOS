//
//  MenuVC.swift
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

class MenuVC: UIViewController {


    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
    // MARK: - Properties

    @IBOutlet fileprivate weak var newGameButton: UIButton!
    @IBOutlet fileprivate weak var joinGameButton: UIButton!


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

        // newGameButton
        self.newGameButton.layer.borderColor = UIColor(red: 0.149, green: 0.196, blue: 0.220, alpha: 1.000).cgColor
        self.newGameButton.layer.borderWidth = 1.0
        self.newGameButton.layer.cornerRadius = 3.0
        
        // joinGameButton
        self.joinGameButton.layer.borderColor = UIColor(red: 0.149, green: 0.196, blue: 0.220, alpha: 1.000).cgColor
        self.joinGameButton.layer.borderWidth = 1.0
        self.joinGameButton.layer.cornerRadius = 3.0
    }

    fileprivate func setupGestureRecognizers() {

    }

    fileprivate func setupText() {

    }

    fileprivate func setupData() {

    }


    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
    // MARK: - Actions

    @IBAction func newGameTouchUpInside(sender: UIButton) {

    }

    @IBAction func joinGameTouchUpInside(sender: UIButton) {

    }
}









