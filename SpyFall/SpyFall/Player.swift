//
//  Player.swift
//  SpyFall
//
//  Created by Daniel Meechan on 31/07/2017.
//  Copyright © 2017 Rogue Studios. All rights reserved.
//

import Foundation

class Player {
  var name: String
  var host: Bool
  var spy: Bool
  var ready: Bool
  var role: String
  var vote: String
  
  init(name: String) {
    self.name = name
    self.host = false
    self.spy = false
    self.ready = false
    self.role = ""
    self.vote = ""
    
  }
  
  func toDictionary() -> [String: AnyObject] {
    let dict: [String: AnyObject] = [
      "name" : self.name as AnyObject,
      "host" : self.host as AnyObject,
      "spy" : self.spy as AnyObject,
      "ready" : self.ready as AnyObject,
      "role" : self.role as AnyObject,
      "vote" : self.vote as AnyObject
    ]
    
    return dict
    
  }
  
  func fromData(data: [String: AnyObject]) {
    // Use dictionary to update player's values
    self.name = data["name"] as! String
    self.host = data["host"] as! Bool
    self.spy = data["spy"] as! Bool
    self.ready = data["ready"] as! Bool
    self.role = data["role"] as! String
    self.vote = data["vote"] as! String
    
  }
  
}
