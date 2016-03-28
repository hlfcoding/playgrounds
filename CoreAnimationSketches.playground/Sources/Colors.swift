import UIKit

public enum Color {
    case White, Black, Blue
}

public func color(color: Color, withAlpha alpha: Double = 1.0) -> CGColor {
    var result: UIColor
    switch color {
    case .White: result = UIColor.whiteColor()
    case .Black: result = UIColor.blackColor()
    case .Blue: result = UIColor(red: 0.0, green: 0.29, blue: 0.71, alpha: 1.0)
    }
    if alpha < 1.0 {
        result = result.colorWithAlphaComponent(CGFloat(alpha))
    }
    return result.CGColor
}
