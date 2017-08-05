//
//  RoundViewController.swift
//  SpyFall
//
//  Created by Daniel Meechan on 31/07/2017.
//  Copyright © 2017 Rogue Studios. All rights reserved.
//

import UIKit

class RoundViewController: UIViewController {
  // var timer: Timer
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if DataManager.shared.user.spy {
        // User is the spy
        locationLabel.text = "Location: ???"
        roleLabel.text = "You are the spy!"
        
    } else {
        // User is not the spy
        
        
    }
    
  }
  
  func start() {
    
  }
  
  
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
}
