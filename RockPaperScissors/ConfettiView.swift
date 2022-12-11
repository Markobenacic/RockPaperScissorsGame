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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

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

        for color in colors {
            let cell = CAEmitterCell()
            cell.contents = UIImage(named: "confetti")!.cgImage
            cell.birthRate = 6
            cell.lifetime = 14
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
