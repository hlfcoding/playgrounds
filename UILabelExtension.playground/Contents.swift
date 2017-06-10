//: Playground - noun: a place where people can play

import UIKit

var isExtensionEnabled = true

extension UILabel {

    func hlf_attributesFromProperties() -> [String : Any] {
        var attributes = attributedText?.attributes(at: 0, effectiveRange: nil)
            ?? [String : Any]()
        attributes[NSFontAttributeName] = font
        attributes[NSForegroundColorAttributeName] = textColor
        let paragraphStyle = (
                attributes[NSParagraphStyleAttributeName] as? NSParagraphStyle
            )?.mutableCopy() as? NSMutableParagraphStyle
            ?? NSMutableParagraphStyle()
        paragraphStyle.alignment = textAlignment
        attributes[NSParagraphStyleAttributeName] = paragraphStyle
        return attributes
    }

    func hlf_pointsByEms(_ ems: CGFloat) -> CGFloat {
        return round(ems * font.pointSize)
    }

    func hlf_setKerning(_ points: CGFloat) {
        guard let text = text else { return assertionFailure() }
        var attributes = hlf_attributesFromProperties()
        attributes[NSKernAttributeName] = points
        attributedText = NSAttributedString(string: text, attributes: attributes)
    }

    func hlf_setLineHeight(_ points: CGFloat) {
        guard let text = text else { return assertionFailure() }
        var attributes = hlf_attributesFromProperties()
        let paragraphStyle = attributes[NSParagraphStyleAttributeName]
            as! NSMutableParagraphStyle
        paragraphStyle.maximumLineHeight = points
        attributes[NSParagraphStyleAttributeName] = paragraphStyle
        attributedText = NSAttributedString(string: text, attributes: attributes)
    }

    func hlf_updateText(_ text: String) {
        guard attributedText != nil else {
            self.text = text
            return
        }
        let attributes = hlf_attributesFromProperties()
        attributedText = NSAttributedString(string: text, attributes: attributes)
    }

}

let label = UILabel()
label.backgroundColor = .clear
label.font = .preferredFont(forTextStyle: .title1)
label.numberOfLines = 0
label.textAlignment = .center
label.textColor = .darkText
label.hlf_updateText("Hello, playground. You are looking okay.")

if isExtensionEnabled {
    label.hlf_setKerning(-0.5)
    label.hlf_setLineHeight(label.hlf_pointsByEms(1.1))
    label.hlf_updateText("Hello, playground. You are looking good.")
}

let width = label.hlf_pointsByEms(9)
label.frame.size.width = width
label.sizeToFit()
label.frame.size.width = width

import PlaygroundSupport

let container = UIView(
    frame: label.frame.insetBy(
        dx: label.hlf_pointsByEms(-1.2), dy: label.hlf_pointsByEms(-1.1)
    )
)
container.backgroundColor = .lightGray
container.addSubview(label)
label.center = CGPoint(x: container.bounds.midX, y: container.bounds.midY)
PlaygroundPage.current.liveView = container
