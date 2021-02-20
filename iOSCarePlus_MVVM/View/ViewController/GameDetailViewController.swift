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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //segue 로 pageviewController가 연결되어있기때문에 Destination 이 gamedetailpageViewcon 이면 모델 값을 넣어주는 형식
        (segue.destination as? GameDetailPageViewController)?.model = viewModel.model
        //let destination = segue.destination as? GAmeDetailPageViewController
        //destination.model = model 과 같은 표현
    }
}
