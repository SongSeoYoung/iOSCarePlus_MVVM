//
//  GameListViewModel.swift
//  iOSCarePlus_MVVM
//
//  Created by 송서영 on 2021/02/18.
//

import Alamofire
import Foundation

protocol GameListViewModelDelegate: AnyObject {
    func tableViewudpate()
}
class GameListViewModel {
    weak var delegate: GameListViewModelDelegate?
    
    var model: NewGameResponse? {
        didSet {
            delegate?.tableViewudpate()
        }
    }
    var flag: Bool = false
    var newCount: Int = 10
    var newOffset: Int = 0
    var getNewGameListURL: String {
         "https://ec.nintendo.com/api/KR/ko/search/new?count=\(newCount)&offset=\(newOffset)"
    }
    var gameSaleItemListURL: String {
        "https://ec.nintendo.com/api/KR/ko/search/sales?count=\(newCount)&offset=\(newOffset)"
    }
    var gameNewItemListURL: String {
        "https://ec.nintendo.com/api/KR/ko/search/new?count=\(newCount)&offset=\(newOffset)"
    }
    var isEnd: Bool = false
    func isIndicatorCell(_ indexPath: IndexPath) -> Bool {
        indexPath.row == model?.contents.count
    }
    func gameListApiCall(_ url: String) {
        AF.request(url).responseJSON { [weak self] response in
            guard let data = response.data else { return }
            let decoder: JSONDecoder = JSONDecoder()
            guard let newModel: NewGameResponse = try? decoder.decode(NewGameResponse.self, from: data) else { return }
            
            if self?.model == nil {
                self?.model = newModel
            } else {
                if newModel.contents.isEmpty {
                    self?.isEnd = true
                }
                self?.model?.contents.append(contentsOf: newModel.contents)
            }
        }
    }
}
