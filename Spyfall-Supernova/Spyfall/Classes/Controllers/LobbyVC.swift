//
//  LobbyVC.swift
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

class LobbyVC: UIViewController {


    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
    // MARK: - Properties

    @IBOutlet fileprivate weak var line: UIView!
    @IBOutlet fileprivate weak var lineTwo: UIView!
    @IBOutlet fileprivate weak var lineThree: UIView!
    @IBOutlet fileprivate weak var lineFour: UIView!
    @IBOutlet fileprivate weak var lineFive: UIView!
    @IBOutlet fileprivate weak var readyUpButtonButton: UIButton!
    @IBOutlet fileprivate weak var backButtonButton: UIButton!


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
        
        // lineThree
        self.lineThree.layer.borderColor = UIColor(red: 0.592, green: 0.592, blue: 0.592, alpha: 1.000).cgColor
        self.lineThree.layer.borderWidth = 1.0
        
        // lineFour
        self.lineFour.layer.borderColor = UIColor(red: 0.592, green: 0.592, blue: 0.592, alpha: 1.000).cgColor
        self.lineFour.layer.borderWidth = 1.0
        
        // lineFive
        self.lineFive.layer.borderColor = UIColor(red: 0.592, green: 0.592, blue: 0.592, alpha: 1.000).cgColor
        self.lineFive.layer.borderWidth = 1.0
        
        // readyUpButtonButton
        self.readyUpButtonButton.layer.borderColor = UIColor(red: 0.149, green: 0.196, blue: 0.220, alpha: 1.000).cgColor
        self.readyUpButtonButton.layer.borderWidth = 1.0
        self.readyUpButtonButton.layer.cornerRadius = 3.0
    }

    fileprivate func setupGestureRecognizers() {

    }

    fileprivate func setupText() {

    }

    fileprivate func setupData() {

    }


    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
    // MARK: - Actions

    @IBAction func readyUpButtonTouchUpInside(sender: UIButton) {

    }

    @IBAction func backButtonTouchUpInside(sender: UIButton) {

    }

    @IBAction func switchValueChanged(sender: UISwitch) {

    }
}









