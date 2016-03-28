import UIKit

public enum Color {
    case White, Black, Gray, Blue

    public func asUIColorWithAlpha(alpha: Double?) -> UIColor {
        var result: UIColor
        switch self {
        case .White: result = UIColor.whiteColor()
        case .Black: result = UIColor.blackColor()
        case .Gray: result = UIColor.grayColor()
        case .Blue: result = UIColor(red: 0.0, green: 0.29, blue: 0.71, alpha: 1.0)
        }
        if let alpha = alpha {
            result = result.colorWithAlphaComponent(CGFloat(alpha))
        }
        return result
    }
    public func asUIColor() -> UIColor { return self.asUIColorWithAlpha(1.0) }

    public func asCGColorWithAlpha(alpha: Double) -> CGColor {
        return self.asUIColorWithAlpha(alpha).CGColor
    }
    public func asCGColor() -> CGColor { return self.asCGColorWithAlpha(1.0) }
}
