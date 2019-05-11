//
// Created by Alikhan Nurlanovich on 2019-05-11.
// Copyright (c) 2019 Chainless. All rights reserved.
//

import Foundation
import UIKit

struct Tile{
    var number: Int{
        didSet {
            color = AppearanceService.colorOfNumber(number: number)
        }
    }
    var color = UIColor.TILE_EMPTY
}