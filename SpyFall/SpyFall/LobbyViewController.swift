//
//  LobbyViewController.swift
//  SpyFall
//
//  Created by Daniel Meechan on 31/07/2017.
//  Copyright © 2017 Rogue Studios. All rights reserved.
//

import UIKit

class LobbyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Timer.scheduledTimer(timeInterval: transitionTime, target:self, selector: #selector(ViewController.function), userInfo: nil, repeats: false)
    
    var match:Match?
    var user:Player?
    var userIsHost: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if match == nil || user == nil {
            print("FATAL ERROR: match object or player object is empty")
            
        }
        
        if (user?.isHost)! {
            userIsHost = true
            
        }
        
        match?.add(player: Player(name: "Oliver"), isHost: false)
        match?.add(player: Player(name: "David"), isHost: false)
        match?.add(player: Player(name: "Alex"), isHost: false)
        
        match?.listPlayers()
        
        updateUI()
        
        //for player in (match?.players)! {
            // player.isReady = true
        //}

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PlayerTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PlayerTableViewCell else {
            fatalError("The dequeued cell is not an instance of PlayerTableViewCell")
        }
        
        let player = match?.players[indexPath.row]
        print("Table looking at player: \(player?.name ?? "UNKNOWN")")
        
        cell.nameLabel?.text = player?.name
        
        if (player?.isReady)! {
            cell.readyImage.image = UIImage(named: "tick")
        } else {
            cell.readyImage.image = UIImage(named: "cross")
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (match?.players.count)!
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func updateUI() {
        
        gameIDLabel?.text = "Game ID: \(match?.accessCode ?? "")"
        
        if match?.status == 0 {
            // Waiting for players
            gameStatusLabel.text = "Waiting for players to ready up..."
            
        } else if match?.status == 1 {
            // Waiting for host
            gameStatusLabel.text = "Waiting for host to start game..."
            
        } else {
            print("Error, should not be in lobby if game status > 1")
            
        }
        
        if userIsHost {
            // User is host, so needs to start game
            actionButton?.setTitle("START GAME", for: .normal)
            
        } else {
            // User is a standard player who needs to ready up
            
            if (user?.isReady)! {
                // User is ready
                actionButton.setTitle("READY", for: .normal)
                
            } else {
                // User is not ready
                actionButton.setTitle("CLICK TO READY UP", for: .normal)
                
            }
            
        }
        
    }
    
    func isPlayersReady() -> Bool {
        for player in (match?.players)! {
            if player.isReady == false {
                return false
            }
        }
        
        return true
    }
    
    func startGame() {
        
    }
    
    
    // MARK: Extra stuff
    
    
    @IBAction func clickActionButton(_ sender: Any) {
        match?.players.removeLast()
        match?.listPlayers()
        
        if userIsHost {
            if isPlayersReady() {
                // Players are ready
                startGame()
                
            } else {
                // Players not ready
                actionButton.setTitle("PLAYERS NOT YET READY", for: .normal)
                Timer.scheduledTimer(timeInterval: 2, target:self, selector: #selector(LobbyViewController.updateUI), userInfo: nil, repeats: false)
                
            }
            
        } else {
            // User is a normal player
            if (user?.isReady)! {
                // Mark as not ready
                user?.isReady = false
                
            } else {
                // Mark as ready
                user?.isReady = true
                
            }
            
        }
        
    }

    @IBAction func clickExit(_ sender: Any) {
        performSegue(withIdentifier: "segueToMenu", sender: self)
        
    }
    
    @IBAction func clickShareGameID(_ sender: Any) {
        
    }
    
    @IBOutlet weak var gameStatusLabel: UILabel!
    @IBOutlet weak var gameIDLabel: UILabel!
    @IBOutlet weak var actionButton: SquareButton!
    
    @IBOutlet weak var playersTableView: UITableView!
    
}
