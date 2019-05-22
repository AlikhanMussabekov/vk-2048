//
// Created by Alikhan Nurlanovich on 2019-05-11.
// Copyright (c) 2019 Chainless. All rights reserved.
//

import Foundation
import UIKit

protocol AppearanceProtocol{
    static func tileColorOfNumber(number: Int?) -> UIColor
    static func textColorOfNumber(number: Int?) -> UIColor
}

class AppearanceService: AppearanceProtocol{
    static func tileColorOfNumber(number: Int?) -> UIColor {
        switch(number){
        case 2:
            return UIColor.TILE_2
        case 4:
            return UIColor.TILE_4
        case 8:
            return UIColor.TILE_8
        case 16:
            return UIColor.TILE_16
        case 32:
            return UIColor.TILE_32
        case 64:
            return UIColor.TILE_64
        case 128:
            return UIColor.TILE_128
        case 256:
            return UIColor.TILE_256
        case 512:
            return UIColor.TILE_512
        case 1024:
            return UIColor.TILE_1024
        case 2048:
            return UIColor.TILE_2048
        default :
            return UIColor.TILE_EMPTY
        }
    }

    static func textColorOfNumber(number: Int?) -> UIColor{

        guard let number = number else {return UIColor.TILE_EMPTY}

        if (number > 32){
            return .white
        }else{
            return .black
        }
    }
}