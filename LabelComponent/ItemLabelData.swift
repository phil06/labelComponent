//
//  ItemLabelData.swift
//  LabelComponent
//
//  Created by NHNEnt on 24/04/2019.
//  Copyright © 2019 saera. All rights reserved.
//

import Foundation

public class ItemLabelData: NSObject {
    var key: String?
    var val: String
    
    var keyAttributes: [NSAttributedString.Key: Any]?
    var valAttributes: [NSAttributedString.Key: Any]?
    
    public convenience init(key: String, val: String,
         keyAttributes: [NSAttributedString.Key: Any]?,
         valAttributes: [NSAttributedString.Key: Any]?) {
        self.init(val: val)
        self.key = key
        self.keyAttributes = keyAttributes
        self.valAttributes = valAttributes
    }

    public convenience init(key: String, val: String) {
        self.init(val: val)
        self.key = key
    }
    
    public init(val: String) {
        self.val = val
    }

}


