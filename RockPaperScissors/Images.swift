//
//  Images.swift
//  RockPaperScissors
//
//  Created by Marko Benačić on 08.12.2022..
//

import Foundation
import UIKit

public class Images {
    static func image(name: String) -> UIImage? {
            return UIImage(systemName: name)
        }

    public var scissors: UIImage? {
        return Images.image(name: "scissors")
    }

    public var rock: UIImage? {
        return Images.image(name: "rock")
    }

    public var paper: UIImage? {
        return Images.image(name: "paper")
    }
}
