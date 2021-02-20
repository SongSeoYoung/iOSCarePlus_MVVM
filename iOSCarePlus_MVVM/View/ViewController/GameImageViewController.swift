//
//  GameImageViewController.swift
//  iOSCarePlus_MVVM
//
//  Created by 송서영 on 2021/02/19.
//

import UIKit

class GameImageViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    
    func setLayout() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}
