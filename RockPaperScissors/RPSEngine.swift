//
//  RPSEngine.swift
//  RockPaperScissors
//
//  Created by Marko Benačić on 09.12.2022..
//

import Foundation

class RPSEngine {

    //movement speed isnt one source of truth, make a settings singleton?
    private let movementSpeed: CGFloat = 1

    private let rpsCreatures: [RPSCreature]

    public var delegate: RPSEngineDelegate?

    private let maxX: CGFloat
    private let maxY: CGFloat

    init(maxX: CGFloat, maxY: CGFloat, rpsCreatures: [RPSCreature] ) {
        self.maxX = maxX
        self.maxY = maxY
        self.rpsCreatures = rpsCreatures

    }

    //game loop timer
    private var timer: Timer?

    func startGame() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { [weak self] _ in
            self?.update()
        }

    }

    func stopTimer() {
      timer?.invalidate()
      timer = nil
    }


    func update() {
        // for each creature figure out where it will go:
        // find closest creature you can eat and go 1 step in their direction
        // if there is nothing you can eat, move random
        // if you touched a creature: if it beats you: change type, if it doesnt: do nothing
        for creature in rpsCreatures {
            if let closestFood = findClosestFoodTo(creature) {
                creature.moveTo(creature: closestFood)
                if distanceBetween(first: creature, second: closestFood) < 10.0 {
                    closestFood.type = creature.type
                    playSound(creature.type.asString)
                    delegate?.updateCreature(closestFood)
                }
            } else {
                creature.moveRandom()
            }

            if creature.position.x > maxX {
                creature.position.x = creature.position.x - movementSpeed
            } else if creature.position.x < 0 {
                creature.position.x = creature.position.x + movementSpeed
            }
            if creature.position.y > maxY {
                creature.position.y = creature.position.y - movementSpeed
            } else if creature.position.y < 0 {
                creature.position.y = creature.position.y + movementSpeed
            }

        }
        delegate?.updateCreatures(with: rpsCreatures)

        if let winner = checkIfCreaturesAreSameAndReturnType() {
            endGame(winner: winner)
        }

    }

    public func endGame(winner: RPSCreatureType) {
        stopTimer()
        delegate?.gameEnded(winner: winner)
    }

}

public protocol RPSEngineDelegate {
    func updateCreatures(with creatures: [RPSCreature])
    func gameEnded(winner: RPSCreatureType)
    func updateCreature(_ creature: RPSCreature)
}

// MARK: - game helper functions
extension RPSEngine {

    private func checkIfCreaturesAreSameAndReturnType() -> RPSCreatureType? {
          guard !rpsCreatures.isEmpty else { return nil }

          let firstElementTypeValue = (rpsCreatures.first)?.type
          for element in rpsCreatures {
            if element.type != firstElementTypeValue {
              return nil
            }
          }

          return firstElementTypeValue
    }

    //returns closest food, if there is no food return nil
    private func findClosestFoodTo(_ creature: RPSCreature) -> RPSCreature?{
        guard thereIsFood(for: creature) else { return nil }

        guard var closestTemp = rpsCreatures.first(where: { rpsCreature in
            creature.eats(other: rpsCreature)
        }) else { return nil }

        for rpsCreature in rpsCreatures {
            if rpsCreature !== creature && creature.eats(other: rpsCreature){
                if distanceBetween(first: creature, second: rpsCreature) < distanceBetween(first: creature, second: closestTemp) {
                    closestTemp = rpsCreature
                }
            }
        }

        return closestTemp
    }

    // please write this function better
    func thereIsFood(for creature: RPSCreature) -> Bool {
        switch creature.type {
        case .rock:
            for c in rpsCreatures {
                if c.type == .scissors {return true}
            }
            return false
        case .paper:
            for c in rpsCreatures {
                if c.type == .rock {return true}
            }
            return false
        case .scissors:
            for c in rpsCreatures {
                if c.type == .paper {return true}
            }
            return false
        }
    }

    private func distanceBetween(first: RPSCreature, second: RPSCreature) -> CGFloat{

        let difX = first.position.x - second.position.x
        let difY = first.position.y - second.position.y

        return sqrt(difX*difX + difY*difY)


    }
}
