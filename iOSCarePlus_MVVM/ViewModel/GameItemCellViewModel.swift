//
//  GameItemCellViewModel.swift
//  iOSCarePlus_MVVM
//
//  Created by 송서영 on 2021/02/18.
//

import Foundation

protocol GameItemCellViewModelDelegate: AnyObject {
    func setUIFromModel()
}

class GameItemCellViewModel {
    weak var delegate: GameItemCellViewModelDelegate?
    var model: GameItemModel? {
        //model 값이 바귀면 진행되도록
        didSet {
            delegate?.setUIFromModel()
        }
    }
    func setModel(_ model: GameItemModel) {
        self.model = model
    }
}

