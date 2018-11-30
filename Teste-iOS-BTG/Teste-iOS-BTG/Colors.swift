import Foundation
import UIKit

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat? = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a!)
    }
    
    static let btg_blue = UIColor(r: 0.0, g: 143.0, b: 212.0)
    static let btg_green = UIColor(r: 166.0, g: 206.0, b: 57.0)
    static let btg_brown = UIColor(r: 154.0, g: 103.0, b: 53.0)
    static let btg_orange = UIColor(r: 245.0, g: 125.0, b: 13.0)
    static let btg_red = UIColor(r: 185.0, g: 72.0, b: 74.0)
    
}
