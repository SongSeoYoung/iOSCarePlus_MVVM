//
//  GameListViewController.swift
//  iOSCarePlus_MVVM
//
//  Created by 송서영 on 2021/02/18.
//

import SnapKit
import UIKit

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
//    var buttonLineCenter: Constraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        topViewSubView.layer.cornerRadius = 8.0
        viewModel.gameListApiCall(viewModel.gameNewItemListURL)
        viewModel.delegate = self
        newBtn.isSelected = true
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
//            $0.leading.equalTo(newBtn)
            $0.centerX.equalTo(newBtn.snp.centerX)
        }
    }
    
    @IBAction private func newButtonTapped(_ sender: Any) {
        newBtn.isSelected = true
        saleBtn.isSelected = false
        
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.buttonLine.snp.remakeConstraints {
                $0.height.equalTo(2)
                $0.width.equalTo(60)
                $0.top.equalTo(self?.newBtn.snp.bottom as! ConstraintRelatableTarget).offset(4)
                $0.centerX.equalTo(self?.newBtn.snp.centerX as! ConstraintRelatableTarget)
            }
            self?.view.layoutIfNeeded()
        }

        viewModel.newOffset = 0
        viewModel.setModelToNil()
        viewModel.gameListApiCall(viewModel.gameNewItemListURL)
    }
    
    @IBAction private func saleButtonTapped(_ sender: Any) {
        saleBtn.isSelected = true
        newBtn.isSelected = false

        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.buttonLine.snp.remakeConstraints {
                $0.height.equalTo(2)
                $0.width.equalTo(60)
                $0.top.equalTo(self?.saleBtn.snp.bottom as! ConstraintRelatableTarget).offset(4)
                $0.centerX.equalTo(self?.saleBtn.snp.centerX as! ConstraintRelatableTarget)
            }
            self?.view.layoutIfNeeded()
        }

        viewModel.newOffset = 0
        viewModel.setModelToNil()
        viewModel.gameListApiCall(viewModel.gameSaleItemListURL)
    }
}

// MARK: - tableView DataSource & Delegate
extension GameListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.isEnd {
            //new Model 이 없을 때
            let modelContentsCount: Int? = viewModel.getModelContentsCount()
            return (modelContentsCount ?? 0)
        } else {
            if viewModel.getModel() == nil {
                //통신 이전에는 model 이 비어있으니 그럴 경우 셀 0개 반환
                return 0
            }
            let modelContentsCount: Int? = viewModel.getModelContentsCount()
            return (modelContentsCount ?? 0) + 1
        }
    }
    
    //display 하기 직전 cell for row at 보다 더 빨리 불린다.
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if viewModel.isIndicatorCell(indexPath) {
            self.gameListTableView.reloadData()
            viewModel.newOffset += 10
            viewModel.gameListApiCall(viewModel.gameNewItemListURL)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.isIndicatorCell(indexPath) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "IndicatorTableViewCell", for: indexPath) as? IndicatorTableViewCell else { return UITableViewCell() }
            cell.animationIndicatorView()
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "GameItemTableViewCell", for: indexPath) as? GameItemTableViewCell ,
              let content = viewModel.getContent(of: indexPath.row)
        else {
            return UITableViewCell()
        }
        cell.viewModel.setModel(viewModel.setCellModel(of: content))
        
        return cell
    }
}
// MARK: - tableView delegate
extension GameListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let gameDetailViewController: GameDetailViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameDetailViewController") as? GameDetailViewController,
              let content = viewModel.getContent(of: indexPath.row) else { return }
        gameDetailViewController.viewModel.setModel(of: content)
        navigationController?.pushViewController(gameDetailViewController, animated: true)
    }
}

// MARK: - GameListViewModel delegate
extension GameListViewController: GameListViewModelDelegate {
    func tableViewudpate() {
        gameListTableView.reloadData()
    }
}
