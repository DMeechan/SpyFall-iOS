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
  
  init() {
    // Set up link to Firebase database
    print("Creating link to Firebase database")
    ref = Database.database().reference()
    
    match = Match()
    
  }
  
  func read() {
    read(gameID: match.ID)
    
  }
  
  func read(gameID: String) {
    databaseHandle = ref?.child("matches").child(gameID).observe(.value, with: { (snapshot) in
      // Code to execute when the match with this access code changes
      
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
    
    // ref?.child("matches").childByAutoId().setValue("hello world")
    
    //ref?.child("matches").observeSingleEvent(of: .value, with: { (snapshot) in
    //let value = snapshot.value as?
    //})
    
  }
  
  func removeMatch() {
    ref?.child("matches").child(match.ID).removeValue()
  }
  
  
  
  
}
