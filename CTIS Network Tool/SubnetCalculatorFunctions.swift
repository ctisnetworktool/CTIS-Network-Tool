//
//  SubnetCalculatorFunctions.swift
//  CTIS Network Tool
//
//  Created by Onur Özdemir on 30.06.2016.
//  Copyright © 2016 TEAM2. All rights reserved.
//

import Foundation

class SubnetCalculatorFunctions {
  
  
  var IPAddress : String = ""
  
  
  func getNetworkAddress(ip: String) -> String {
    var splittedIP = splitIP(ip)
    var mIP = ""
    
    splittedIP[3] = "0"
    
    for i in 0 ..< splittedIP.count {
      mIP += splittedIP[i] + "."
    }
    mIP = mIP.substringToIndex(mIP.endIndex.predecessor())
    return mIP
  }
  
  func getFirstHostAddress(ip: String) -> String {
    var splittedIP = splitIP(ip)
    var mIP = ""
    
    splittedIP[3] = "1"
    
    for i in 0 ..< splittedIP.count {
      mIP += splittedIP[i] + "."
    }
    mIP = mIP.substringToIndex(mIP.endIndex.predecessor())
    return mIP
  }
  
  func getLastHostAddress(ip: String) -> String {
    var splittedIP = splitIP(ip)
    var mIP = ""
    
    splittedIP[3] = "254"
    
    for i in 0 ..< splittedIP.count {
      mIP += splittedIP[i] + "."
    }
    mIP = mIP.substringToIndex(mIP.endIndex.predecessor())
    return mIP
  }
  
  func getBroadcastAddress(ip: String) -> String {
    var splittedIP = splitIP(ip)
    var mIP = ""
    
    splittedIP[3] = "255"
    
    for i in 0 ..< splittedIP.count {
      mIP += splittedIP[i] + "."
    }
    mIP = mIP.substringToIndex(mIP.endIndex.predecessor())
    return mIP
  }
  
  func getBits(ip: String) -> String {
    var splittedIP = splitIP(ip)
    var mIP = ""
    
    for i in 0 ..< splittedIP.count {
      let bin : Int = Int(splittedIP[i])!
      let str = String(bin, radix: 2)
      mIP += pad(str, toSize: 8)
    }
    return mIP
  }
  
  func pad(string : String, toSize: Int) -> String {
    var padded = string
    for _ in 0 ..< toSize - string.characters.count {
      padded = "0" + padded
    }
    return padded
  }
  
  
  func splitIP(ip: String) -> Array<String> {
    return ip.componentsSeparatedByString(".")
  }
  
}
