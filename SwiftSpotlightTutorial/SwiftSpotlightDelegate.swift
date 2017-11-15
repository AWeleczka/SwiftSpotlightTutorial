//
// SwiftSpotlightTutorial
// (c) 2017 Alexander Weleczka
//
// https://AWeleczka.de/swift/SwiftSpotlightTutorial/
// https://github.com/AWeleczka/SwiftSpotlightTutorial/
//

import UIKit

public protocol SwiftSpotlightDelegate: class {

  /// Fired when the tutorial is added to the presenting view
  func spotlightWillAppear(spotlight: SwiftSpotlightView)

  /// Fired when the tutorial is removed form the presenting view
  func spotlightWillDisappear(spotlight: SwiftSpotlightView)

  /// Fired when the tutorial navigates to another view
  func spotlightDidNavigate(spotlight: SwiftSpotlightView, index: Int)

  /// Fired when the "Continue"-Button in the tutorial is tapped
  func spotlightDidContinue(spotlight: SwiftSpotlightView, form: SwiftSpotlightItem?, to: SwiftSpotlightItem?)

  /// Fired when the "Skip"-Button in the tutorial is tapped
  func spotlightDidSkip(spotlight: SwiftSpotlightView, form: SwiftSpotlightItem)
}

extension SwiftSpotlightDelegate {
  func spotlightWillAppear(spotlight: SwiftSpotlightView) {}
  func spotlightWillDisappear(spotlight: SwiftSpotlightView) {}
  func spotlightDidNavigate(spotlight: SwiftSpotlightView, index: Int) {}
  func spotlightDidContinue(spotlight: SwiftSpotlightView, form: SwiftSpotlightItem?, to: SwiftSpotlightItem?) {}
  func spotlightDidSkip(spotlight: SwiftSpotlightView, form: SwiftSpotlightItem) {}
}
