//
//  Creature.swift
//  RockPaperScissors
//
//  Created by Marko Benačić on 09.12.2022..
//

import Foundation

public class RPSCreature: Identifiable {
    let movementSpeed = 1.0

    public let id = UUID().uuidString.hash
    var type: RPSCreatureType
    var position: CGPoint

    init(type: RPSCreatureType, position: CGPoint) {
        self.type = type
        self.position = position
    }

    func eats(other: RPSCreature) -> Bool {
        switch type {
        case .rock:
            if other.type == .scissors {return true}
            else {return false}
        case .paper:
            if other.type == .rock {return true}
            else {return false}
        case .scissors:
            if other.type == .paper {return true}
            else {return false}
        }
    }

    func moveTo(creature: RPSCreature) {
        // to add some randomness to movement
        let random = Int.random(in: 0...1)

        if random == 0 {
            let stepX = (position.x - creature.position.x) < 0 ? movementSpeed : -movementSpeed
            position.x = position.x + stepX
        } else {
            let stepY = (position.y - creature.position.y) < 0 ? movementSpeed : -movementSpeed
            position.y = position.y + stepY
        }

    }

    func moveRandom() {
        let multiplierX = Double(Int.random(in: -1...1))
        let multiplierY = Double(Int.random(in: -1...1))

        position.x = multiplierX * movementSpeed

        position.y = multiplierY * movementSpeed

    }

}


enum RPSCreatureType {
    case rock
    case paper
    case scissors
}
