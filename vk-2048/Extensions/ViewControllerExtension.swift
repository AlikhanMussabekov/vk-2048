//
// Created by Alikhan Nurlanovich on 2019-05-11.
// Copyright (c) 2019 Chainless. All rights reserved.
//

import Foundation
import UIKit

extension ViewController {

    func setupGestures(){
        let left = UISwipeGestureRecognizer(target: self, action: #selector(swipedLeft))
        left.direction = .left
        let right = UISwipeGestureRecognizer(target: self, action: #selector(swipedRight))
        right.direction = .right
        let up = UISwipeGestureRecognizer(target: self, action: #selector(swipedUp))
        up.direction = .up
        let down = UISwipeGestureRecognizer(target: self, action: #selector(swipedDown))
        down.direction = .down

        self.view.addGestureRecognizer(left)
        self.view.addGestureRecognizer(right)
        self.view.addGestureRecognizer(up)
        self.view.addGestureRecognizer(down)
    }

    @objc func swipedLeft() {
        gameLogicService.move(direction: .left)
    }

    @objc func swipedRight() {
        gameLogicService.move(direction: .right)
    }

    @objc func swipedUp() {
        gameLogicService.move(direction: .up)
    }

    @objc func swipedDown() {
        gameLogicService.move(direction: .down)
    }

}