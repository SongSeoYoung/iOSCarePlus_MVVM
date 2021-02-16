//
//  GameItemModel.swift
//  iOSCarePlus_MVVM
//
//  Created by 송서영 on 2021/02/16.
//

import Foundation

struct GameItemModel {
    let gameTitle: String
    let gameOriginPrice: Int
    let gameDiscountPrice: Int?
    let imageURL: String
    let screenshots: [ScreenShotContent]
}
