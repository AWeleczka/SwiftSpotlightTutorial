//
// SwiftSpotlightTutorial
// (c) 2017 Alexander Weleczka
//
// https://AWeleczka.de/swift/SwiftSpotlightTutorial/
// https://github.com/AWeleczka/SwiftSpotlightTutorial/
//

import UIKit

public protocol SwiftSpotlightDelegate: class {
  func spotlightWillAppear(spotlight: SwiftSpotlightView)
  func spotlightWillDisappear(spotlight: SwiftSpotlightView)
  func spotlightDidContinue(spotlight: SwiftSpotlightView, form: SwiftSpotlightItem?, to: SwiftSpotlightItem?)
  func spotlightDidSkip(spotlight: SwiftSpotlightView, form: SwiftSpotlightItem)
}
