//
//  AppTabBarController.swift
//  EcoSoapBank
//
//  Created by Jon Bash on 2020-09-02.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit


class AppTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        configure(BackgroundView()) {
            view.constrainNewSubviewToSides($0)
            view.sendSubviewToBack($0)
        }
    }

    /// Recursively dismisses any view controllers currently being presented
    func dismissAllPresentedViewControllers(onComplete: (() -> Void)?) {
        if presentedViewController != nil {
            dismiss(animated: true) {
                self.dismissAllPresentedViewControllers(onComplete: onComplete)
            }
        }
        onComplete?()
    }
}
