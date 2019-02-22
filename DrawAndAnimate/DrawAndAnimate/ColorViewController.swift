//
//  ColorViewController.swift
//  DrawAndAnimate
//
//  Created by J K on 2019/2/21.
//  Copyright © 2019 KimsStudio. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController {

    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var slideView: UIView!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var alphaSlider: UISlider!
    
    //通过滑条，设置红绿蓝以及alpha数值
    @IBAction func redSlider(_ sender: UISlider) {
        switch sender.tag {
            case 0:  //红
                red = CGFloat(sender.value)
            case 1:  //绿
                green = CGFloat(sender.value)
            case 2:  //蓝
                blue = CGFloat(sender.value)
            case 3:  //alpha
                alpha = CGFloat(sender.value)
            default:
                break
        }
        colorView.backgroundColor = colorValue
    }
    
    @IBOutlet weak var redValue: UILabel!
    @IBOutlet weak var greenValue: UILabel!
    @IBOutlet weak var blueValue: UILabel!
    @IBOutlet weak var alphaValue: UILabel!
    
    var red: CGFloat = 0.0 {
        willSet {
            redSlider.setValue(Float(newValue), animated: true)
            redValue.text = "\(Int(newValue * 100))"
        }
    }
    var green: CGFloat = 0.0 {
        willSet {
            greenSlider.setValue(Float(newValue), animated: true)
            greenValue.text = "\(Int(newValue * 100))"
        }
    }
    var blue: CGFloat = 0.0 {
        willSet {
            blueSlider.setValue(Float(newValue), animated: true)
            blueValue.text = "\(Int(newValue * 100))"
        }
    }
    var alpha: CGFloat = 0.0 {
        willSet {
            alphaSlider.setValue(Float(newValue), animated: true)
            alphaValue.text = "\(Int(newValue * 100))"
        }
    }
    
    var colorValue: UIColor {
        get {
            return UIColor(red: red, green: green, blue: blue, alpha: alpha)
        }
        set {
            newValue.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let slideViewFrame = slideView.frame.size
        
        redSlider.frame = CGRect(x: 0, y: 0, width: slideViewFrame.width, height: slideViewFrame.height)
        greenSlider.frame = CGRect(x: 0, y: 0, width: slideViewFrame.width, height: slideViewFrame.height)
        blueSlider.frame = CGRect(x: 0, y: 0, width: slideViewFrame.width, height: slideViewFrame.height)
        alphaSlider.frame = CGRect(x: 0, y: 0, width: slideViewFrame.width, height: slideViewFrame.height)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.barStyle = .default
        
        colorValue = manager.lineColor
        colorView.backgroundColor = manager.lineColor
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        manager.lineColor = colorValue
    }

}
