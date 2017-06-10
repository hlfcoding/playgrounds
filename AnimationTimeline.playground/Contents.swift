//: Playground - noun: a place where people can play

import UIKit

enum AnimationType {
    case plain, keyframed, spring
}

struct Animation {
    var animations: () -> Void = {}
    var completion: ((Bool) -> Void)?
    var delay: TimeInterval = 0
    var duration: TimeInterval = 0
    var keyframeOptions: UIViewKeyframeAnimationOptions = []
    var options: UIViewAnimationOptions = []
    var spring: (damping: CGFloat, velocity: CGFloat) = (0.7, 1)
    var type: AnimationType = .plain
}

class AnimationTimeline {

    var clearsOnFinish = true
    var needsToCancel = false

    private(set) var cursor: Int = 0

    private var animations = [Animation]()
    private var completion: (() -> Void)?

    func append(animation: Animation) {
        animations.append(animation)
    }

    func start(completion: (() -> Void)? = nil) {
        guard !animations.isEmpty else { return }
        guard self.completion == nil else { return }
        self.completion = completion
        step()
    }

    private func finish() {
        cursor = 0
        needsToCancel = false
        completion?()
        if clearsOnFinish {
            animations.removeAll()
        }
    }

    private func step() {
        let a = animations[cursor]
        let completion: (Bool) -> Void = { finished in
            a.completion?(finished)
            guard self.cursor + 1 < self.animations.count, !self.needsToCancel else {
                self.finish()
                return
            }
            self.cursor += 1
            self.step()
        }
        switch a.type {
        case .plain:
            UIView.animate(
                withDuration: a.duration,
                delay: a.delay,
                options: a.options,
                animations: a.animations,
                completion: completion
            )
        case .keyframed:
            UIView.animateKeyframes(
                withDuration: a.duration,
                delay: a.delay,
                options: a.keyframeOptions,
                animations: a.animations,
                completion: completion
            )
        case .spring:
            UIView.animate(
                withDuration: a.duration,
                delay: a.delay,
                usingSpringWithDamping: a.spring.damping,
                initialSpringVelocity: a.spring.velocity,
                options: a.options,
                animations: a.animations,
                completion: completion
            )
        }
    }

}

let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
view.backgroundColor = UIColor.white

let timeline = AnimationTimeline()

var base = Animation()
base.duration = 1
base.delay = 0.5
base.completion = { _ in
    print(timeline.cursor)
}

var right = base
right.animations = { view.transform.tx = 100 }
timeline.append(animation: right)

var down = base
down.type = .spring
down.animations = { view.transform.ty = 100 }
timeline.append(animation: down)

var left = base
left.type = .keyframed
left.animations = {
    let oldTransform = view.transform
    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
        view.backgroundColor = UIColor.red
        view.transform = view.transform.scaledBy(x: 2, y: 2)
    }
    UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
        view.backgroundColor = UIColor.white
        view.transform = oldTransform
    }
}
timeline.append(animation: left)

import PlaygroundSupport

let stage = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
stage.addSubview(view)
PlaygroundPage.current.liveView = stage

timeline.start() {
    print(timeline.cursor)
}

/*
DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
    timeline.needsToCancel = true
}
*/
