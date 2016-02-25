import UIKit

enum Color {
    case White, Black
}

func color(color: Color, withAlpha alpha: Double = 1.0) -> CGColor {
    var result: UIColor
    switch color {
    case .White: result = UIColor.whiteColor()
    case .Black: result = UIColor.blackColor()
    }
    if alpha < 1.0 {
        result = result.colorWithAlphaComponent(CGFloat(alpha))
    }
    return result.CGColor
}
