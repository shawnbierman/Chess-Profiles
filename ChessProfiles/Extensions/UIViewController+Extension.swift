//
//  UIViewController+Extension.swift
//  ChessProfiles
//
//  Created by Shawn Bierman on 9/13/20.
//  Copyright © 2020 Shawn Bierman. All rights reserved.
//

import UIKit

@nonobjc  // do not interfere with Apple code
extension UIViewController {

    func add(_ child: UIViewController, frame: CGRect? = nil) {

        addChild(child)

        if let frame = frame {
            child.view.frame = frame
        }

        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {

        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else { return }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
