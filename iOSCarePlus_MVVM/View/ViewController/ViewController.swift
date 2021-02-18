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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        appearLogoViewAnimation { [weak self] in
            self?.slideBackgroundImageAnimation()
            self?.blinkLogoAnimation()
        }
    }
    
    // MARK: - Set UI & Layout
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

// MARK: - Animation
extension ViewController {
    private func appearLogoViewAnimation(completion: @escaping () -> Void) {
        UIView.animate(
            withDuration: 0.7,
            delay: 1,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 1,
            options: []) { [weak self] in
            self?.appView.snp.updateConstraints {
                $0.top.equalToSuperview().offset(61)
            }
            self?.view.layoutIfNeeded()
        }completion: { _ in
            completion()
        }
    }
    private func slideBackgroundImageAnimation() {
        UIView.animate(withDuration: 5,
                       delay: 0,
                       options: [.curveEaseInOut, .repeat, .autoreverse]) { [weak self] in
            self?.backgroundImage.snp.updateConstraints {
                if let safeAreaLayoutGuide: UILayoutGuide = self?.view.safeAreaLayoutGuide {
                    $0.leading.equalTo(safeAreaLayoutGuide).offset(-800)
                }
            }
            self?.view.layoutIfNeeded()
        }
    }
    
    private func blinkLogoAnimation() {
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse]) {
            [weak self] in self?.appView.alpha = 0 }
    }
}
