//
//  SubnetCalculatorViewController.swift
//  CTIS Network Tool
//
//  Created by Onur Özdemir on 30.06.2016.
//  Copyright © 2016 TEAM2. All rights reserved.
//

import UIKit

class SubnetCalculatorViewController: UIViewController {
  
  @IBOutlet weak var txtIP: UITextField!
  @IBOutlet weak var txtSubnetMask: UITextField!
  
  @IBOutlet weak var viewResult: UIView!
  @IBOutlet weak var lblNetwork: UILabel!
  @IBOutlet weak var lblSubnetMask: UILabel!
  @IBOutlet weak var lblFirstHost: UILabel!
  @IBOutlet weak var lblLastHost: UILabel!
  @IBOutlet weak var lblBroadcast: UILabel!
  @IBOutlet weak var lblAvailableHosts: UILabel!
  
  @IBOutlet weak var lblNetworkBits: UILabel!
  @IBOutlet weak var lblSubnetMaskBits: UILabel!
  @IBOutlet weak var lblFirstHostBits: UILabel!
  @IBOutlet weak var lblLastHostBits: UILabel!
  @IBOutlet weak var lblBroadcastBits: UILabel!
  
  var mSubnetCalculatorFunctions = SubnetCalculatorFunctions()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func pressCalculate(sender: UIButton) {
    self.view.endEditing(true)
    
    if txtIP.text == "" || txtSubnetMask.text == "" {
      let tapAlert = UIAlertController(title: "Error", message: "IP Address or Subnet Mask Address is empty!", preferredStyle: UIAlertControllerStyle.Alert)
      tapAlert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Destructive, handler: nil))
      
      self.presentViewController(tapAlert, animated: true, completion: nil)
      
      self.viewResult.hidden = true
    } else {
      let ip = txtIP.text
      lblNetwork.text = mSubnetCalculatorFunctions.getNetworkAddress(ip!)
      lblSubnetMask.text = txtSubnetMask.text
      lblFirstHost.text = mSubnetCalculatorFunctions.getFirstHostAddress(ip!)
      lblLastHost.text = mSubnetCalculatorFunctions.getLastHostAddress(ip!)
      lblBroadcast.text = mSubnetCalculatorFunctions.getBroadcastAddress(ip!)
      
      let networkBits = lblNetwork.text
      lblNetworkBits.text = mSubnetCalculatorFunctions.getBits(networkBits!)
      let maskBits = txtSubnetMask.text
      lblSubnetMaskBits.text = mSubnetCalculatorFunctions.getBits(maskBits!)
      let firstHost = lblFirstHost.text
      lblFirstHostBits.text = mSubnetCalculatorFunctions.getBits(firstHost!)
      let lastHost = lblLastHost.text
      lblLastHostBits.text = mSubnetCalculatorFunctions.getBits(lastHost!)
      let broadcast = lblBroadcast.text
      lblBroadcastBits.text = mSubnetCalculatorFunctions.getBits(broadcast!)
      
      self.viewResult.hidden = false
    }
  }
  
  @IBAction func pressClear(sender: UIButton) {
    self.view.endEditing(true)
    self.viewResult.hidden = true
    txtIP.text = ""
    txtSubnetMask.text = ""
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    self.view.endEditing(true)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
}
