//
//  DataManager.swift
//  SpyFall
//
//  Created by Daniel Meechan on 03/08/2017.
//  Copyright © 2017 Rogue Studios. All rights reserved.
//

import UIKit
import FirebaseDatabase


class DataManager {
  
  static let shared = DataManager()
  
  var ref: DatabaseReference?
  var databaseHandle: DatabaseHandle?
  var lobbyViewRef: LobbyViewController?
  
  var match: Match
  var user: Player
  
  init() {
    // Set up link to Firebase database
    print("Creating link to Firebase database")
    ref = Database.database().reference()
    
    match = Match()
    user = Player(name: "")
    
  }
  
  func read() {
    read(gameID: match.ID)
    
  }
  
  func read(gameID: String) {
    databaseHandle = ref?.child("matches").child(gameID).observe(.value, with: { (snapshot) in
      // Code to execute when the match with this access code changes
      print("Received update from database")
      
      let output = snapshot.value as? [String: AnyObject]
      
      if let realOutput = output {
        self.match.fromDictionary(dict: realOutput)
        
      } else {
        print("Snapshot output was empty: ", output ?? "empty :(")
        print("Snapshot: ", snapshot)
      }
      
      self.lobbyViewRef?.updateUI()
      
    })
  }
  
  func write() {
    
    ref?.child("matches").child(match.ID).setValue(match.toDictionary())
    
  }
  
  func writeUser() {
    // Scan through players array to find the index of the current user
    var found: Bool = false
    print("Scanning through players array to add player")
    
    var i = 0
    
    while i < match.players.count && found == false {
      if match.players[i].name == user.name {
        found = true
      }
      i += 1
      
    }
    
    // Now overwrite that player index with the updated user data
    
    ref?.child("matches").child(match.ID).child("players").child(String(i)).setValue(user.toDictionary())
    
    match.players.append(user)
    
  }
  
  func removeMatch() {
    ref?.child("matches").child(match.ID).removeValue()
  }
  
  
  
  
}
