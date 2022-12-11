//
//  ViewController.swift
//  RockPaperScissors
//
//  Created by Marko Benačić on 08.12.2022..
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - constants
    public let creatureSize = CGSize(width: 20, height: 20)

    // MARK: - Views
    private let gameContainerView: UIView = UIView()
    private let startGameButton: UIButton = UIButton(type: .system)
    private var creatureViews: [UIImageView] = []

//    private var scissors: [RPSCreature]
//    private var rocks: [RPSCreature]
//    private var papers: [RPSCreature]

    private var creatures: [RPSCreature]?
    private var engine: RPSEngine?

    override func viewDidLoad() {
        super.viewDidLoad()
        addNavigationBar()
        creatures = createRandomCreatures(maxX: view.frame.maxX, maxY: view.frame.maxY)

        if let creatures {
            engine = RPSEngine(maxX: view.frame.maxX, maxY: view.frame.maxY, rpsCreatures: creatures)
        }
        engine?.delegate = self
        setupUI()
        setupListeners()

    }

    private func addNavigationBar() {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        view.addSubview(navBar)

        let navItem = UINavigationItem(title: "SomeTitle")
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
        navItem.rightBarButtonItem = doneItem

        navBar.setItems([navItem], animated: false)
    }

    private func setupListeners() {
        startGameButton.addTarget(self, action: #selector(startGameTapped), for: .touchUpInside)
    }

    @objc func startGameTapped() {
        startGameButton.removeFromSuperview()
        engine?.startGame()
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

        creatures?.forEach({ creature in
            //postavi sliku
            //stavi ga u gameContainerView
            //postavi poziciju
            let creatureView = UIImageView(image: Images.image(type: creature.type))
            creatureView.tintColor = .black
            creatureView.tag = creature.id
            creatureViews.append(creatureView)
            gameContainerView.addSubview(creatureView)
            creatureView.frame = CGRect(origin: creature.position, size: creatureSize)

        })
    }

    private func setupGameContainerViewUI() {
        view.addSubview(gameContainerView)
        gameContainerView.frame = view.bounds
        gameContainerView.backgroundColor = .white

        let safeAreaInsets = self.view.safeAreaInsets
        gameContainerView.frame = CGRect(
            x: safeAreaInsets.left,
            y: safeAreaInsets.top,
            width: self.view.frame.width - safeAreaInsets.left - safeAreaInsets.right,
            height: self.view.frame.height - safeAreaInsets.top - safeAreaInsets.bottom)

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

}

// MARK: - helper functions
extension MainViewController {
    func createRandomCreatures(maxX: CGFloat, maxY: CGFloat) -> [RPSCreature] {
        var creatures: [RPSCreature] = []
        for _ in 1...15 {
            let x = CGFloat.random(in: 0...maxX)
            let y = CGFloat.random(in: 0...maxY)

            creatures.append(RPSCreature(type: .paper, position: CGPoint(x: x, y: y)))
        }

        for _ in 1...15 {
            let x = CGFloat.random(in: 0...maxX)
            let y = CGFloat.random(in: 0...maxY)

            creatures.append(RPSCreature(type: .rock, position: CGPoint(x: x, y: y)))
        }

        for _ in 1...15 {
            let x = CGFloat.random(in: 0...maxX)
            let y = CGFloat.random(in: 0...maxY)

            creatures.append(RPSCreature(type: .scissors, position: CGPoint(x: x, y: y)))
        }

        return creatures
    }
}

extension MainViewController: RPSEngineDelegate {
    func updateCreature(_ creature: RPSCreature) {
        let viewToChange = gameContainerView.viewWithTag(creature.id)
        viewToChange?.removeFromSuperview()

        let creatureView = UIImageView(image: Images.image(type: creature.type))
        creatureView.tintColor = .black
        creatureView.tag = creature.id
        creatureViews.append(creatureView)
        gameContainerView.addSubview(creatureView)
        creatureView.frame = CGRect(origin: creature.position, size: creatureSize)

    }

    func updateCreatures(with creatures: [RPSCreature]) {
        self.creatures = creatures

        updateRpsCreaturesUI()
    }

    func gameEnded() {

        print("gotova igra")

    }


}

