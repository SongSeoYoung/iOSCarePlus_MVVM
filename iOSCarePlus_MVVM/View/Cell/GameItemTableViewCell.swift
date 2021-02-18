//
//  GameItemTableViewCell.swift
//  iOSCarePlus_MVVM
//
//  Created by 송서영 on 2021/02/18.
//

import UIKit
import SnapKit

class GameItemTableViewCell: UITableViewCell {

    @IBOutlet weak var gamePriceLabel: UILabel!
    @IBOutlet weak var gameDiscountLabel: UILabel!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()  
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLayout() {
        gameImage.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(10)
            $0.height.equalTo(69)
            $0.width.equalTo(122)
        }
        gameNameLabel.snp.makeConstraints {
            $0.leading.equalTo(gameImage.snp.trailing).offset(13)
            $0.trailing.equalToSuperview().offset(13)
            $0.top.equalToSuperview().offset(12)
        }
        gameDiscountLabel.snp.makeConstraints {
            $0.leading.equalTo(gameNameLabel.snp.leading)
            $0.bottom.equalToSuperview().inset(37)
            $0.top.equalTo(gameNameLabel.snp.bottom)
        }
        gamePriceLabel.snp.makeConstraints {
            $0.leading.equalTo(gameDiscountLabel.snp.trailing).offset(9)
            $0.top.bottom.equalTo(gameDiscountLabel)
        }
    }
}
