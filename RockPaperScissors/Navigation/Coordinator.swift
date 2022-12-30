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

protocol Storyboarded {
    static func create() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func create() -> Self {
        // this pulls out "MyApp.MyViewController"
        let fullName = NSStringFromClass(self)
        // this splits by the dot and uses everything after, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")[1]

        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}

