//:
//: ## CoreAnimation Sketches
//:
//: Explore framework classes on a single stage.
//:
import XCPlayground
import UIKit

let gutter: CGFloat = 20
let stage = UIView(frame: CGRect(origin: CGPointZero, size: CGSize(width: 1100, height: 300)))
stage.backgroundColor = UIColor.lightGrayColor()
XCPlaygroundPage.currentPage.liveView = stage
//:
//: ### Simple Button
//:
//: A tour of base `CALayer` properties. Some layout boilerplate involved.
//:
let button = UIButton(frame: CGRect(origin: CGPoint(x: gutter, y: gutter), size: CGSizeZero))
button.setTitle("OK", forState: .Normal)
button.sizeToFit()
let padding: CGFloat = 10
button.frame.insetInPlace(dx: -padding, dy: 0)
button.frame.offsetInPlace(dx: padding, dy: 0)
stage.addSubview(button)

button.setTitleColor(Color.Black.asUIColor(), forState: .Normal)
button.setTitleColor(Color.Blue.asUIColor(), forState: .Highlighted)
button.layer.backgroundColor = Color.White.asCGColor()
button.layer.borderColor = Color.Black.asCGColorWithAlpha(0.4)
button.layer.borderWidth = 1
button.layer.cornerRadius = 5
button.layer.shadowColor = Color.Black.asCGColor()
button.layer.shadowOffset = CGSizeZero
button.layer.shadowOpacity = 0.3
button.layer.shadowRadius = 1
//:
//: ### Animated Activity Indicator
//:
//: A tour of base `CABasicAnimation` and `CAShapeLayer` properties. Some layout boilerplate involved.
//:
class ActivityIndicator: View {

    var cycleDuration: NSTimeInterval = 1
    var dotCount = 3
    var fillColor = Color.Gray.asUIColor()
    var gutterRatio: CGFloat = 0.2
    var toAlpha: CGFloat = 0.5

    var blockSize: CGFloat { return floor(frame.width / CGFloat(dotCount)) }
    var dotSize: CGFloat { return floor(blockSize * (1 - gutterRatio)) }
    var duration: NSTimeInterval { return cycleDuration / 2 }
    var gutterSize: CGFloat { return (blockSize - dotSize) / 2 }
    var stagger: NSTimeInterval { return cycleDuration / Double(dotCount) }

    var animations = [CAAnimation]()

    override func setUp() {
        for i in 0..<dotCount {
            layer.addSublayer(createDotAtIndex(i))
        }
    }

    func createDotAtIndex(index: Int) -> CAShapeLayer {
        let dot = CAShapeLayer()
        dot.fillColor = fillColor.CGColor
        let containingRect = CGRect(x: blockSize * CGFloat(index), y: gutterSize, width: dotSize, height: dotSize)
        dot.path = UIBezierPath(ovalInRect: containingRect).CGPath
        let animation = createDotAnimationAtIndex(index)
        dot.addAnimation(animation, forKey: "opacity")
        animations.append(animation)
        return dot
    }

    func createDotAnimationAtIndex(index: Int) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.autoreverses = true
        animation.beginTime = Double(index + 1) * stagger;
        animation.duration = duration
        animation.fromValue = NSNumber(float: 1)
        animation.repeatCount = Float.infinity
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.toValue = NSNumber(float: Float(toAlpha))
        return animation
    }
}

let indicator = ActivityIndicator(frame: CGRect(
    origin: CGPoint(x: button.frame.maxX + gutter, y: gutter),
    size: CGSize(width: 100, height: 30)
))
stage.addSubview(indicator)
