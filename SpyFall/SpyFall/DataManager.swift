//
//  DataManager.swift
//  SpyFall
//
//  Created by Daniel Meechan on 03/08/2017.
//  Copyright © 2017 Rogue Studios. All rights reserved.
//

import Foundation
import FirebaseDatabase


class DataManager {
  
  static let shared = DataManager()
  
  var ref: DatabaseReference?
  var databaseHandle: DatabaseHandle?
  
  init() {
    ref = Database.database().reference()
  }
  
  func write(match: Match) {
    
    ref?.child("matches").child(match.accessCode).setValue(match.toDictionary())

    // ref?.child("matches").childByAutoId().setValue("hello world")
    
    //ref?.child("matches").observeSingleEvent(of: .value, with: { (snapshot) in
    //let value = snapshot.value as?
    //})
    
  }
  
  func doesMatchExist() -> Bool {
    ref?.child("matches").observeSingleEvent(of: .value, with: { (snapshot) in
      // Code to check if match exists or not 
      
      
      
    })
    
    return false
  }
  
  func read(accessCode: String) -> Match {
    let match = Match(host: Player(name: ""))
    
    databaseHandle = ref?.child("matches").child(accessCode).observe(.value, with: { (snapshot) in
      // Code to execute when anything in accessCode changes
      
      let output = snapshot.value as? [String: AnyObject]
      
      // Check there's valid data in there
      if let validOutput = output {
        match.fromDictionary(dict: validOutput)
        
      } else {
        print("ERROR CANNOT DOWNLOAD GAME DATA")
        
      }
      
    })
    
    return match
    
  }
  
}
