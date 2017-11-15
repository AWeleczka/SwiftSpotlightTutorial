//
// SwiftSpotlightTutorial
// (c) 2017 Alexander Weleczka
//
// https://AWeleczka.de/swift/SwiftSpotlightTutorial/
// https://github.com/AWeleczka/SwiftSpotlightTutorial/
//

import UIKit

public class SwiftSpotlightView: UIView, CAAnimationDelegate {
  public var config: SwiftSpotlightConfig = SwiftSpotlightConfig()
  public weak var delegate: SwiftSpotlightDelegate?

  private var spotlights: [SwiftSpotlightItem] = []
  private var currentIndex: Int = 0

  private var tapGestureRecognizer = UITapGestureRecognizer()

  private var hitTestPoints: [CGPoint] = []

  public override init(frame: CGRect) {
    super.init(frame: frame)

    setup(spotlights: [])
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    setup(spotlights: [])
  }

  public init(frame: CGRect, spotlights: [SwiftSpotlightItem]) {
    super.init(frame: frame)

    setup(spotlights: spotlights)
  }

  private func setup(spotlights: [SwiftSpotlightItem]) {
    // SpotlightItems
    self.spotlights = spotlights

    // Tap Gesture Recognizer Setup
    tapGestureRecognizer.addTarget(self, action: #selector(SwiftSpotlightView.nextSpotlight))
    tapGestureRecognizer.numberOfTapsRequired = 1
  }

  public func attach(controller: UIViewController) {
    attach(view: controller.view)
  }

  public func attach(view: UIView) {
    delegate?.spotlightWillAppear(spotlight: self)

    view.addSubview(self)

    navigate()
  }

  public func detach() {
    delegate?.spotlightWillDisappear(spotlight: self)

    removeFromSuperview()
  }

  @objc public func nextSpotlight() {
    navigate(to: currentIndex + 1)
  }

  private func navigate(to index: Int = 0) {
    guard spotlights.count > 0 else {
      return
    }

    if index > 0 && index < spotlights.count {
      currentIndex = index
    } else {
      currentIndex = 0
    }

    UIView.animate(
      withDuration: config.animationDuration,
      delay: 0.0,
      options: .curveEaseInOut,
      animations: {
        for view in self.subviews {
          view.removeFromSuperview()
        }
        self.display(self.spotlights[self.currentIndex])
      },
      completion: nil)
  }

  private func display(_ spotlight: SwiftSpotlightItem) {
    DispatchQueue.main.async {
      let background = UIView(frame: self.frame)

      self.addGestureRecognizer(self.tapGestureRecognizer)
      if spotlight.isPassthrough() == true {
        self.removeGestureRecognizer(self.tapGestureRecognizer)
      }

      let drawlayer = CAShapeLayer()
      drawlayer.fillRule = kCAFillRuleEvenOdd
      drawlayer.fillColor = self.config.layerColor.withAlphaComponent(self.config.layerAlpha).cgColor

      background.layer.addSublayer(drawlayer)

      if let label = self.setupText(spotlight) {
        background.addSubview(label)
      }

      if let imageview = self.setupImage(spotlight) {
        background.addSubview(imageview)
      }

      if let button = self.setupCTAButton(spotlight) {
        background.addSubview(button)
      }

      self.addSubview(background)

      let drawpath = self.setupBezierPath(spotlight)
      self.animateBezierPath(drawlayer, drawpath)
    }
  }

  private func setupText(_ spotlight: SwiftSpotlightItem) -> UILabel? {
    if let text = spotlight.getText() {
      let label = UILabel()
      label.font = config.labelFont
      label.textColor = config.labelColor
      label.textAlignment = .center

      if let attributed = text.getAttributed() {
        label.attributedText = attributed
      } else {
        label.text = text.getText() ?? ""
      }

      if let position = text.getPosition() {
        label.frame = position
      } else {
        label.frame = CGRect(x: 0, y: 0, width: frame.width, height: 0)
        label.sizeToFit()
        label.frame = CGRect(x: 0, y: 0, width: frame.width, height: label.frame.height)

        if spotlight.getTarget().maxY > frame.height * 0.9 {
          label.frame.origin.y = spotlight.getTarget().minY - 10 - label.frame.height
        } else {
          label.frame.origin.y = spotlight.getTarget().maxY + 10
        }
      }

      return label
    }

    return nil
  }

  private func setupImage(_ spotlight: SwiftSpotlightItem) -> UIImageView? {
    if let image = spotlight.getImage() {
      let imageview = UIImageView()
      imageview.image = image.getImage()
      imageview.contentMode = .scaleAspectFit
      imageview.sizeToFit()

      if let position = image.getPosition() {
        imageview.frame = position
      } else {
        imageview.frame = CGRect(x: 0, y: 0, width: imageview.frame.width, height: imageview.frame.height)

        if spotlight.getTarget().minY > frame.height * 0.1 {
          imageview.frame.origin.y = spotlight.getTarget().minY - 10 - imageview.frame.height
        } else {
          imageview.frame.origin.y = spotlight.getTarget().maxY + 10
        }

        if spotlight.getTarget().minX > frame.width * 0.5 {
          imageview.frame.origin.x = spotlight.getTarget().maxX + 10
        } else {
          imageview.frame.origin.x = spotlight.getTarget().minX - 10 - imageview.frame.width
        }
      }

      return imageview
    }

    return nil
  }

  private func setupCTAButton(_ spotlight: SwiftSpotlightItem) -> UIButton? {
    if let ctabutton = spotlight.getCTAButton() {
      let button = ctabutton.getButton()
      button.setTitleColor(config.ctaForegroundColor, for: .normal)
      button.backgroundColor = config.ctaBackgroundColor
      if let position = ctabutton.getPosition() {
        button.frame = position
      } else {
        button.frame = CGRect(
          x: (frame.width - frame.width / 3) / 2,
          y: frame.height - frame.height / 5,
          width: frame.width / 3,
          height: frame.width / 3 / 4)
      }

      return button
    }

    return nil
  }

  private func setupBezierPath(_ spotlight: SwiftSpotlightItem) -> UIBezierPath {
    let spotlightPath = UIBezierPath(rect: bounds)
    var cutoutPath = UIBezierPath()

    let rect = CGRect(
      x: spotlight.getTarget().origin.x - config.margin.left,
      y: spotlight.getTarget().origin.y - config.margin.top,
      width: spotlight.getTarget().width + config.margin.left + config.margin.right,
      height: spotlight.getTarget().height + config.margin.top + config.margin.bottom)

    switch spotlight.getShape() {
    case .circle:
      cutoutPath = UIBezierPath(ovalIn: rect)
    case .rectangle:
      cutoutPath = UIBezierPath(rect: rect)
    case .roundRectangle:
      cutoutPath = UIBezierPath(roundedRect: rect, cornerRadius: config.radius)
    }

    spotlightPath.append(cutoutPath)

    return spotlightPath
  }

  private func animateBezierPath(_ layer: CAShapeLayer, _ path: UIBezierPath) {
    let animationKeyPath = "path"
    let animation = CABasicAnimation(keyPath: animationKeyPath)
    animation.delegate = self
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    animation.duration = config.animationDuration
    animation.isRemovedOnCompletion = false
    animation.fillMode = kCAFillModeForwards
    animation.fromValue = layer.path
    animation.toValue = path.cgPath
    layer.add(animation, forKey: animationKeyPath)
    layer.path = path.cgPath
  }

  public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    let view = super.hitTest(point, with: event)
    let localPoint = convert(point, from: self)
    hitTestPoints.append(localPoint)

    guard currentIndex < spotlights.count else {
      return view
    }

    let currentSpotlight = spotlights[currentIndex]
    if currentSpotlight.getTarget().contains(localPoint), currentSpotlight.isPassthrough() {
      if hitTestPoints.filter({ $0 == localPoint }).count == 1 {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15, execute: {
          self.detach()
        })
      }
      return nil
    }

    return view
  }
}
