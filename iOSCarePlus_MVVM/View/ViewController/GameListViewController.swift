//
//  GameListViewController.swift
//  iOSCarePlus_MVVM
//
//  Created by 송서영 on 2021/02/18.
//

// MARK:  ViewModel 에서 model 을 참고해도될까? 모델이 업데이트될 때 마다 테이블뷰가 리로드되는 프로퍼티옵저버를 만들어서 didSEt 일 때 업데이트되도록하는 것.

import UIKit
import RxSwift

class GameListViewController: UIViewController {
    @IBOutlet private weak var topView: UIView!
    @IBOutlet private weak var topViewTitleNameLabel: UILabel!
    @IBOutlet private weak var topViewSubNameLabel: UILabel!
    @IBOutlet private weak var topViewSubView: UIView!
    @IBOutlet private weak var newBtn: UIButton!
    @IBOutlet private weak var saleBtn: UIButton!
    @IBOutlet private weak var buttonLine: UIView!
    @IBOutlet private weak var gameListTableView: UITableView!
    // MARK: - ViewModel
    var viewModel: GameListViewModel = GameListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        self.navigationController?.navigationBar.isHidden = true
        topViewSubView.layer.cornerRadius = 8.0
        viewModel.gameListApiCall(viewModel.gameNewItemListURL)
        viewModel.delegate = self
    }
    // MARK: - Set Layout
    func setLayout() {
        gameListTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        topViewTitleNameLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().offset(20)
            $0.top.equalTo(topView).offset(36)
        }
        topViewSubNameLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().offset(20)
            $0.top.equalTo(topViewTitleNameLabel.snp.bottom).offset(35)
        }
        topViewSubView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(topViewSubNameLabel.snp.bottom).offset(16)
            $0.height.equalTo(157)
            $0.trailing.equalTo(topView.snp.trailing).inset(20)
        }
        newBtn.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(topViewSubView.snp.bottom).offset(40)
        }
        saleBtn.snp.makeConstraints {
            $0.leading.equalTo(newBtn.snp.trailing).offset(16)
            $0.top.equalTo(newBtn)
        }
        buttonLine.snp.makeConstraints {
            $0.height.equalTo(2)
            $0.width.equalTo(60)
            $0.top.equalTo(newBtn.snp.bottom).offset(4)
            $0.leading.equalTo(newBtn)
        }
    }
}

// MARK: - tableView DataSource & Delegate
extension GameListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("갯수반환")
        if viewModel.isEnd {
            //new Model 이 없을 때
            print("no new model")
            return (viewModel.model?.contents.count ?? 0)
        } else {
            if viewModel.model == nil {
                //통신 이전에는 model 이 비어있으니 그럴 경우 셀 0개 반환
                print("view model is nil")
                return 1
            }
            return (viewModel.model?.contents.count ?? 0) + 1     //무한스크롤링을 위해 하나 더 그려주도록한다.
        }
    }
    
    //display 하기 직전 cell for row at 보다 더 빨리 불린다.
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if viewModel.isIndicatorCell(indexPath) {
            print("인디케이터를 불러야할 타이밍")
            self.gameListTableView.reloadData()
            viewModel.newOffset += 10
            viewModel.gameListApiCall(viewModel.gameNewItemListURL)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cell for row at")
        if viewModel.isIndicatorCell(indexPath) {
            print("indicator time")
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "IndicatorTableViewCell", for: indexPath) as? IndicatorTableViewCell else { return UITableViewCell() }
            cell.animationIndicatorView()
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "GameItemTableViewCell", for: indexPath) as? GameItemTableViewCell ,
              let content = viewModel.model?.contents[indexPath.row]
        else {
            print("content error")
            return UITableViewCell()
        }
        let model: GameItemModel = GameItemModel( gameTitle: content.formalName,
                                                  gameOriginPrice: 100,
                                                  gameDiscountPrice: nil,
                                                  imageURL: content.heroBannerURL,
                                                  screenshots: content.screenshots
        )
        cell.viewModel.setModel(model)
        
        return cell
    }
}

extension GameListViewController: GameListViewModelDelegate {
    func tableViewudpate() {
        gameListTableView.reloadData()
        print("reload data")
    }
}
