//
//  LayerCollectionViewCell.swift
//  CTIS Network Tool
//
//  Created by Onur Özdemir on 23.06.2016.
//  Copyright © 2016 TEAM2. All rights reserved.
//

import UIKit

class LayerCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var lblLayer: UILabel!
  
  var editing: Bool = false {
    didSet {
    }
  }
  
  override var selected: Bool {
    didSet {
      if editing {
        
      }
    }
  }
  
  var isMoving: Bool = false {
    didSet {
      self.lblLayer!.alpha = isMoving ? 0.0 : 1.0
    }
  }
  
  var snapshot: UIView {
    let snapshot: UIView = self.snapshotViewAfterScreenUpdates(true)
    let layer: CALayer = snapshot.layer
    layer.masksToBounds = false
    layer.shadowRadius = 4.0
    layer.shadowOpacity = 0.5
    layer.shadowOffset = CGSize(width: -4.0, height: 0.0)
    return snapshot
  }
  
}
