//
//  OSILayersViewController.swift
//  CTIS Network Tool
//
//  Created by Onur Özdemir on 23.06.2016.
//  Copyright © 2016 TEAM2. All rights reserved.
//

import UIKit
import SWXMLHash

class OSILayersViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
  
  @IBOutlet weak var mLayersCollectionView: UICollectionView!
  @IBOutlet weak var mDataCollectionView: UICollectionView!
  @IBOutlet weak var lblMessage: UILabel!
  
  var editingMode = false
  
  var OSILayers : [String] = ["Application", "Presentation", "Session", "Transport", "Network", "Data Link", "Physical"]
  var OSIData = ["Data", "Data", "Data", "Segments", "Packets", "Frames", "Bits"]
  
  var layerLongPressGestureRecognizer: UILongPressGestureRecognizer?
  var dataLongPressGestureRecognizer: UILongPressGestureRecognizer?
  
  var currentDragAndDropIndexPath: NSIndexPath?
  var currentDragAndDropSnapshot: UIView?
  
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 7
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    if collectionView == mLayersCollectionView {
      let layerCell = collectionView.dequeueReusableCellWithReuseIdentifier("LayersCell", forIndexPath: indexPath) as! LayerCollectionViewCell
      layerCell.lblLayer.text = OSILayers[indexPath.row]
      return layerCell
    } else {
      let dataCell = collectionView.dequeueReusableCellWithReuseIdentifier("DataCell", forIndexPath: indexPath) as! DataCollectionViewCell
      dataCell.lblData.text = OSIData[indexPath.row]
      return dataCell
    }
  }
  
  override func setEditing(editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    
    self.mLayersCollectionView!.allowsSelection = editing
    self.mDataCollectionView!.allowsSelection = editing
    let LayerIndexPaths: [NSIndexPath] = self.mLayersCollectionView!.indexPathsForVisibleItems()
    let DataIndexPaths: [NSIndexPath] = self.mDataCollectionView!.indexPathsForVisibleItems()
    
    for indexPath in LayerIndexPaths {
      self.mLayersCollectionView!.deselectItemAtIndexPath(indexPath, animated: false)
      let cell: LayerCollectionViewCell? = self.mLayersCollectionView!.cellForItemAtIndexPath(indexPath) as? LayerCollectionViewCell
      cell?.editing = editing
    }
    
    for indexPath in DataIndexPaths {
      self.mDataCollectionView!.deselectItemAtIndexPath(indexPath, animated: false)
      let dataCell: DataCollectionViewCell? = self.mDataCollectionView!.cellForItemAtIndexPath(indexPath) as? DataCollectionViewCell
      dataCell?.editing = editing
    }
    
    if editing {
      self.editButtonItem().title = "Check"
      lblMessage.text = "Press long. Drag and drop"
      self.layerLongPressGestureRecognizer!.enabled = true
      self.dataLongPressGestureRecognizer!.enabled = true
      mLayersCollectionView.backgroundColor = UIColor.clearColor()
      mDataCollectionView.backgroundColor = UIColor.clearColor()
    } else {
      self.editButtonItem().title = "Answer"
      lblMessage.text = "* First, click \"Answer\" button to sort layers"
      self.layerLongPressGestureRecognizer!.enabled = false
      self.dataLongPressGestureRecognizer!.enabled = false
      
      if OSILayers[0] != "Application" || OSILayers[1] != "Presentation" || OSILayers[2] != "Session" || OSILayers[3] != "Transport" || OSILayers[4] != "Network" || OSILayers[5] != "Data Link" || OSILayers[6] != "Physical" {
        mLayersCollectionView.backgroundColor = UIColor.redColor()
      } else {
        mLayersCollectionView.backgroundColor = UIColor.greenColor()
      }
      
      if OSIData[0] != "Data" || OSIData[1] != "Data" || OSIData[2] != "Data" || OSIData[3] != "Segments" || OSIData[4] != "Packets" || OSIData[5] != "Frames" || OSIData[6] != "Bits" {
        mDataCollectionView.backgroundColor = UIColor.redColor()
      } else {
        mDataCollectionView.backgroundColor = UIColor.greenColor()
      }
      
      editingMode = false
    }
    
  }
  
  func LayerLongPressGestureRecognizerAction(sender: UILongPressGestureRecognizer) {
    let currentLocation = sender.locationInView(self.mLayersCollectionView)
    let indexPathForLocation: NSIndexPath? = self.mLayersCollectionView!.indexPathForItemAtPoint(currentLocation)
    
    switch sender.state {
    case .Began:
      if indexPathForLocation != nil {
        self.currentDragAndDropIndexPath = indexPathForLocation
        let cell: LayerCollectionViewCell? = self.mLayersCollectionView!.cellForItemAtIndexPath(indexPathForLocation!) as? LayerCollectionViewCell
        self.currentDragAndDropSnapshot = cell!.snapshot
        self.updateDragAndDropSnapshotView(0.0, center: cell!.center, transform: CGAffineTransformIdentity)
        self.mLayersCollectionView.addSubview(self.currentDragAndDropSnapshot!)
        UIView.animateWithDuration(0.25, animations: { () -> Void in
          self.updateDragAndDropSnapshotView(0.95, center: cell!.center, transform: CGAffineTransformMakeScale(1.05, 1.05))
          cell!.isMoving = true
        })
      }
      break
    case .Changed:
      self.currentDragAndDropSnapshot!.center = currentLocation
      if indexPathForLocation != nil {
        let layer = self.OSILayers[self.currentDragAndDropIndexPath!.row]
        self.OSILayers.removeAtIndex(self.currentDragAndDropIndexPath!.row)
        self.OSILayers.insert(layer, atIndex: indexPathForLocation!.row)
        self.mLayersCollectionView.moveItemAtIndexPath(self.currentDragAndDropIndexPath!, toIndexPath: indexPathForLocation!)
        self.currentDragAndDropIndexPath = indexPathForLocation
      }
      break
    default:
      let cell: LayerCollectionViewCell? = self.mLayersCollectionView!.cellForItemAtIndexPath(indexPathForLocation!) as? LayerCollectionViewCell
      UIView.animateWithDuration(0.25, animations: { () -> Void in
        self.updateDragAndDropSnapshotView(0.0, center: cell!.center, transform: CGAffineTransformIdentity)
        cell!.isMoving = false
        }, completion: {(finished: Bool) -> Void in
          self.currentDragAndDropSnapshot?.removeFromSuperview()
          self.currentDragAndDropSnapshot = nil
      })
    }
    
  }
  
  func DataLongPressGestureRecognizerAction(sender: UILongPressGestureRecognizer) {
    let currentLocation = sender.locationInView(self.mDataCollectionView)
    let indexPathForLocation: NSIndexPath? = self.mDataCollectionView!.indexPathForItemAtPoint(currentLocation)
    
    switch sender.state {
      
    case .Began:
      if indexPathForLocation != nil {
        self.currentDragAndDropIndexPath = indexPathForLocation
        let cell: DataCollectionViewCell? = self.mDataCollectionView!.cellForItemAtIndexPath(indexPathForLocation!) as? DataCollectionViewCell
        self.currentDragAndDropSnapshot = cell!.snapshot
        self.updateDragAndDropSnapshotView(0.0, center: cell!.center, transform: CGAffineTransformIdentity)
        self.mDataCollectionView.addSubview(self.currentDragAndDropSnapshot!)
        UIView.animateWithDuration(0.25, animations: { () -> Void in
          self.updateDragAndDropSnapshotView(0.95, center: cell!.center, transform: CGAffineTransformMakeScale(1.05, 1.05))
          cell!.isMoving = true
        })
      }
      break
      
    case .Changed:
      self.currentDragAndDropSnapshot!.center = currentLocation
      if indexPathForLocation != nil {
        let layer = self.OSIData[self.currentDragAndDropIndexPath!.row]
        self.OSIData.removeAtIndex(self.currentDragAndDropIndexPath!.row)
        self.OSIData.insert(layer, atIndex: indexPathForLocation!.row)
        self.mDataCollectionView.moveItemAtIndexPath(self.currentDragAndDropIndexPath!, toIndexPath: indexPathForLocation!)
        self.currentDragAndDropIndexPath = indexPathForLocation
      }
      break
      
    default:
      let cell: DataCollectionViewCell? = self.mDataCollectionView!.cellForItemAtIndexPath(indexPathForLocation!) as? DataCollectionViewCell
      UIView.animateWithDuration(0.25, animations: { () -> Void in
        self.updateDragAndDropSnapshotView(0.0, center: cell!.center, transform: CGAffineTransformIdentity)
        cell!.isMoving = false
        }, completion: {(finished: Bool) -> Void in
          self.currentDragAndDropSnapshot?.removeFromSuperview()
          self.currentDragAndDropSnapshot = nil
      })
      
    }
    
  }
  
  func updateDragAndDropSnapshotView(alpha: CGFloat, center: CGPoint, transform: CGAffineTransform) {
    if self.currentDragAndDropSnapshot != nil {
      self.currentDragAndDropSnapshot!.alpha = alpha
      self.currentDragAndDropSnapshot!.center = center
      self.currentDragAndDropSnapshot!.transform = transform
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    var tmpOSILayers : [String] = ["","","","","","",""]
    var tmpOSIData : [String] = ["","","","","","",""]
    
    let randomNumbers = uniqueRandoms(7, minNum: 0, maxNum: 6)
    
    for i in 0..<randomNumbers.count {
      tmpOSILayers[i] = OSILayers[randomNumbers[i]]
      tmpOSIData[i] = OSIData[randomNumbers[i]]
    }
    
    OSILayers = tmpOSILayers
    OSIData = tmpOSIData
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem()
    self.editButtonItem().title = "Answer"
    
    self.layerLongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(OSILayersViewController.LayerLongPressGestureRecognizerAction(_:)))
    self.layerLongPressGestureRecognizer!.enabled = false
    self.mLayersCollectionView!.addGestureRecognizer(self.layerLongPressGestureRecognizer!)
    
    self.dataLongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(OSILayersViewController.DataLongPressGestureRecognizerAction(_:)))
    self.dataLongPressGestureRecognizer!.enabled = false
    self.mDataCollectionView!.addGestureRecognizer(self.dataLongPressGestureRecognizer!)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func uniqueRandoms(numberOfRandoms: Int, minNum: Int, maxNum: UInt32) -> [Int] {
    var uniqueNumbers = Set<Int>()
    while uniqueNumbers.count < numberOfRandoms {
      uniqueNumbers.insert(Int(arc4random_uniform(maxNum + 1)) + minNum)
    }
    return Array(uniqueNumbers).shuffle
  }
  
}

extension Array {
  var shuffle:[Element] {
    var elements = self
    for index in 0..<elements.count {
      let anotherIndex = Int(arc4random_uniform(UInt32(elements.count-index)))+index
      if anotherIndex != index {
        swap(&elements[index], &elements[anotherIndex])
      }
    }
    return elements
  }
}
