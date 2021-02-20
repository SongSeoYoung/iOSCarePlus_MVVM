//
//  GameImageViewController.swift
//  iOSCarePlus_MVVM
//
//  Created by 송서영 on 2021/02/19.
//

import UIKit

class GameImageViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    var url: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        
        guard let stringURL = url else{ return }
        let url: URL? = URL(string: stringURL)
        imageView.kf.setImage(with: url)
    }
    
    func setLayout() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
