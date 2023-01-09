//
//  EmojiView.swift
//  RockPaperScissors
//
//  Created by Marko Benačić on 09.01.2023..
//

import UIKit
import SnapKit

class EmojiView: UIView {

    private var imageView: UIImageView = UIImageView(frame: .zero)

    override func layoutSubviews() {
        super.layoutSubviews()
        // Make the view circular
        self.layer.cornerRadius = self.frame.size.width / 2

        // Add a shadow
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.5
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    init(type: RPSCreatureType) {
        imageView = UIImageView(image: Images.image(type: type))
        imageView.contentMode = .scaleAspectFit
        super.init(frame: .zero)
        addSubview(imageView)
    }


}
