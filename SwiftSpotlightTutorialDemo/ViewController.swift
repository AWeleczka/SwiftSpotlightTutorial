import UIKit
import SwiftSpotlightTutorial

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var spinnner: UIActivityIndicatorView!
    @IBOutlet weak var button: UIButton!

    private var spotlightview = SwiftSpotlightView()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let spotlights = [
            SwiftSpotlightItem(
                target: self.label.frame,
                shape: .rectangle,
                text: SwiftSpotlightText(text: "Rectangles"),
                image: nil,
                ctabutton: nil,
                margin: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5),
                radius: 5,
                allowPassthrough: false),
            SwiftSpotlightItem(
                target: self.spinnner.frame,
                shape: .circle,
                text: SwiftSpotlightText(text: "Circles"),
                image: nil,
                ctabutton: nil,
                margin: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
                radius: 0,
                allowPassthrough: false),
            SwiftSpotlightItem(
                target: self.button.frame,
                shape: .roundRectangle,
                text: SwiftSpotlightText(text: "And nicer rectangles"),
                image: SwiftSpotlightImage(image: #imageLiteral(resourceName: "Arrow_Orange_LowerRight.svg")),
                ctabutton: SwiftSportlightButton(text: "Restart", target: self, selector: #selector(ViewController.ctaTarget(_:))),
                allowPassthrough: true),
        ]

        spotlightview = SwiftSpotlightView(frame: view.frame, spotlights: spotlights)
        spotlightview.attachToController(self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        spotlightview.detach()
    }

    @objc public func ctaTarget(_ sender: UIButton) {
        print(sender.debugDescription)
        spotlightview.nextSpotlight()
    }

    @IBAction func buttonPress() {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: "https://twitter.com/AWeleczka/")!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(URL(string: "https://twitter.com/AWeleczka/")!)
        }
    }
}
