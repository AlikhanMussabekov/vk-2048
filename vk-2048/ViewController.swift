//
//  ViewControllerExtension.swift
//  vk-2048
//
//  Created by Alikhan Nurlanovich on 2019-05-08.
//  Copyright © 2019 Chainless. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    let dimension: Int = GameConfig.DIMENSION
    let padding: CGFloat = GameConfig.PADDING
    let maxVal: Int = GameConfig.MAX_VALUE

    var board: Board!
    var gameLogicService: GameLogicService!
    var tileAppearanceService: TileAppearanceService!

    //TODO persistence tiles
    var tiles = [Tile]()

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
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 2.0
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 8.0
        button.contentEdgeInsets = UIEdgeInsets(top: 10,left: 15,bottom: 10,right: 15)

        button.addTarget(self, action: #selector(restartGameButtonTapped), for: .touchUpInside)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .MAIN_VIEW_BACKGROUND_COLOR

        setupViews()
        setupGestures()
        setupGame()
        startGame()
    }

    private func startGame(){
        gameLogicService.start(with: tiles)
    }

    private func setupGame(){
        gameLogicService = GameLogicService()
        tileAppearanceService = TileAppearanceService(board: board)

        gameLogicService.gameLogicDelegate = self
        gameLogicService.tileAppearanceDelegate = tileAppearanceService
    }

    private func setupViews(){

        self.clearSubviews()

        let sideLength = self.view.frame.width - padding * 2
        let boardSize = CGSize(width: sideLength, height: sideLength)
        board = Board(boardSize: boardSize)

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

    @objc private func restartGameButtonTapped(){
        let alert = UIAlertController(title: "Начать новую игру?", message: "Текущие результаты будут утеряны", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { _ in
            self.restart()
        }))
        alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    private func clearSubviews() {
        self.view.subviews.forEach({ $0.removeFromSuperview() })
    }

    private func restart(){
        self.tileAppearanceService.reset()
        self.gameLogicService.start()
    }
}


extension ViewController: GameLogicServiceDelegate {
    func showVictory() {
        let alert = UIAlertController(title: "Победа", message: "победа", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Начать заново", style: .default, handler: { _ in
            self.restart()
        }))
        self.present(alert, animated: true, completion: nil)
    }

    func showDefeat() {
        let alert = UIAlertController(title: "Проигрыш", message: "проигрыш", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Начать заново", style: .default, handler: { _ in
            self.restart()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}