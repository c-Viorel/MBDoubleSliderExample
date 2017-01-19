//
//  MBTransparentWindow.swift
//  iClock
//
//  Created by Viorel Porumbescu on 23/02/16.
//  Copyright © 2016 Viorel Porumbescu. All rights reserved.
//

import Cocoa

class MBTransparentWindow: NSWindow {
    
    // Override init to make window completely transparent and movable by background
    override init(contentRect: NSRect, styleMask aStyle: NSWindowStyleMask, backing bufferingType: NSBackingStoreType, defer flag: Bool) {

        super.init(contentRect: contentRect, styleMask: aStyle, backing: bufferingType, defer: flag)
        self.backgroundColor                                                = NSColor.clear
        self.level                                                          = 0
        self.isOpaque                                                         = false
        self.hasShadow                                                        = false
        self.titleVisibility                                                  = NSWindowTitleVisibility.hidden
        self.titlebarAppearsTransparent                                       = true
        self.isMovableByWindowBackground                                      = true
        self.standardWindowButton(NSWindowButton.miniaturizeButton)?.isHidden = true
        self.standardWindowButton(NSWindowButton.zoomButton)?.isHidden        = true
        self.standardWindowButton(NSWindowButton.closeButton)?.isHidden       = false
    }


}

