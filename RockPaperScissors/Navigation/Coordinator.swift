//
//  Coordinator.swift
//  RockPaperScissors
//
//  Created by Marko Benačić on 30.12.2022..
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
