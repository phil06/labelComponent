//
//  ExtendedUIFont.swift
//  LabelComponent
//
//  Created by NHNEnt on 07/05/2019.
//  Copyright © 2019 saera. All rights reserved.
//

import Foundation

extension UIFont {
    /*
     estimate text size by width
     */
    public func sizeOf(string: String, byWidth width: Double) -> CGSize {
        return NSString(string: string).boundingRect(with: CGSize(width: width, height: .greatestFiniteMagnitude),
                                                     options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                     attributes: [NSAttributedString.Key.font: self],
                                                             context: nil).size
    }
    
    /*
     estimage text size by font size
     */
    public func sizeOf(string: String) -> CGSize {
        return NSString(string: string).boundingRect(with: CGSize(width: .greatestFiniteMagnitude, height: self.pointSize),
                                                     options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                     attributes: [NSAttributedString.Key.font: self],
                                                     context: nil).size
    }
}
