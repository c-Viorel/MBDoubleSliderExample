//
//  MBCustomKnob.swift
//  customDoubleSlider
//
//  Created by Viorel Porumbescu on 18/10/15.
//  Copyright (c) 2015 Viorel Porumbescu. All rights reserved.
//

import Cocoa


@IBDesignable
class MBCustomKnob: NSView {
    
    var color:NSColor           = NSColor.white
    var borderColor: NSColor    = NSColor.lightGray.withAlphaComponent(0.5)
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        self.wantsLayer             = true
        self.layer?.cornerRadius    = self.frame.height / 2
        self.layer?.borderColor     = borderColor.cgColor
        self.layer?.borderWidth     = 1.2
        self.layer?.backgroundColor = color.cgColor
        self.layer?.masksToBounds = false
        
        
    }
    
}
