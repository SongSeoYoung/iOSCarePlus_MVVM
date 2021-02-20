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
    
    func setLayout() {
        containerView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
    //view 에서 모델 참조가 가능한가..?
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as? GameDetailPageViewController)?.viewModel.model = viewModel.model
        //let destination = segue.destination as? GAmeDetailPageViewController
        //destination.model = model 과 같은 표현
    }
}
