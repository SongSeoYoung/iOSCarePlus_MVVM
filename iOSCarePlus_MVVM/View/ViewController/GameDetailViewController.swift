//
//  GameDetailViewController.swift
//  iOSCarePlus_MVVM
//
//  Created by 송서영 on 2021/02/19.
//

import UIKit

class GameDetailViewController: UIViewController {

    @IBOutlet private weak var containerView: UIView!
    
    var viewModel: GameDetailViewModel = GameDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    
    private func setLayout() {
        containerView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as? GameDetailPageViewController)?.viewModel.setModel(of: viewModel.getModel())
    }
}
