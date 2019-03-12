//
//  UILabel+.swift
//  TodoList
//
//  Created by Huy on 3/11/19.
//  Copyright © 2019 Long. All rights reserved.
//

import UIKit

extension UILabel {
    func setStrikeThroughStyle(_ value: CGFloat, _ colorStrike: UIColor) {
        guard let labelText = self.text else { return }
        
        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value:value, range:NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.strikethroughColor, value: colorStrike, range: NSMakeRange(0, attributedString.length))
        self.attributedText = attributedString
    }
    
    func removeStrikeThroughStyle(){
        let attr = NSMutableAttributedString(string: self.text!)
        attr.addAttribute(NSAttributedString.Key.font, value: self.font, range: NSMakeRange(0, attr.length))
        attributedText = attr
    }
}
