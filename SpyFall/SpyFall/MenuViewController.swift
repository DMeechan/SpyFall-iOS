//
//  MenuViewController.swift
//  SpyFall
//
//  Created by Daniel Meechan on 31/07/2017.
//  Copyright © 2017 Rogue Studios. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    var hostingGame: Bool = false
    var user: Player = Player(name: "Jim")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Location.getSampleLocations()
        hostingGame = false
        
        // Do any additional setup after loading the view.
    }
    
    func createGame() {
        //LobbyViewController.match = Match()
        hostingGame = true
        performSegue(withIdentifier: "segueToLobby", sender: self)
    }
    
    func joinGame() {
        performSegue(withIdentifier: "segueToLobby", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if hostingGame {
            print("Hosting game")
            let lobby = segue.destination as! LobbyViewController
            lobby.match = Match(host: user)
            lobby.user = user
            
        } else {
            print("Joining game")
        }
        
    }
    
    // MARK: Extra stuff
    
    @IBAction func clickCreateGame(_ sender: Any) {
        createGame()
    }
    
    @IBAction func clickJoinGame(_ sender: Any) {
        joinGame()
    }

}
