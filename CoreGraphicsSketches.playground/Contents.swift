//:
//: ## CoreGraphics Sketches
//:
//: Explore various `CoreGraphics` methods and concepts, especially around transforms.
//:
import CoreGraphics

var frame: CGRect { return CGRect(origin: .zero, size: CGSize(width: 10, height: 10)) }
//:
//: Using `CGAffineTransformMake` to get an identity transform. With the last one being canonical.
//:
//: For each of the four points:
//:
//:     new x position = old x position * a + old y position * c + tx
//:     new y position = old x position * b + old y position * d + ty
//:
var identity = CGAffineTransform(a: 0, b: 0, c: 1, d: 1, tx: 0, ty: 0)
frame.applying(identity)
identity = CGAffineTransform(a: 1, b: 1, c: 0, d: 0, tx: 0, ty: 0)
frame.applying(identity)
identity = CGAffineTransform(a: 1, b: 0, c: 0, d: 1, tx: 0, ty: 0)
frame.applying(identity)
//:
//: Using `CGAffineTransformIdentity` is simpler.
//:
identity = .identity
frame.applying(identity)
//:
//: Scaling becomes more obvious.
//:
var scaling = CGAffineTransform(a: 1.5, b: 0, c: 0, d: 2, tx: 0, ty: 0)
frame.applying(scaling)
scaling = CGAffineTransform(scaleX: 1.5, y: 2)
frame.applying(scaling)
//:
//: Using `CGAffineTransformMake` to make a translation transform.
//:
var translation = CGAffineTransform(a: 1, b: 0, c: 0, d: 1, tx: -10, ty: 10)
frame.applying(translation)
translation = CGAffineTransform(translationX: -10, y: 10)
frame.applying(translation)
