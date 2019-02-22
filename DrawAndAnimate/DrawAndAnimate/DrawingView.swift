//
//  DrawingView.swift
//  DrawAndAnimate
//
//  Created by J K on 2019/2/21.
//  Copyright © 2019 KimsStudio. All rights reserved.
//

import UIKit

class DrawingView: UIView {

    //绘图
    override func draw(_ rect: CGRect) {
        // Drawing code
        super.draw(rect)
        
        for (lineColor, userLine) in manager.userLines.enumerated() {
            manager.lineColors[lineColor].setStroke()
            userLine.bezier.lineWidth = 4
            userLine.bezier.lineCapStyle = .round
            userLine.bezier.lineJoinStyle = .round
            userLine.bezier.stroke()
        }
    }

    //画线条
    func addTheLine(touch: UITouch) {
        let location = touch.location(in: self)
        manager.userLines.last?.bezier.addLine(to: location)
        self.setNeedsDisplay()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            manager.userLines.append(UserDrawLine(bezier: UIBezierPath(), lineColor: manager.lineColor))
            manager.lineColors.append(manager.lineColor)
            
            manager.userLines.last?.bezier.move(to: location)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            addTheLine(touch: touch)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            addTheLine(touch: touch)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            addTheLine(touch: touch)
        }
    }
}
