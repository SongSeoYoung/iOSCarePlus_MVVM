//
//  GameListViewController.swift
//  iOSCarePlus_MVVM
//
//  Created by 송서영 on 2021/02/18.
//

import UIKit

class GameListViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewTitleNameLabel: UILabel!
    @IBOutlet weak var topViewSubNameLabel: UILabel!
    @IBOutlet weak var topViewSubView: UIView!
    @IBOutlet weak var newBtn: UIButton!
    @IBOutlet weak var saleBtn: UIButton!
    @IBOutlet weak var buttonLine: UIView!
    @IBOutlet private weak var gameListTableView: UITableView!
    let viewModel = GameListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        self.navigationController?.navigationBar.isHidden = true
        topViewSubView.layer.cornerRadius = 8.0
    }
    
    func setLayout() {
        gameListTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
//        topView.snp.makeConstraints {
//            $0.height.equalTo(500)
//            $0.leading.equalTo(gameListTableView.snp.leading)
//            $0.top.equalTo(gameListTableView.snp.top)
//            $0.trailing.equalTo(gameListTableView.snp.trailing)
//        }
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
            $0.top.equalTo(newBtn).offset(4)
        }
    }
}
