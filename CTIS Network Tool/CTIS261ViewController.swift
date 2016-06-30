//
//  CTIS261ViewController.swift
//  CTIS Network Tool
//
//  Created by Onur Özdemir on 29.06.2016.
//  Copyright © 2016 TEAM2. All rights reserved.
//

import UIKit
import SideMenu

class CTIS261ViewController: UIViewController {
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupSideMenu()
    setDefaults()
  }
  
  private func setupSideMenu() {
    // Define the menus
    SideMenuManager.menuLeftNavigationController = storyboard!.instantiateViewControllerWithIdentifier("LeftMenuNavigationController") as? UISideMenuNavigationController
    
    // Enable gestures.
    // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
    SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
    SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
    
    // Set up background image
    SideMenuManager.menuAnimationBackgroundColor = UIColor(patternImage: UIImage(named: "menu-background")!)
  }
  
  private func setDefaults() {
    let modes:[SideMenuManager.MenuPresentMode] = [.MenuSlideIn, .ViewSlideOut, .ViewSlideInOut, .MenuDissolveIn]
    let styles:[UIBlurEffectStyle] = [.Dark, .Light, .ExtraLight]
    
    SideMenuManager.menuAllowPushOfSameClassTwice = false
    SideMenuManager.menuFadeStatusBar = false
    SideMenuManager.menuPresentMode = modes[2]
    SideMenuManager.menuBlurEffectStyle = styles[1]
    SideMenuManager.menuWidth = view.frame.width * 0.6
    SideMenuManager.menuAnimationTransformScaleFactor = 0.9
    SideMenuManager.menuShadowOpacity = 0.7
    SideMenuManager.menuAnimationFadeStrength = 0.3
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
}
