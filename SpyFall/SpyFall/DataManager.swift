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
    let matchDict = match.toDictionary()
    ref?.child("matches").child(match.ID).setValue(matchDict)
    
  }
  
  func checkForDuplicateUser() {
    for player in match.players {
      if player.name == user.name {
        user.name += "2"
      }
    }
    
    match.players.append(user)
  }
  
  func writeUser() {
    let index = getUserIndex()
    // Now overwrite that player index with the updated user data
    
    ref?.child("matches").child(match.ID).child("players").child(String(index)).setValue(user.toDictionary())
    
  }
  
  func getUser() {
    let index = getUserIndex()
    user = match.players[index]
    
  }
  
  func removeUser() {
    let index = getUserIndex()
    match.players.remove(at: index)
    write()
    
  }
  
  func removeMatch() {
    ref?.child("matches").child(match.ID).removeValue()
  }
  
  func getUserIndex() -> Int {
    // Scan through players array to find the index of user
    var found: Bool = false
    var i = 0
    
    while ((i < match.players.count) && (found == false)) {
      // While loop seems to be dodgy for unknown reasons so need this to prevent array out of bounds error
      if i < match.players.count {
        if match.players[i].name == user.name {
          found = true
          
        } else {
          i += 1
          
        }
        
        
      }
    }
    
    if i == match.players.count {
      print("WARNING: getUserIndex() ATTEMPTED TO RETURN INDEX: \(i) FOR ARRAY SIZE: \(match.players.count)")
      i -= 1
      print("IT HAS BEEN REDUCED TO: \(i)")
      
    }
    
    return i
  }
  

  
  
  
  
}
