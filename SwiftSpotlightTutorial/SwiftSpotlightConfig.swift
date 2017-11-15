//
// SwiftSpotlightTutorial
// (c) 2017 Alexander Weleczka
//
// https://AWeleczka.de/swift/SwiftSpotlightTutorial/
// https://github.com/AWeleczka/SwiftSpotlightTutorial/
//

import UIKit

public struct SwiftSpotlightConfig {

  /// Duration of transition-animations (TODO)
  public var animationDuration: TimeInterval = 0.5

  /// Spacing around the definied target
  public var margin: UIEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)

  /// Radius for roundedRect
  public var radius: CGFloat = 5.0

  /// Font-Setting of the info-label
  public var labelFont: UIFont = UIFont.systemFont(ofSize: 17.0)

  /// Textcolor of the info-label
  public var labelColor: UIColor = UIColor.white

  /// Base-Color of the tutorial-layer
  public var layerColor: UIColor = UIColor.black

  /// Alpha of the tutorial-layer (0.0 to 1.0)
  public var layerAlpha: CGFloat = 0.5

  /// Backgroundcolor of the Call-To-Action-Button
  public var ctaBackgroundColor: UIColor = UIColor.orange

  /// Textcolor of the Call-To-Action-Button
  public var ctaForegroundColor: UIColor = UIColor.white

  /// Whether or not a "Skip"-Button should be shown in the tutorial (TODO)
  public var showSkipButton: Bool = false

  /// Whether or not a "Continue"-Button should be shown in the tutorial (TODO)
  public var showContinueButton: Bool = false

  /// Whether tapping the darkened area continues the navigation through the spotlights or not
  public var tapContinuesTutorial: Bool = true
  
}
