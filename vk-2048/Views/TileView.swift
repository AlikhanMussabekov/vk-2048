//
// Created by Alikhan Nurlanovich on 2019-05-13.
// Copyright (c) 2019 Chainless. All rights reserved.
//

import Foundation
import UIKit

class TileView: UIView {

    var numberLabel: UILabel
    var tileModel: Tile {
        didSet {
            backgroundColor = tileModel.tileColor
            numberLabel.textColor = tileModel.textColor
            numberLabel.text = "\(tileModel.number)"
        }
    }

    init(tileModel: Tile){
        self.numberLabel = UILabel(frame: CGRect(origin: .zero, size: tileModel.frame.size))
        self.tileModel = tileModel
        super.init(frame: tileModel.frame)

        backgroundColor = tileModel.tileColor
        numberLabel.textColor = tileModel.textColor
        numberLabel.text = "\(tileModel.number)"

        self.numberLabel.textAlignment = .center
        self.numberLabel.numberOfLines = 1
        self.numberLabel.font = UIFont(name: "Helvetica-Bold", size: self.frame.height * 2 / 3)
        self.numberLabel.minimumScaleFactor = 1 / self.numberLabel.font.pointSize
        self.numberLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(numberLabel)
        self.layer.cornerRadius = 6

    }

    required init(coder: NSCoder){
        fatalError("NSCoding not supported")
    }
}
