//
//  NewGameResponse.swift
//  iOSCarePlus_MVVM
//
//  Created by 송서영 on 2021/02/16.
//

import Foundation

//MARK: - API 받아와서 사용할 모델
struct NewGameContent: Decodable {
    let formalName: String
    let heroBannerURL: String
    let screenshots: [ScreenShotContent]
//    let id: Int
    enum CodingKeys: String, CodingKey {
        case formalName = "formal_name"
        case heroBannerURL = "hero_banner_url"
        case screenshots
    }
}

struct ScreenShotContent: Decodable {
    let images: [ImageURL]
}

struct ImageURL: Decodable {
    let url: String
}

struct NewGameResponse: Decodable {
    var contents: [NewGameContent]
    let length: Int
    let offset: Int
    let total: Int
}
