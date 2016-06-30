//
//  ViewController.swift
//  CTIS Network Tool
//
//  Created by Onur Özdemir on 23.06.2016.
//  Copyright © 2016 TEAM2. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
  
  @IBOutlet weak var btnCTIS261: UIButton!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    btnCTIS261.layer.cornerRadius = 10
    btnCTIS261.layer.borderWidth = 1
    btnCTIS261.layer.borderColor = UIColor.blackColor().CGColor
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func unwindToMain(segue: UIStoryboardSegue) {
  }
  
}
