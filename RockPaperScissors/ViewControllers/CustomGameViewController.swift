//
//  CustomGameViewController.swift
//  RockPaperScissors
//
//  Created by Marko Benačić on 08.01.2023..
//

import UIKit
import SnapKit

class CustomGameViewController: UIViewController, Storyboardable {
    weak var coordinator: MainCoordinator?

    // MARK: - Views
    private var gameContainerView: UIView = UIView()
    private let startGameButton = UIButton(type: .system)
    private let newGameButton = UIButton(type: .system)
    private var creatureViews: [UIImageView] = []
    private var winnerLabel = UILabel()

    private var creatures: [RPSCreature]?
    private var engine: RPSEngine?

    private var gameState: CustomGameState = .choosingCreatures

    // MARK: - choosing creatures views
    private var choosingPlayerLabel = UILabel()
    private var scissorsEmojiView = EmojiView(type: .scissors)
    private var rockEmojiView = EmojiView(type: .rock)
    private var paperEmojiView = EmojiView(type: .paper)
    private var emojisStack = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUIForChoosingCreatures()
        setupListeners()
    }

    private func setupUIForChoosingCreatures() {
        gameContainerView = UIView()
        view.addSubview(gameContainerView)
        gameContainerView.backgroundColor = .white
        gameContainerView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }

        emojisStack.axis = .horizontal

        emojisStack.distribution = .fill

        rockEmojiView.snp.makeConstraints { make in
            make.width.height.equalTo(60)
        }
        scissorsEmojiView.snp.makeConstraints { make in
            make.width.height.equalTo(60)
        }
        paperEmojiView.snp.makeConstraints { make in
            make.width.height.equalTo(60)
        }

        choosingPlayerLabel.text = "Player 1 choosing:"
        gameContainerView.addSubview(choosingPlayerLabel)
        emojisStack.addArrangedSubview(rockEmojiView)
        emojisStack.addArrangedSubview(scissorsEmojiView)
        emojisStack.addArrangedSubview(paperEmojiView)
        gameContainerView.addSubview(emojisStack)

        choosingPlayerLabel.snp.makeConstraints { make in
            make.width.equalTo(180)
            make.top.equalTo(view.safeAreaInsets.top).offset(80)
            make.centerX.equalToSuperview()
        }

        emojisStack.snp.makeConstraints { make in
            make.top.equalTo(choosingPlayerLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }


    }

    private func setupUIForSettingCreatures() {

    }

    private func setupUIForStartingTheGame() {

    }

    private func setupListeners() {

    }

}

enum CustomGameState {
    case choosingCreatures
    case settingCreatures
    case readyToStart
}
