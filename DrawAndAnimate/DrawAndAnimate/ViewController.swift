//
//  ViewController.swift
//  DrawAndAnimate
//
//  Created by J K on 2019/2/21.
//  Copyright © 2019 KimsStudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CAAnimationDelegate {
    private var n = 0  //用来遍历lines
    private var lines: [UserDrawLine]!  //用来临时存储线条
    private var isStartAnimate: Bool = false  //用来检测动画的结束
    
    @IBOutlet weak var drawingView: DrawingView!  //画布
    @IBOutlet weak var colorButton: UIButton!  //颜色选择按钮
    
    //MARK: -
    //开始动画按钮
    @IBAction func playButton(_ sender: UIButton) {
        if !manager.userLines.isEmpty && !isStartAnimate {  //如果有画出的线条的话
            isStartAnimate = true
            lines = manager.userLines     //把线条临时存放到lines数组里
            manager.userLines.removeAll()   //清除，目的是把原先在画布上存在的线条清除,以便显示动画
            drawingView.setNeedsDisplay()   //刷新画布
            
            //执行动画
            animation(n)
        }
    }
    
    //配置动画方法
    private func animation(_ n: Int) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = lines[n].lineColor.cgColor
        shapeLayer.lineWidth = 4
        shapeLayer.lineCap = .round
        shapeLayer.lineJoin = .round
        shapeLayer.path = lines[n].bezier.cgPath
        shapeLayer.strokeEnd = 0.0
        drawingView.layer.addSublayer(shapeLayer)
        
        let animation = CAKeyframeAnimation(keyPath: "strokeEnd")
        animation.duration = 0.5
        animation.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)]
        animation.calculationMode = .cubicPaced
        animation.delegate = self
        animation.values = [NSNumber(value: 0.0), NSNumber(value: 1.0)]
        shapeLayer.add(animation, forKey: "anima")
    }
    
    //CAAnimationDelegate代理方法，检测动画结束
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag == true {     //动画结束时
            manager.userLines.append(lines[n])  //添加数据
            drawingView.setNeedsDisplay()  //刷新画布
        }
        
        n += 1
        
        if n < lines.count {  //能遍历lines数组时
            animation(n)   //执行动画
        }else {   //如果该画的都画完时，
            lines.removeAll()    //清除临时数组lines数据
            drawingView.setNeedsDisplay()   //刷新画布
            n = 0   //用于遍历的index重置
            isStartAnimate = false
        }
    }

    //MARK: -
    //重做, 利用了栈的后进先出原理(LIFO)
    @IBAction func redoButton(_ sender: UIButton) {
        if !manager.undoRedo.isEmpty && !isStartAnimate {
            manager.userLines.append(manager.undoRedo.last!)
            manager.undoRedo.removeLast()
            
            drawingView.setNeedsDisplay()
        }
    }
    //撤销, 利用了栈的后进先出原理(LIFO)
    @IBAction func undoButton(_ sender: UIButton) {
        if !manager.userLines.isEmpty && !isStartAnimate {
            manager.undoRedo.append(manager.userLines.last!)
            manager.userLines.removeLast()
            
            drawingView.setNeedsDisplay()
        }
    }
    //清除所有线条, 初始化相关数组
    @IBAction func clearButton(_ sender: UIButton) {
        if !isStartAnimate {
            manager.userLines = [UserDrawLine]()
            manager.undoRedo = [UserDrawLine]()
            manager.lineColors = [UIColor]()
            
            drawingView.setNeedsDisplay()
        }
    }
    
    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        colorButton.backgroundColor = manager.lineColor  //更换选取颜色按钮的背景颜色
        drawingView.setNeedsDisplay() //刷新画布
    }
}

