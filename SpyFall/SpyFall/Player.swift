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
  var isHost: Bool
  var isSpy: Bool
  var isReady: Bool
  var role: String
  var vote: String
  
  init(name: String) {
    self.name = name
    self.isHost = false
    self.isSpy = false
    self.isReady = false
    self.role = ""
    self.vote = ""
    
  }
  
  func toDictionary() -> [String: AnyObject] {
    let dict: [String: AnyObject] = [
      "name" : self.name as AnyObject,
      "isHost" : self.isHost as AnyObject,
      "isSpy" : self.isSpy as AnyObject,
      "isReady" : self.isReady as AnyObject,
      "role" : self.role as AnyObject,
      "vote" : self.vote as AnyObject
    ]
    
    return dict
    
  }
  
  func fromDictionary(dict: [String: AnyObject]) {
    self.name = dict["name"] as! String
    self.isHost = dict["isHost"] as! Bool
    self.isSpy = dict["isSpy"] as! Bool
    self.isReady = dict["isReady"] as! Bool
    self.role = dict["role"] as! String
    self.vote = dict["vote"] as! String
    
  }
  
}
