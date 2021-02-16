//
//  ViewController.swift
//  iOSCarePlus_MVVM
//
//  Created by 송서영 on 2021/02/15.
//
import SnapKit
import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var backgroundImage: UIImageView!
    @IBOutlet private weak var appView: UIView!
    @IBOutlet private weak var appTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setUI()
    }
    
    private func setLayout() {
        backgroundImage.snp.makeConstraints {
            $0.bottom.top.equalToSuperview()
            $0.leading.equalTo(view.safeAreaLayoutGuide)
        }
        appView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(25)
            $0.top.equalToSuperview().offset(-200)
        }
        appTitleLabel.snp.makeConstraints {
//            $0.centerX.centerY.equalTo(appView)
            $0.top.equalToSuperview().offset(23)
            $0.bottom.equalToSuperview().inset(23)
            $0.leading.equalToSuperview().offset(9)
            $0.trailing.equalToSuperview().inset(9)
        }
    }
    private func setUI() {
        self.appView.layer.cornerRadius = 8.0
    }
}

