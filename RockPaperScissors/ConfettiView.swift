//
//  ConfettiView.swift
//  RockPaperScissors
//
//  Created by Marko Benačić on 08.12.2022..
//

import Foundation
import UIKit

class ConfettiView: UIView {

    private var emitter: CAEmitterLayer!
    private var type: RPSCreatureType?

    init(frame: CGRect, type: RPSCreatureType) {
        self.type = type
        super.init(frame: frame)
        setup()
    }

//    override init(frame: CGRect) {
//        self.type = .scissors
//        super.init(frame: frame)
//        setup()
//    }
//
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        clipsToBounds = true
        isUserInteractionEnabled = false

        emitter = CAEmitterLayer()
        emitter.emitterPosition = CGPoint(x: center.x, y: 0)
        emitter.emitterShape = .line
        emitter.emitterSize = CGSize(width: frame.width, height: 1)

        var cells = [CAEmitterCell]()
        let colors = [UIColor.red.cgColor, UIColor.green.cgColor, UIColor.blue.cgColor]

//        let colors = [UIColor(red: 161, green: 214, blue: 123, alpha: 1).cgColor,
//                      UIColor(red: 105, green: 113, blue: 166, alpha: 1).cgColor,
//                      UIColor(red: 242, green: 213, blue: 139, alpha: 1).cgColor,
//                      UIColor(red: 219, green: 126, blue: 151, alpha: 1).cgColor]

        for color in colors {
            let cell = CAEmitterCell()
//            cell.contents = Images.image(type: type ?? .scissors)!.cgImage
            cell.contents = Images.imageFrom(emoji: type?.emoji ?? "🎉")!.cgImage
            cell.birthRate = 2
            cell.lifetime = 10
            cell.color = color
            cell.velocity = CGFloat(Int.random(in: 100...200))
            cell.velocityRange = 50
            cell.emissionLongitude = CGFloat.pi
            cell.emissionRange = CGFloat.pi / 4
            cell.spin = 3
            cell.spinRange = 3
            cell.scaleRange = 0.5
            cell.scaleSpeed = -0.05
            cells.append(cell)
        }

        emitter.emitterCells = cells
        layer.addSublayer(emitter)
    }

    func startConfetti() {
        emitter.birthRate = 1
    }

    func stopConfetti() {
        emitter.birthRate = 0
    }

}
