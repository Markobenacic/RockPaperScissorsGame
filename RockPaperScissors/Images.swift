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

    static func image(type: RPSCreatureType) ->  UIImage? {
        switch type {
        case .rock:
            return Images.image(name: "cloud.fill")
        case .paper:
            return Images.image(name: "paperplane.fill")
        case .scissors:
            return Images.image(name: "scissors")
        }
    }
}
