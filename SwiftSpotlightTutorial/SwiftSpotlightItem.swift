//
// SwiftSpotlightTutorial
// (c) 2017 Alexander Weleczka
//
// https://AWeleczka.de/swift/SwiftSpotlightTutorial/
// https://github.com/AWeleczka/SwiftSpotlightTutorial/
//

import UIKit

public class SwiftSpotlightItem {
  public enum Shape {
    case rectangle
    case roundRectangle
    case circle
  }

  private let target: CGRect
  private let shape: SwiftSpotlightItem.Shape
  private let text: SwiftSpotlightText?
  private let image: SwiftSpotlightImage?
  private let ctabutton: SwiftSportlightButton?

  private let margin: UIEdgeInsets
  private let radius: CGFloat

  private let allowPassthrough: Bool

  public var info: Any? = nil

  public init(
    target: CGRect,
    shape: SwiftSpotlightItem.Shape,
    text: SwiftSpotlightText?,
    image: SwiftSpotlightImage?,
    ctabutton: SwiftSportlightButton?,
    margin: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0),
    radius: CGFloat = 2,
    allowPassthrough: Bool = false
  ) {
    self.target = target
    self.shape = shape
    self.text = text
    self.image = image
    self.ctabutton = ctabutton
    self.margin = margin
    self.radius = radius
    self.allowPassthrough = allowPassthrough
  }

  public func getTarget() -> CGRect {
    return target
  }

  public func getShape() -> SwiftSpotlightItem.Shape {
    return shape
  }

  public func getText() -> SwiftSpotlightText? {
    return text
  }

  public func getImage() -> SwiftSpotlightImage? {
    return image
  }

  public func getCTAButton() -> SwiftSportlightButton? {
    return ctabutton
  }

  public func getMargin() -> UIEdgeInsets {
    return margin
  }

  public func getRadius() -> CGFloat {
    return radius
  }

  public func isPassthrough() -> Bool {
    return allowPassthrough
  }
}

public class SwiftSpotlightText {
  private let text: String?
  private let attributed: NSAttributedString?
  private let position: CGRect?

  public init(text: String, position: CGRect? = nil) {
    self.text = text
    attributed = nil
    self.position = position
  }

  public init(attributed: NSAttributedString, position: CGRect? = nil) {
    text = nil
    self.attributed = attributed
    self.position = position
  }

  internal func getText() -> String? {
    return text
  }

  internal func getAttributed() -> NSAttributedString? {
    return attributed
  }

  internal func getPosition() -> CGRect? {
    return position
  }
}

public class SwiftSpotlightImage {
  private let image: UIImage?
  private let position: CGRect?

  public init(image: UIImage?, position: CGRect? = nil) {
    self.image = image
    self.position = position
  }

  internal func getImage() -> UIImage? {
    return image
  }

  internal func getPosition() -> CGRect? {
    return position
  }
}

public class SwiftSportlightButton {
  private let text: String
  private let target: Any?
  private let selector: Selector
  private let position: CGRect?

  public init(text: String, target: Any?, selector: Selector, position: CGRect? = nil) {
    self.text = text
    self.target = target
    self.selector = selector
    self.position = position
  }

  public func getButton() -> UIButton {
    let buttonTap = UITapGestureRecognizer(target: target, action: selector)
    let button = UIButton()
    button.setTitle(text, for: .normal)
    button.addGestureRecognizer(buttonTap)

    return button
  }

  public func getPosition() -> CGRect? {
    return position
  }
}
