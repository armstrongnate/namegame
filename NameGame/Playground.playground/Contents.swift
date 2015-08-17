//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

let view = UIView(frame: CGRectMake(0, 0, 300, 300))
view.backgroundColor = UIColor.lightGrayColor()
view.setTranslatesAutoresizingMaskIntoConstraints(false)
XCPShowView("view", view)

let imageView = UIImageView()
imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
view.addSubview(imageView)
view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-[imageView]-|", options: NSLayoutFormatOptions(0), metrics: nil, views: ["imageView": imageView]))

let label = UILabel()
label.setTranslatesAutoresizingMaskIntoConstraints(false)
label.text = "Nate Armstrong"
label.sizeToFit()
view.addSubview(label)
view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-[label]-|", options: NSLayoutFormatOptions(0), metrics: nil, views: ["label": label]))

view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[imageView]-[label]-|", options: NSLayoutFormatOptions(0), metrics: nil, views: ["imageView": imageView, "label": label]))

let animator = UIDynamicAnimator(referenceView: view)

let attachment = UIAttachmentBehavior(item: view, offsetFromCenter: UIOffsetZero, attachedToAnchor: CGPointZero)

animator.addBehavior(attachment)