import CoreGraphics
//:
//: ## CoreGraphics Sketches
//:
//: Explore various `CoreGraphics` methods and concepts, especially around transforms.
//:
var frame: CGRect { return CGRect(origin: CGPointZero, size: CGSize(width: 10.0, height: 10.0)) }
//:
//: Using `CGAffineTransformMake` to get an identity transform. With the last one being canonical.
//:
//: For each of the four points:
//  > new x position = old x position * a + old y position * c + tx
//:   new y position = old x position * b + old y position * d + ty
//:
var identity = CGAffineTransform(a: 0.0, b: 0.0, c: 1.0, d: 1.0, tx: 0.0, ty: 0.0)
CGRectApplyAffineTransform(frame, identity)
identity = CGAffineTransform(a: 1.0, b: 1.0, c: 0.0, d: 0.0, tx: 0.0, ty: 0.0)
CGRectApplyAffineTransform(frame, identity)
identity = CGAffineTransform(a: 1.0, b: 0.0, c: 0.0, d: 1.0, tx: 0.0, ty: 0.0)
CGRectApplyAffineTransform(frame, identity)
//:
//: Using `CGAffineTransformIdentity` is simpler.
//:
identity = CGAffineTransformIdentity
CGRectApplyAffineTransform(frame, identity)
//:
//: Scaling becomes more obvious.
//:
var scaling = CGAffineTransform(a: 1.5, b: 0.0, c: 0.0, d: 2.0, tx: 0.0, ty: 0.0)
CGRectApplyAffineTransform(frame, scaling)
scaling = CGAffineTransformMakeScale(1.5, 2.0)
CGRectApplyAffineTransform(frame, scaling)
//:
//: Using `CGAffineTransformMake` to make a translation transform.
//:
var translation = CGAffineTransform(a: 1.0, b: 0.0, c: 0.0, d: 1.0, tx: -10.0, ty: 10.0)
CGRectApplyAffineTransform(frame, translation)
translation = CGAffineTransformMakeTranslation(-10.0, 10.0)
CGRectApplyAffineTransform(frame, translation)
