//
//  SlideMenuTableViewController.swift
//  CTIS Network Tool
//
//  Created by Onur Özdemir on 29.06.2016.
//  Copyright © 2016 TEAM2. All rights reserved.
//

import UIKit
import SideMenu

class C261SlideMenuTableViewController: UITableViewController {
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    // this will be non-nil if a blur effect is applied
    guard tableView.backgroundView == nil else {
      return
    }
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
  
}
