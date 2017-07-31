//
//  Player.swift
//  SpyFall
//
//  Created by Daniel Meechan on 31/07/2017.
//  Copyright © 2017 Rogue Studios. All rights reserved.
//

import Foundation

class Player {
    let name: String
    var isHost: Bool
    var isSpy: Bool
    var isReady: Bool
    var isFirstToAsk: Bool
    var role: String
    
    init(name: String) {
        self.name = name
        self.isHost = false
        self.isSpy = false
        self.isReady = false
        self.isFirstToAsk = false
        self.role = ""
        
    }
    
}
