//
//  MainMenuButton.swift
//  RockPaperScissors
//
//  Created by Marko Benačić on 30.12.2022..
//

import UIKit

class MainMenuButton: UIButton {
    init() {
        super.init(frame: .zero)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        backgroundColor = .systemBlue
        tintColor = .white
        sizeToFit()

        // Round the corners and add a shadow
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }


}
