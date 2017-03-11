//
//  Colors.swift
//  Track Your Reps
//
//  Created by Benjamin Bernstein on 3/10/17.
//  Copyright © 2017 Burning Flowers. All rights reserved.
//

import UIKit
import Foundation

enum Palette {
    case pink, blue, red, green
    
    var color: UIColor {
        switch self {
        case .pink: return UIColor(hex: 0xFFDCE5)
        case .blue: return UIColor(hex: 0x2D9CDB)
        case .red: return UIColor(hex: 0xEB5757)
        case .green: return UIColor(hex: 0x27AE60)
        }
    }
}

extension UIColor {
    
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
    
    class func forGradient(_ red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
    }
    
}
