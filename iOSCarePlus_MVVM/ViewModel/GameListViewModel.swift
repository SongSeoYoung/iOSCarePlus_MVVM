//
//  GameListViewModel.swift
//  iOSCarePlus_MVVM
//
//  Created by 송서영 on 2021/02/18.
//

import Alamofire
import Foundation

class GameListViewModel {
    var model: NewGameResponse? {
        didSet{
            print("didset")
        }
    }
    
    var newCount: Int = 10
    var newOffset: Int = 0
    var getNewGameListURL: String {
        //url 을 콜 할 때 마다 이 값을 계산해서 반환함
        //이런게 computed property
        //getter setter 존재가능인데, getter만 잇으면 get 키워드 자체를 삭제가능
         "https://ec.nintendo.com/api/KR/ko/search/new?count=\(newCount)&offset=\(newOffset)"
    }
    var gameSaleItemListURL: String {
        "https://ec.nintendo.com/api/KR/ko/search/sales?count=\(newCount)&offset=\(newOffset)"
    }
    var gameNewItemListURL: String {
        "https://ec.nintendo.com/api/KR/ko/search/new?count=\(newCount)&offset=\(newOffset)"
    }
    var isEnd: Bool = false
    //indicator를 불러야할 타이밍인지 체크하는 함수
    func isIndicatorCell(_ indexPath: IndexPath) -> Bool {
        indexPath.row == model?.contents.count
    }
    func gameListApiCall(_ url: String) {
        AF.request(url).responseJSON { [weak self] response in
            guard let data = response.data else { return }
            //request 의 결과는 response 에서 가져오는 클로저로 작업
            let decoder: JSONDecoder = JSONDecoder() //객체생성
            //newModel 은 api 에서 새로 불러온 데이터
            guard let newModel: NewGameResponse = try? decoder.decode(NewGameResponse.self, from: data) else { return }
            //NewGameResponse.self => newgameresponse 타입을 넘겨준다의 의미

            //이 api 값이 젤 처음 호출하게되는 경우라면
            if self?.model == nil {
                print("초기 model 업데이트")
                self?.model = newModel
            } else {      //그게 아니라 이전에 모델에 값이 들어있으면 append 해서 배열에 추가
                if newModel.contents.isEmpty {
                    print("더 이상 새로운 모델이 없음")
                    self?.isEnd = true
                }
                print("model 에 어팬드")
                //model?.content 라는게 배열로 이루어져있어서 앞으로 데이터를 계속 쌓아야하기에 append 해주는 형태로 구현
                self?.model?.contents.append(contentsOf: newModel.contents)
            }
        }
    }
}
