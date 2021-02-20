//
//  GameItemTableViewCell.swift
//  iOSCarePlus_MVVM
//
//  Created by 송서영 on 2021/02/18.
//

import Kingfisher
import SnapKit
import UIKit

class GameItemTableViewCell: UITableViewCell {
    @IBOutlet private weak var gamePriceLabel: UILabel!
    @IBOutlet private weak var gameDiscountLabel: UILabel!
    @IBOutlet private weak var gameNameLabel: UILabel!
    @IBOutlet private weak var gameImage: UIImageView!
    let viewModel: GameItemCellViewModel = GameItemCellViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLayout()
        viewModel.delegate = self
    }
    
    func setLayout() {
        gameImage.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().inset(10)
            $0.height.equalTo(69)
            $0.width.equalTo(122)
        }
        gameNameLabel.snp.makeConstraints {
            $0.leading.equalTo(gameImage.snp.trailing).offset(13)
            $0.trailing.equalToSuperview().inset(20)
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
// MARK: - GameItemCellViewModel Delegate
extension GameItemTableViewCell: GameItemCellViewModelDelegate {
    func setUIFromModel() {
        guard let model = viewModel.model else { return }
        let imageURL: URL? = URL(string: model.imageURL)
        let borderColor: CGColor? = UIColor(red: 236 / 255.0, green: 236 / 255.0, blue: 236 / 255.0, alpha: 1).cgColor
        gameImage.kf.setImage(with: imageURL)
        gameImage.layer.cornerRadius = 9
        gameImage.layer.borderWidth = 1
        gameImage.layer.borderColor = borderColor
        gameNameLabel.text = model.gameTitle
        if let discountPrice: Int = model.gameDiscountPrice {
            gameDiscountLabel.text = "\(discountPrice)"
            gamePriceLabel.text = "\(model.gameOriginPrice)"
        } else {
            gamePriceLabel.text = "\(model.gameOriginPrice)"
            gameDiscountLabel.isHidden = true
            gamePriceLabel.snp.makeConstraints {
                $0.leading.equalTo(gameNameLabel.snp.leading)
                $0.bottom.equalToSuperview().inset(37)
                $0.top.equalTo(gameNameLabel.snp.bottom)
            }
        }
    }
}
