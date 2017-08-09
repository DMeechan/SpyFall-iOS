//
//  RoundClickToVoteVC.swift
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

class RoundClickToVoteVC: UIViewController {


    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
    // MARK: - Properties

    @IBOutlet fileprivate weak var line: UIView!
    @IBOutlet fileprivate weak var lineTwo: UIView!


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

        // line
        self.line.layer.borderColor = UIColor(red: 0.592, green: 0.592, blue: 0.592, alpha: 1.000).cgColor
        self.line.layer.borderWidth = 1.0
        
        // lineTwo
        self.lineTwo.layer.borderColor = UIColor(red: 0.592, green: 0.592, blue: 0.592, alpha: 1.000).cgColor
        self.lineTwo.layer.borderWidth = 1.0
    }

    fileprivate func setupGestureRecognizers() {

    }

    fileprivate func setupText() {

    }

    fileprivate func setupData() {

    }


    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
    // MARK: - Actions

    @IBAction func backButtonTouchUpInside(sender: UIButton) {

    }
}









