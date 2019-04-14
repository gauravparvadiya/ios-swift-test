//
//  Coordinator.swift
//  TestApp
//
//  Created by Gaurav Parvadiya on 2019-04-13.
//  Copyright © 2019 AlayaCare. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator {
    func start()
}

extension Coordinator {
    func show(viewController: UIViewController, window: inout UIWindow, shouldNavigate: Bool = false) {
        if shouldNavigate,
            let navigationController = window.getVisibleNavigationController() as? UINavigationController {
            navigationController.pushViewController(viewController, animated: true)
        }
        else {
            window.rootViewController = viewController
        }
    }
    
    func present(viewController: UIViewController, window: inout UIWindow) {
        let vc = window.visibleViewController()
        vc?.present(viewController, animated: true)
    }
}
