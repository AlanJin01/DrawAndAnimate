//
//  Manager.swift
//  DrawAndAnimate
//
//  Created by J K on 2019/2/21.
//  Copyright © 2019 KimsStudio. All rights reserved.
//

import UIKit

class Manager {
    var userLines = [UserDrawLine]()
    var undoRedo = [UserDrawLine]()
    
    var lineColor = UIColor.black
    var lineColors = [UIColor]()
    
    init() {}
    
    static var theManager = Manager()
}

let manager = Manager.theManager
