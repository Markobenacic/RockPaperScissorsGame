//
//  UIViewController+Storyboardable.swift
//  RockPaperScissors
//
//  Created by Marko Benačić on 08.01.2023..
//

import UIKit

protocol Storyboardable {
    static func create() -> Self
}

extension Storyboardable where Self: UIViewController {
    static func create() -> Self {
        // this pulls out "MyApp.MyViewController"
        let fullName = NSStringFromClass(self)
        // this splits by the dot and uses everything after, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")[1]

        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
