//
//  RouteGraphView.swift
//  Nanook
//
//  Created by Kirill Kudymov on 2017-07-09.
//  Copyright © 2017 Kirill Kudymov. All rights reserved.
//

import UIKit

class RouteGraphView: UIView {

    
    // MARK: Properties
    
    var airLeg: AirLeg!
    let yPosition = 8.0
    let margin = 8.0
    private let travelPoints = [TravelPoint]()
    private lazy var airHops: [AirHop] = {
        self.airLeg.hops
    }()
    
    private enum TravelPointType {
        case start
        case layoverStart
        case layoverEnd
        case end
    }
    
    private struct TravelPoint {
        let type: TravelPointType
        let xPosition: Double
        let duration: Double?
    }
    
    
    // MARK: Draw the view
    
    override func draw(_ rect: CGRect) {
        
        let travelPoints = calculateStopsFor(airHops: airHops)
        let context = UIGraphicsGetCurrentContext()
        
        draw(travelPoints: travelPoints, context: context)
    }
    
    
    // MARK: Helper methods
    
    // Create array of point to draw for the AirLeg's graph
    private func calculateStopsFor(airHops: [AirHop]) -> [TravelPoint] {
        
        var travelPoints = [TravelPoint]()
        
        // Create departure point "start"
        let departurePoint = TravelPoint(type: .start, xPosition: margin, duration: nil)
        travelPoints.append(departurePoint)
        
        // Calculate ratio to convert duration time in minutes into position in points
        let graphLengthRatio = (Double(self.bounds.width) - margin) / airLeg.duration()
        var previousPointPositionX = 0.0

        for (index, hop) in airHops.enumerated() {
            
            var pointType = TravelPointType.layoverStart
            // All points by default are of type "layouverStart" except the last point is of type "end"
            if index == (airHops.count - 1) {
                pointType = .end
            }
            
            // If there is a layover add a point for layoverEnd
            if let layoverDuration = hop.layoverDuration {
                // Calculate position for the point
                let pointPositionX = layoverDuration * graphLengthRatio + previousPointPositionX
                previousPointPositionX = pointPositionX
                // Add the point to the array of travel points
                travelPoints.append(TravelPoint(type: .layoverEnd, xPosition: pointPositionX, duration: hop.layoverDuration))
            }
            
            // Calculate position for the point
            let pointPositionX = hop.duration * graphLengthRatio + previousPointPositionX
            previousPointPositionX = pointPositionX
            
            // Add the point to the array of travel points
            travelPoints.append(TravelPoint(type: pointType, xPosition: pointPositionX, duration: hop.duration))
        }

        return travelPoints
    }

    // Draws circle for a point
    private func draw(travelPoints: [TravelPoint], context: CGContext?) {

        // Move point to the beginning position
        var previousPositionX = margin
        
        // Set the size of the circle to draw
        context?.setLineWidth(1.0)
        let radius = 3.0
        
        // Dashed line for layover
        let dashArray:[CGFloat] = [2,2]
        
        for point in travelPoints {
            
        // Start and finish are green, all other points are bluew
            switch point.type {
                
            case .start:
                context?.setStrokeColor(UIColor.green.cgColor)
                context?.setFillColor(UIColor.green.cgColor)
                context?.setLineDash(phase: 0, lengths: [])
                context?.strokePath()
                previousPositionX = margin + radius
                let rectangle = CGRect(x: point.xPosition - radius, y: yPosition - radius, width: radius * 2, height: radius * 2)
                context?.fillEllipse(in: rectangle)
                
            case .layoverStart:
                context?.setStrokeColor(UIColor.blue.cgColor)
                context?.setFillColor(UIColor.blue.cgColor)
                context?.setLineDash(phase: 0, lengths: [])
                context?.addLines(between: [CGPoint(x: previousPositionX, y: yPosition), CGPoint(x: point.xPosition, y: yPosition)])
                context?.strokePath()
                let rectangle = CGRect(x: point.xPosition - radius, y: yPosition - radius, width: radius * 2, height: radius * 2)
                context?.fillEllipse(in: rectangle)
                drawDurationBetween(point1: previousPositionX, point2: point.xPosition, duration: point.duration!, context: context)
                previousPositionX = point.xPosition
                
            case .layoverEnd:
                context?.setStrokeColor(UIColor.blue.cgColor)
                context?.setFillColor(UIColor.blue.cgColor)
                context?.setLineDash(phase: 0, lengths: dashArray)
                context?.addLines(between: [CGPoint(x: previousPositionX, y: yPosition), CGPoint(x: point.xPosition, y: yPosition)])
                context?.strokePath()
                let rectangle = CGRect(x: point.xPosition - radius, y: yPosition - radius, width: radius * 2, height: radius * 2)
                context?.fillEllipse(in: rectangle)
                drawDurationBetween(point1: previousPositionX, point2: point.xPosition, duration: point.duration!, context: context)
                previousPositionX = point.xPosition
                
            case .end:
                context?.setStrokeColor(UIColor.blue.cgColor)
                context?.setFillColor(UIColor.green.cgColor)
                context?.setLineDash(phase: 0, lengths: [])
                context?.addLines(between: [CGPoint(x: previousPositionX, y: yPosition), CGPoint(x: point.xPosition, y: yPosition)])
                context?.strokePath()
                let rectangle = CGRect(x: point.xPosition - radius, y: yPosition - radius, width: radius * 2, height: radius * 2)
                context?.fillEllipse(in: rectangle)
                drawDurationBetween(point1: previousPositionX, point2: point.xPosition, duration: point.duration!, context: context)
                previousPositionX = point.xPosition
            }
        }
    }
    
    private func drawDurationBetween(point1: Double, point2: Double, duration: Double, context: CGContext?) {
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.hour, .minute]
        formatter.zeroFormattingBehavior = [.pad]
        let durationString: TimeInterval = duration * 60
        let formattedDuration = formatter.string(from: durationString)!
        
        let attributes = [:] as [String : Any]
        
        let formattedDurationStringSize = formattedDuration.size(attributes: attributes)
        let durationStringPositionX = point1 + (point2 - point1) / 2 - Double(formattedDurationStringSize.width) / 2
        
        formattedDuration.draw(at: CGPoint(x: durationStringPositionX, y: yPosition + margin), withAttributes: attributes)
    }
}
