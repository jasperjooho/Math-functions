//
//  GraphView.swift
//  Math functions
//
//  Created by user on 3/12/17.
//  Copyright © 2017 Obsearch Applications. All rights reserved.
//

import UIKit

class GraphView: UIView {

    var height = 586.0
    var width = 320.0
    var maxX = 5
    var minX = -5
    var maxY = 5
    var minY = -5
    var gradient = 1.0
    var yIntercept = 0.0
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        height -= 30
        width -= 30
        
        var posMinX = -minX
        var posMinY = (maxY - minY) - maxY
        
        // Draw xAxis
        let xAxis = UIBezierPath()
        xAxis.move(to: CGPoint(x: 15, y: Double(maxY) * (height / Double(maxY - minY)) + 15))
        xAxis.addLine(to: CGPoint(x: width + 15, y: Double(maxY) * (height / Double(maxY - minY)) + 15))
        xAxis.close()
        UIColor.white.set()
        xAxis.stroke()
        
        // Draw yAxis
        let yAxis = UIBezierPath()
        yAxis.move(to: CGPoint(x: Double(posMinX) * (width / Double(maxX - minX)) + 15, y: height + 15))
        yAxis.addLine(to: CGPoint(x: Double(posMinX) * (width / Double(maxX - minX)) + 15, y: 15))
        yAxis.close()
        UIColor.white.set()
        yAxis.stroke()
        
        // Draw xlines
        if maxX - minX < 61 {
            for x in 0...(maxX - minX) {
                let xLine = UIBezierPath()
                xLine.move(to: CGPoint(x: Double(Double(x) * (width / Double(maxX - minX))) + 15, y: Double(maxY) * (height / Double(maxY - minY)) - 7.0 + 15))
                xLine.addLine(to: CGPoint(x: Double(Double(x) * (width / Double(maxX - minX))) + 15, y: Double(maxY) * (height / Double(maxY - minY)) + 7.0 + 15))
                xLine.close()
                UIColor.white.set()
                xLine.stroke()
            }
        }
        
        // Draw ylines
        if maxY - minY < 61 {
            for y in 0...(maxY - minY) {
                let yLine = UIBezierPath()
                yLine.move(to: CGPoint(x: Double(posMinX) * Double(width / Double(maxX - minX)) - 7.0 + 15, y: Double(y) * Double(height / Double(maxY - minY)) + 15))
                yLine.addLine(to: CGPoint(x: Double(posMinX) * Double(width / Double(maxX - minX)) + 7.0 + 15, y: Double(y) * Double(height / Double(maxY - minY)) + 15))
                yLine.close()
                UIColor.white.set()
                yLine.stroke()
            }
        }
        // Draw line
        // y = mx + c
        var y1 = Double(gradient * Double(minX) + yIntercept)
        y1 = Double(maxY) - y1
        var y2 = Double(gradient * Double(maxX) + yIntercept)
        y2 = Double(maxY) - y2
        var x1 = Double(5 + minX)
        var x2 = Double(5 + maxX)
        let line = UIBezierPath()
        line.move(to: CGPoint(x: 15.0, y: y1 * Double(height / Double(maxY - minY)) + 15))
        line.addLine(to: CGPoint(x: width + 15, y: y2 * Double(height / Double(maxY - minY)) + 15))
        line.close()
        UIColor.white.set()
        line.stroke()
        
    }

}
