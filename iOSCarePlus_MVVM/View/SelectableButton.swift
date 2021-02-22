//
//  SelectableButton.swift
//  iOSCarePlus_MVVM
//
//  Created by 송서영 on 2021/02/18.
//

import UIKit

class SelectableButton: UIButton {
    //view 가 메모리에 올라가고나서 호출되는 라이프사이클
    override func awakeFromNib() {
        super.awakeFromNib()
        setTitleColor(UIColor(named: "black"), for: .selected)
        setTitleColor(UIColor.init(named: "VeryLightPink"), for: .normal)
        tintColor = .clear
    }
}

