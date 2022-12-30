//
//  MainCoordinator.swift
//  RockPaperScissors
//
//  Created by Marko Benačić on 30.12.2022..
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
//        let vc = MainMenuViewController.create()
        let vc = GameViewController.create()
        navigationController.pushViewController(vc, animated: false)
    }
}
