//
//  ViewControllerExtension.swift
//  vk-2048
//
//  Created by Alikhan Nurlanovich on 2019-05-08.
//  Copyright © 2019 Chainless. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

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
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 0.0
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 8.0

        button.contentEdgeInsets = UIEdgeInsets(top: 10,left: 15,bottom: 10,right: 15)

        button.addTarget(self, action: #selector(restartGame), for: .touchUpInside)

        return button
    }()

    var dimension : Int {
        return 4
    }

    var padding : Int {
        return 8
    }

    var maxVal : Int {
        return 2048
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }

    fileprivate func setupViews(){

        view.backgroundColor = .MAIN_VIEW_BACKGROUND_COLOR

        view.addSubview(restartButton)

        restartButton.anchor(
                top: nil,
                leading: nil,
                bottom: view.safeAreaLayoutGuide.bottomAnchor,
                trailing: nil,
                padding: .init(top: 0, left: 0, bottom: -24, right: 0)
        )
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

}
