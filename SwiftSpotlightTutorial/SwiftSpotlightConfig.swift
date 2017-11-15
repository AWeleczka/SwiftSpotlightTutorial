//
// SwiftSpotlightTutorial
// (c) 2017 Alexander Weleczka
//
// https://AWeleczka.de/swift/SwiftSpotlightTutorial/
// https://github.com/AWeleczka/SwiftSpotlightTutorial/
//

import UIKit

public struct SwiftSpotlightConfig {
  public var animationDuration: TimeInterval = 0.5

  public var margin: UIEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
  public var radius: CGFloat = 5.0

  // Label-Configuration
  public var labelFont: UIFont = UIFont.systemFont(ofSize: 17.0)
  public var labelColor: UIColor = UIColor.white

  // Layer-Configuration
  public var layerColor: UIColor = UIColor.black
  public var layerAlpha: CGFloat = 0.5

  // Call-To-Action Configuration
  public var ctaBackgroundColor: UIColor = UIColor.orange
  public var ctaForegroundColor: UIColor = UIColor.white

  // Skip & Continue Settings
  public var showSkipButton: Bool = false
  public var showContinueButton: Bool = false
  public var tapContinuesTutorial: Bool = true
}
