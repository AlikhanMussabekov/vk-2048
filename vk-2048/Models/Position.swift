//
// Created by Alikhan Nurlanovich on 2019-05-13.
// Copyright (c) 2019 Chainless. All rights reserved.
//

import Foundation

struct Position {
    var x, y: Int

    init(_ x: Int, _ y: Int) {
        (self.x, self.y) = (x, y)
    }
}

extension Position: Equatable{
    static func ==(lhs: Position, rhs: Position) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}