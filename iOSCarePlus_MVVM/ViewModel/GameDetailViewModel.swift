//
//  GameDetailViewModel.swift
//  iOSCarePlus_MVVM
//
//  Created by 송서영 on 2021/02/19.
//

import UIKit

class GameDetailViewModel {
    var model: NewGameContent?
    func setModel(of content: NewGameContent) {
        self.model = content
    }
    func getModel() -> NewGameContent? {
        return model
    }
}
