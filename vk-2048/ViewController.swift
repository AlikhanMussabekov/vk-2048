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
    
    var victoryView: UIVisualEffectView!
    
    let restartButton: RestartButton = RestartButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .MAIN_VIEW_BACKGROUND_COLOR
        
        setupViews()
        setupGestures()
        setupGame()
        startGame()
    }

    private func startGame(){
        gameLogicService.start()
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

        restartButton.alpha = 0
        restartButton.anchor(
                top: nil,
                leading: nil,
                bottom: view.bottomAnchor,
                trailing: nil,
                padding: .init(top: 0, left: 0, bottom: -40, right: 0))
        restartButton.centerInSuperview(centerX: view.centerXAnchor, centerY: nil)
        restartButton.addTarget(self, action: #selector(restartGameButtonTapped), for: .touchUpInside)
    }

    @objc private func restartGameButtonTapped(){
        
        restart()
        setupGestures()
        UIView.animate(
            withDuration: 1,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseIn,
            animations: {
                self.restartButton.alpha = 0
            }
        )
        
    }

    private func clearSubviews() {
        self.view.subviews.forEach({ $0.removeFromSuperview() })
    }

    private func restart(){
        tileAppearanceService.reset()
        gameLogicService.removeTiles()
        gameLogicService.start()
    }
}


extension ViewController: GameLogicServiceDelegate {
    func showVictory() {

        removeGestures()
    
        let blurEffect = UIBlurEffect(style: .dark)
        victoryView = UIVisualEffectView(effect: blurEffect)
        
        let victoryImageView = UIImageView(image: UIImage(named: "victory"))
        let victoryRestartButton = RestartButton()
        let victoryLabel: UILabel = {
            let label = UILabel()
            label.text = "Поздравляю!\nВы собрали \(maxVal)"
            label.font = .boldSystemFont(ofSize: 28)
            label.textColor = .white
            label.numberOfLines = 0
            label.textAlignment = .center
            return label
        }()
        
        view.addSubview(victoryView)
        victoryView.fillSuperView()
        
        victoryView.contentView.addSubview(victoryImageView)
        victoryView.contentView.addSubview(victoryLabel)
        victoryView.contentView.addSubview(victoryRestartButton)
        
        victoryImageView.centerInSuperview(
            centerX: victoryView.centerXAnchor,
            centerY: victoryView.centerYAnchor,
            size: .init(width: 200, height: 200)
        )
        
        victoryLabel.anchor(
            top: nil,
            leading: nil,
            bottom: victoryImageView.topAnchor,
            trailing: nil,
            padding: .init(top: 0, left: 8, bottom: -40, right: 8)
        )
        
        victoryLabel.centerInSuperview(
            centerX: victoryView.centerXAnchor,
            centerY: nil
        )
        
        
        victoryRestartButton.anchor(
            top: nil,
            leading: nil,
            bottom: victoryView.bottomAnchor,
            trailing: nil,
            padding: .init(top: 0, left: 0, bottom: -40, right: 0)
        )
        victoryRestartButton.centerInSuperview(centerX: victoryView.centerXAnchor, centerY: nil)
        victoryRestartButton.addTarget(self, action: #selector(victoryRestartButtonTapped), for: .touchUpInside)
        
        victoryView.alpha = 0
        
        UIView.animate(
            withDuration: 1,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseIn,
            animations: {
                self.victoryView.alpha = 1
            })
        
    }

    @objc func victoryRestartButtonTapped(){
        setupGestures()
        restart()
        UIView.animate(
            withDuration: 1,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseIn,
            animations: {
                self.victoryView.alpha = 0
            },
            completion: {
                finished in
                if (finished){
                    self.victoryView.removeFromSuperview()
                }
            }
        )
    }
    
    func showDefeat() {
        removeGestures()
        UIView.animate(
            withDuration: 1,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseOut,
            animations: {
                self.restartButton.alpha = 1.0
            }
        )
    }
}
