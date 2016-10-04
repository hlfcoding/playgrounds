import UIKit

public enum Color {
    case white, black, gray, blue

    public func asUIColor(alpha: Double? = 1) -> UIColor {
        var result: UIColor!
        switch self {
        case .white: result = UIColor.white
        case .black: result = UIColor.black
        case .gray: result = UIColor.gray
        case .blue: result = UIColor(red: 0, green: 0.29, blue: 0.71, alpha: 1)
        default: fatalError()
        }
        if let alpha = alpha {
            result = result.withAlphaComponent(CGFloat(alpha))
        }
        return result
    }

    public func asCGColor(alpha: Double? = 1) -> CGColor {
        return self.asUIColor(alpha: alpha).cgColor
    }
}
