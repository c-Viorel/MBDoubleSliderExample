//
//  MBFilledView.swift
//  iClock
//
//  Created by Viorel Porumbescu on 23/02/16.
//  Copyright © 2016 Viorel Porumbescu. All rights reserved.
//

import Cocoa

 @IBDesignable
class MBFilledView: NSView {
    
    
    @IBInspectable var backgroundColor:NSColor          = NSColor.black.withAlphaComponent(0.5)  { didSet { self.needsDisplay = true} }
    /**
    This kind of view will lwt you to round
     */
    @IBInspectable var cornerRadius: CGFloat            = 5.0   { didSet { self.needsDisplay = true} }
    @IBInspectable var radiusTopLeft:Bool               = true  { didSet { self.needsDisplay = true} }
    @IBInspectable var radiusTopRight:Bool              = true  { didSet { self.needsDisplay = true} }
    @IBInspectable var radiusBottomLeft: Bool           = true  { didSet { self.needsDisplay = true} }
    @IBInspectable var radiusBottomRight:Bool           = true  { didSet { self.needsDisplay = true} }
    
    @IBInspectable var hasShadow: Bool                  = false         { didSet { self.needsDisplay = true} }
    @IBInspectable var shadowColor:NSColor              = NSColor.black { didSet { self.needsDisplay = true} }
    @IBInspectable var xShadowPosition:Int              = 2             { didSet { self.needsDisplay = true} }
    @IBInspectable var yShadowPosition: Int             = 1             { didSet { self.needsDisplay = true} }
    
    
    @IBInspectable var hasVisualEffectView:Bool = false { didSet{ self.setupLayers()}}
    @IBInspectable var materialView:Int = 9
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupLayers()
    }
    

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.setupLayers()
    }
    
    func setupLayers() {

        if self.hasVisualEffectView {
            let view                  = NSVisualEffectView(frame: self.bounds)
            view.identifier           = "1112"
            view.blendingMode         = NSVisualEffectBlendingMode.behindWindow
            view.state                = NSVisualEffectState.active
            view.wantsLayer           = true
            view.layer?.masksToBounds = true
            view.layer?.cornerRadius  = cornerRadius
            if let met                = NSVisualEffectMaterial(rawValue: materialView) {
            view.material             = met
            } else {
            view.material             = .ultraDark
             }
            self.addSubview(view, positioned: .below, relativeTo: nil)
        } else {
            for view in self.subviews {
                if view.identifier == "1112" {
                    view.removeFromSuperview()
                }
            }
        }
    }
    
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        // Configure layers & colors //
        if hasVisualEffectView {
            setupLayers()
        }
        self.wantsLayer                 = true
        // Configure shadow //
        if hasShadow {
            self.layer?.shadowOffset    =  NSSize(width: xShadowPosition, height: yShadowPosition)
            self.layer?.shadowOpacity   = 0.85
            self.layer?.shadowColor     = shadowColor.cgColor
        }
        self.layer?.backgroundColor     = NSColor.clear.cgColor
        self.layer?.masksToBounds       = true
        if radiusTopLeft && radiusTopRight && radiusBottomLeft && radiusBottomRight {
            self.layer?.cornerRadius        = cornerRadius
            self.layer?.backgroundColor     = backgroundColor.cgColor
        } else {
        
        //Set background color and radius
            let rectangleRect       = self.frame
            let rectangleInnerRect  = NSInsetRect(rectangleRect, cornerRadius, cornerRadius)
            let rectanglePath       = NSBezierPath()
            radiusBottomLeft ?      rectanglePath.appendArc(withCenter: NSMakePoint(NSMinX(rectangleInnerRect), NSMinY(rectangleInnerRect)), radius: cornerRadius, startAngle: 180, endAngle: 270) : rectanglePath.move(to: NSMakePoint(NSMinX(rectangleRect), NSMinY(rectangleRect)))
            radiusBottomRight ?     rectanglePath.appendArc(withCenter: NSMakePoint(NSMaxX(rectangleInnerRect), NSMinY(rectangleInnerRect)), radius: cornerRadius, startAngle: 270, endAngle: 360) : rectanglePath.line(to: NSMakePoint(NSMaxX(rectangleRect), NSMinY(rectangleRect)))
            radiusTopRight ?        rectanglePath.appendArc(withCenter: NSMakePoint(NSMaxX(rectangleInnerRect), NSMaxY(rectangleInnerRect)), radius: cornerRadius, startAngle: 0, endAngle: 90) : rectanglePath.line(to: NSMakePoint(NSMaxX(rectangleRect), NSMaxY(rectangleRect)))
            radiusTopLeft ?         rectanglePath.appendArc(withCenter: NSMakePoint(NSMinX(rectangleInnerRect), NSMaxY(rectangleInnerRect)), radius: cornerRadius, startAngle: 90, endAngle: 180) : rectanglePath.line(to: NSMakePoint(NSMinX(rectangleRect), NSMaxY(rectangleRect)))
            rectanglePath.close()
        
            backgroundColor.set()
            rectanglePath.fill()
        }
    }
    
    
    
}
