//:
//: ## CoreAnimation Sketches
//:
//: Explore framework classes on a single stage.
//:
import PlaygroundSupport
import UIKit

let gutter: CGFloat = 20
let stage = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 1100, height: 300)))
stage.backgroundColor = UIColor.lightGray
PlaygroundPage.current.liveView = stage
//:
//: ### Simple Button
//:
//: A tour of base `CALayer` properties. Some layout boilerplate involved.
//:
let button = UIButton(frame: CGRect(origin: CGPoint(x: gutter, y: gutter), size: .zero))
button.setTitle("OK", for: .normal)
button.sizeToFit()
let padding: CGFloat = 10
button.frame = button.frame.insetBy(dx: -padding, dy: 0).offsetBy(dx: padding, dy: 0)
stage.addSubview(button)

button.setTitleColor(Color.black.asUIColor(), for: .normal)
button.setTitleColor(Color.blue.asUIColor(), for: .highlighted)
button.layer.backgroundColor = Color.white.asCGColor()
button.layer.borderColor = Color.black.asCGColor(alpha: 0.4)
button.layer.borderWidth = 1
button.layer.cornerRadius = 5
button.layer.shadowColor = Color.black.asCGColor()
button.layer.shadowOffset = .zero
button.layer.shadowOpacity = 0.3
button.layer.shadowRadius = 1
//:
//: ### Animated Activity Indicator
//:
//: A tour of base `CABasicAnimation` and `CAShapeLayer` properties. Some layout boilerplate involved.
//:
class ActivityIndicator: View {

    var cycleDuration: TimeInterval = 1
    var dotCount = 3
    var fillColor = Color.gray.asUIColor()
    var gutterRatio: CGFloat = 0.2
    var toAlpha: CGFloat = 0.5

    var blockSize: CGFloat { return floor(frame.width / CGFloat(dotCount)) }
    var dotSize: CGFloat { return floor(blockSize * (1 - gutterRatio)) }
    var duration: TimeInterval { return cycleDuration / 2 }
    var gutterSize: CGFloat { return (blockSize - dotSize) / 2 }
    var stagger: TimeInterval { return cycleDuration / Double(dotCount) }

    var animations = [CAAnimation]()

    override func setUp() {
        for i in 0..<dotCount {
            layer.addSublayer(createDot(at: i))
        }
    }

    func createDot(at index: Int) -> CAShapeLayer {
        let dot = CAShapeLayer()
        dot.fillColor = fillColor.cgColor
        let containingRect = CGRect(x: blockSize * CGFloat(index), y: gutterSize, width: dotSize, height: dotSize)
        dot.path = UIBezierPath(ovalIn: containingRect).cgPath
        let animation = createDotAnimation(at: index)
        dot.add(animation, forKey: "opacity")
        animations.append(animation)
        return dot
    }

    func createDotAnimation(at index: Int) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.autoreverses = true
        animation.beginTime = Double(index + 1) * stagger
        animation.duration = duration
        animation.fromValue = NSNumber(value: 1)
        animation.repeatCount = Float.infinity
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.toValue = NSNumber(value: Float(toAlpha))
        return animation
    }
}

let indicator = ActivityIndicator(frame: CGRect(
    origin: CGPoint(x: button.frame.maxX + gutter, y: gutter),
    size: CGSize(width: 100, height: 30)
))
stage.addSubview(indicator)
//:
//: ### View with 'Mask' Transition
//:
//: A tour of `CALayer` masks and using `CATransaction` alongside `UIView` animation. Some layout and gesture
//: boilerplate involved.
//:
class MaskTransitionView: View {
    
    class ContentView: View {
        var label: UILabel!
        var text: String = "" {
            didSet {
                label.text = text
                label.sizeToFit()
            }
        }

        override func setUp() {
            label = UILabel(frame: .zero)
            addSubview(label)
        }

        override func layoutSubviews() {
            label.center = center
        }
    }

    var interstitialView: ContentView!
    var originalView: ContentView!
    // A supplemental part of the transition.
    var interstitialBackgroundView: UIView!

    var tapRecognizer: UITapGestureRecognizer!

    override func setUp() {
        clipsToBounds = true
        layer.cornerRadius = 5

        originalView = ContentView(frame: bounds)
        originalView.backgroundColor = Color.white.asUIColor()
        originalView.text = "WHITE"
        addSubview(originalView)

        interstitialBackgroundView = UIView(frame: bounds)
        interstitialBackgroundView.backgroundColor = Color.gray.asUIColor()
        originalView.insertSubview(interstitialBackgroundView, belowSubview: originalView.label)

        interstitialView = ContentView(frame: bounds)
        interstitialView.backgroundColor = originalView.label.textColor
        interstitialView.text = "BLACK"
        interstitialView.label.textColor = originalView.backgroundColor
        insertSubview(interstitialView, belowSubview: originalView)

        let mask = CALayer()
        mask.backgroundColor = Color.white.asCGColor()
        mask.frame = bounds
        originalView.layer.mask = mask

        prepareMaskTransition()

        tapRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(MaskTransitionView.performMaskTransition(_:))
        )
        addGestureRecognizer(tapRecognizer)
    }

    deinit {
        removeGestureRecognizer(tapRecognizer)
    }

    func prepareMaskTransition() {
        interstitialBackgroundView.frame.size.height = 0
        interstitialBackgroundView.frame.origin.y = 0

        guard let mask = originalView.layer.mask else { return }
        CATransaction.begin()
        CATransaction.setAnimationDuration(0)
        mask.position = originalView.center
        CATransaction.commit()
    }

    @IBAction func performMaskTransition(_ sender: AnyObject? = nil) {
        guard let mask = originalView.layer.mask else { return }

        prepareMaskTransition()

        UIView.animate(
            withDuration: 0.5, delay: 0, options: .curveEaseInOut,
            animations: {
                self.interstitialBackgroundView.frame = self.bounds
            }
        ) { (finished) in
            CATransaction.begin()
            CATransaction.setAnimationDuration(0.5)
            CATransaction.setAnimationTimingFunction(
                CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            )
            mask.position.y += self.originalView.frame.size.height
            CATransaction.commit()
        }
    }

}

let transitionView = MaskTransitionView(frame: CGRect(
    origin: CGPoint(x: indicator.frame.maxX + gutter, y: gutter),
    size: CGSize(width: 100, height: 100)
))
stage.addSubview(transitionView)
