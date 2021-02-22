//
//  IndicatorTableViewCell.swift
//  iOSCarePlus_MVVM
//
//  Created by 송서영 on 2021/02/18.
//

import SnapKit
import UIKit

class IndicatorTableViewCell: UITableViewCell {
    @IBOutlet private weak var indicatorView: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        indicatorView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }

    func animationIndicatorView() {
        indicatorView.startAnimating()
    }
}
