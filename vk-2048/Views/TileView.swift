//
// Created by Alikhan Nurlanovich on 2019-05-13.
// Copyright (c) 2019 Chainless. All rights reserved.
//

import Foundation
import UIKit

class TileView: UIView {

    let numberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    var tileModel: Tile? {
        didSet {
            setColors()
        }
    }

    init(tileModel: Tile? = nil, frame: CGRect) {
        self.tileModel = tileModel
        super.init(frame: frame)

        self.layer.cornerRadius = 6

        setNumberLabel()
        setColors()
    }

    private func setNumberLabel () {
        numberLabel.font = .boldSystemFont(ofSize: self.frame.height / 2)
        numberLabel.minimumScaleFactor = 1 / self.numberLabel.font.pointSize

        self.addSubview(numberLabel)
        numberLabel.fillSuperView()
    }

    private func setColors() {

        self.backgroundColor = tileModel?.tileColor
        self.numberLabel.textColor = tileModel?.textColor
        self.numberLabel.isHidden = false

        guard let number = tileModel?.number else {return}
        self.numberLabel.text = "\(number)"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("coder isn't allowed")
    }
}