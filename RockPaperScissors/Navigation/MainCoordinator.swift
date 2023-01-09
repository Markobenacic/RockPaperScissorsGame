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
        let vc = MainMenuViewController.create()
        vc.coordinator = self
//        let vc = GameViewController.create()
        navigationController.pushViewController(vc, animated: false)
    }

    func newRandomGame() {
        let vc = GameViewController.create()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }

    func newCustomGame() {
        let vc = CustomGameViewController.create()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }

    func settings() {

    }
}
