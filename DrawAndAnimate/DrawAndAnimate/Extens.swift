//
//  Extens.swift
//  DrawAndAnimate
//
//  Created by J K on 2019/2/21.
//  Copyright © 2019 KimsStudio. All rights reserved.
//

import UIKit

var a: CGFloat = 0.0

extension UISlider {
    @IBInspectable
    var rotate: CGFloat {
        get {
            let tran = self.transform
            self.transform = tran.rotated(by: 3.14 / a)
            return a
        }
        set {
            a = newValue
            let tran = self.transform
          self.transform = tran.rotated(by: 3.14 / a)
        }
    }
}
