//
//  GameItemCellViewModel.swift
//  iOSCarePlus_MVVM
//
//  Created by 송서영 on 2021/02/18.
//

import Foundation

class GameItemCellViewModel {
    
    private var model: GameItemModel? {
        //model 값이 바귀면 진행되도록
        didSet {
//            setUIFromModel()
        }
    }
    func setModel(_ model: GameItemModel) {
        self.model = model
    }
    
//    func setUIFromModel() {
//        guard let model = model else { return }
//        let imageURL: URL? = URL(string: model.imageURL)
//        let borderColor: CGColor? = UIColor(red: 236 / 255.0, green: 236 / 255.0, blue: 236 / 255.0, alpha: 1).cgColor
//        //rgb 는 0~1사이 값을 받기 대문에 우리가원하는 값을 소수점으로 나눠서 표현함
//        gameImageView.kf.setImage(with: imageURL)
//        gameImageView.layer.cornerRadius = 9
//        gameImageView.layer.borderWidth = 1
//        gameImageView.layer.borderColor = borderColor
//        gameTitleLabel.text = model.gameTitle
//        if let discountPrice: Int = model.gameDiscountPrice {
//            gameCurrentPrice.text = "\(discountPrice)"
//            gameOriginPrice.text = "\(model.gameOriginPrice)"
//        } else {
//            gameCurrentPrice.text = "\(model.gameOriginPrice)"
//            gameOriginPrice.isHidden = true
//        }
//    }
}
