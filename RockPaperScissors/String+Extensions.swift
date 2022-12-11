//
//  String+Extensions.swift
//  RockPaperScissors
//
//  Created by Marko Benačić on 11.12.2022..
//

import Foundation
import UIKit

public extension String {
    func image() -> UIImage? {
        let size = CGSize(width: 40, height: 40)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
//        UIColor.white.set()
        UIColor.white.withAlphaComponent(0.0).set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        (self as AnyObject).draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: 40)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
