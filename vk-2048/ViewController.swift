//
//  ViewControllerExtension.swift
//  vk-2048
//
//  Created by Alikhan Nurlanovich on 2019-05-08.
//  Copyright © 2019 Chainless. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    var dimension : Int = 4
    var padding : CGFloat = 8
    var maxVal : Int = 2048
    var gameService: GameService!

    // restart button config
    let restartButton : UIButton = {
        let button = UIButton()

        let normalTitleAttributedString = NSAttributedString(
                string: "Попробовать ещё раз", 
                attributes: [
                    .font: UIFont.systemFont(ofSize: 13),
                    .foregroundColor: UIColor.black
                ])

        button.setAttributedTitle(normalTitleAttributedString, for: .normal)
        button.backgroundColor = .white

        button.layer.shadowColor = UIColor.BUTTON_SHADOW.cgColor
        button.layer.shadowOffset = .zero
        button.layer.shadowOpacity = 0.9
        button.layer.shadowRadius = 0.0
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 8.0
        button.contentEdgeInsets = UIEdgeInsets(top: 10,left: 15,bottom: 10,right: 15)

        button.addTarget(self, action: #selector(restartGame), for: .touchUpInside)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .MAIN_VIEW_BACKGROUND_COLOR

        setupViews()
        setupGame()
    }

    fileprivate func setupGame(){
        gameService = GameService()
        gameService.delegate = self
        gameService.sourceDelegate = self
    }

    fileprivate func setupViews(){

        // setup board size
        let board: Board = {
            let sideLength = self.view.frame.width - padding * 2
            let boardSize = CGSize(width: sideLength, height: sideLength)
            let board = Board(boardSize: boardSize)

            return board
        }()

        [board, restartButton].forEach({ view.addSubview($0) })

        board.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: .init(width: board.frame.width, height: board.frame.height))
        board.centerInSuperview(centerX: view.centerXAnchor, centerY: view.centerYAnchor)

        restartButton.anchor(
                top: nil,
                leading: nil,
                bottom: view.safeAreaLayoutGuide.bottomAnchor,
                trailing: nil,
                padding: .init(top: 0, left: 0, bottom: -24, right: 0))
        restartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    @objc fileprivate func restartGame(){
        let alert = UIAlertController(title: "Начать новую игру?", message: "Текущие результаты будут утеряны", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { _ in
            print("restart")
        }))
        alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    fileprivate func clearSubviews() {
        self.view.subviews.forEach({ $0.removeFromSuperview() })
    }

}
