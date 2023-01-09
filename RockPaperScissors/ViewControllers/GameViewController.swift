//
//  ViewController.swift
//  RockPaperScissors
//
//  Created by Marko Benačić on 08.12.2022..
//

import UIKit
import SnapKit

// TODO: settings class, button to end game, option to add creatures with a tap
class GameViewController: UIViewController, Storyboardable {
    weak var coordinator: MainCoordinator?

    // MARK: - Views
    private var gameContainerView: UIView = UIView()
    private let startGameButton = UIButton(type: .system)
    private let newGameButton = UIButton(type: .system)
    private var creatureViews: [UIImageView] = []
    private var winnerLabel = UILabel()

    private var creatures: [RPSCreature]?
    private var engine: RPSEngine?

    override func viewDidLoad() {
        super.viewDidLoad()
        creatures = createRandomCreatures(maxX: view.frame.maxX, minY: 200 , maxY: view.frame.maxY - 200)

        if let creatures {
            engine = RPSEngine(maxX: view.frame.maxX, maxY: view.frame.maxY, rpsCreatures: creatures)
        }
        engine?.delegate = self
        setupUI()
        setupListeners()
    }

    private func setupListeners() {
        startGameButton.addTarget(self, action: #selector(startGameTapped), for: .touchUpInside)
        newGameButton.addTarget(self, action: #selector(newGameTapped), for: .touchUpInside)
    }

    @objc func startGameTapped() {
        startGameButton.removeFromSuperview()
        engine?.startGame()
    }

    @objc func newGameTapped() {
        creatures = createRandomCreatures(maxX: view.frame.maxX, minY: 200 , maxY: view.frame.maxY - 200)

        if let creatures {
            engine = RPSEngine(maxX: view.frame.maxX, maxY: view.frame.maxY, rpsCreatures: creatures)
        }

        engine?.delegate = self
        setupUI()
        
    }

    private func setupUI() {
        setupGameContainerViewUI()
        setupStartGameButton()
        updateRpsCreaturesUI()
    }

    private func updateRpsCreaturesUI() {
        gameContainerView.subviews.forEach { subview in
            subview.removeFromSuperview()
        }
        creatureViews.removeAll()

        creatures?.forEach({ creature in
            //postavi sliku
            //stavi ga u gameContainerView
            //postavi poziciju
            let creatureView = UIImageView(image: Images.imageFrom(emoji: creature.type.emoji))
            creatureView.tag = creature.id
            creatureViews.append(creatureView)
            gameContainerView.addSubview(creatureView)
            creatureView.frame = CGRect(origin: creature.position, size: Constants.creatureSize)
        })
    }

    private func setupGameContainerViewUI() {
        gameContainerView.removeFromSuperview()
        gameContainerView = UIView()
        view.addSubview(gameContainerView)
        gameContainerView.backgroundColor = .white
        gameContainerView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }

    private func setupStartGameButton() {
        startGameButton.setTitle("Start game", for: .normal)
        startGameButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        startGameButton.layer.cornerRadius = 15
        startGameButton.backgroundColor = .blue
        startGameButton.setTitleColor(.white, for: .normal)

        view.addSubview(startGameButton)

        startGameButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startGameButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            startGameButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            startGameButton.widthAnchor.constraint(equalToConstant: 120)
        ])
    }

    private func setupGameEndedUI(winner: RPSCreatureType) {
        let confettiView = ConfettiView(frame: view.frame, type: winner)
//        gameContainerView.subviews.forEach { $0.removeFromSuperview() }
        gameContainerView.addSubview(confettiView)

        confettiView.layer.opacity = 0.3

        newGameButton.setTitle("New Game", for: .normal)
        newGameButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        newGameButton.layer.cornerRadius = 15
        newGameButton.backgroundColor = .blue
        newGameButton.setTitleColor(.white, for: .normal)

        gameContainerView.addSubview(newGameButton)

        newGameButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newGameButton.centerXAnchor.constraint(equalTo: self.gameContainerView.centerXAnchor),
            newGameButton.bottomAnchor.constraint(equalTo: self.gameContainerView.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            newGameButton.widthAnchor.constraint(equalToConstant: 120)
        ])


        winnerLabel.text = "\(winner.asString) wins!!"
        winnerLabel.textColor = .orange
        winnerLabel.font = UIFont.boldSystemFont(ofSize: 36)
        winnerLabel.textAlignment = .center
        winnerLabel.translatesAutoresizingMaskIntoConstraints = false

        gameContainerView.addSubview(winnerLabel)
        NSLayoutConstraint.activate([
            winnerLabel.centerXAnchor.constraint(equalTo: self.gameContainerView.centerXAnchor),
            winnerLabel.topAnchor.constraint(equalTo: self.gameContainerView.topAnchor, constant: 60),
            //winnerLabel.widthAnchor.constraint(equalToConstant: 120)
        ])

    }
}

// MARK: - helper functions
extension GameViewController {
    func createRandomCreatures(maxX: CGFloat, minY: CGFloat, maxY: CGFloat) -> [RPSCreature] {
        var creatures: [RPSCreature] = []
        for _ in 1...15 {
            let x = CGFloat.random(in: 0...maxX)
            let y = CGFloat.random(in: minY...maxY)

            creatures.append(RPSCreature(type: .paper, position: CGPoint(x: x, y: y)))
        }

        for _ in 1...15 {
            let x = CGFloat.random(in: 0...maxX)
            let y = CGFloat.random(in: minY...maxY)

            creatures.append(RPSCreature(type: .rock, position: CGPoint(x: x, y: y)))
        }

        for _ in 1...15 {
            let x = CGFloat.random(in: 0...maxX)
            let y = CGFloat.random(in: minY...maxY)

            creatures.append(RPSCreature(type: .scissors, position: CGPoint(x: x, y: y)))
        }

        return creatures
    }
}

extension GameViewController: RPSEngineDelegate {
    func updateCreature(_ creature: RPSCreature) {
        let viewToChange = gameContainerView.viewWithTag(creature.id)
        viewToChange?.removeFromSuperview()

        let creatureView = UIImageView(image: Images.image(type: creature.type))
        creatureView.tintColor = .black
        creatureView.tag = creature.id
        creatureViews.append(creatureView)
        gameContainerView.addSubview(creatureView)
        creatureView.frame = CGRect(origin: creature.position, size: Constants.creatureSize)

    }

    func updateCreatures(with creatures: [RPSCreature]) {
        self.creatures = creatures
        updateRpsCreaturesUI()
    }

    func gameEnded(winner: RPSCreatureType) {
        setupGameEndedUI(winner: winner)
        playSound("Victory_Sound")
    }

}
