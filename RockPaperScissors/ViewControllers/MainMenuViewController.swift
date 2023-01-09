//
//  MainMenuViewController.swift
//  RockPaperScissors
//
//  Created by Marko Benačić on 30.12.2022..
//

import UIKit
import SnapKit

class MainMenuViewController: UIViewController, Storyboardable {
    weak var coordinator: MainCoordinator?

    let randomGameButton = MainMenuButton()
    let customGameButton = MainMenuButton()
    let settingsButton = MainMenuButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupListeners()
    }

    private func setupUI() {

        customGameButton.setTitle("custom game", for: .normal)
        view.addSubview(customGameButton)
        customGameButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(240)
            make.centerX.equalToSuperview()
        }

        randomGameButton.setTitle("new random game", for: .normal)
        view.addSubview(randomGameButton)
        randomGameButton.snp.makeConstraints { make in
            make.bottom.equalTo(customGameButton.snp.top).offset(-30)
            make.height.equalTo(50)
            make.width.equalTo(240)
            make.centerX.equalToSuperview()
        }

        settingsButton.setTitle("settings", for: .normal)
        view.addSubview(settingsButton)
        settingsButton.snp.makeConstraints { make in
            make.top.equalTo(customGameButton.snp.bottom).offset(30)
            make.height.equalTo(50)
            make.width.equalTo(240)
            make.centerX.equalToSuperview()
        }

    }

    private func setupListeners() {
        randomGameButton.addTarget(self, action: #selector(randomGameTapped), for: .touchUpInside)
        customGameButton.addTarget(self, action: #selector(customGameTapped), for: .touchUpInside)
        // TODO: custom game
    }
    
    @objc func randomGameTapped() {
        coordinator?.newRandomGame()
    }

    @objc func customGameTapped() {
        coordinator?.newCustomGame()
    }


}
