//
//  GameDetailPageViewModel.swift
//  iOSCarePlus_MVVM
//
//  Created by 송서영 on 2021/02/20.
//

import UIKit

class GameDetailPageViewModel {
    var model: NewGameContent?
    var orderedViewControllers: [UIViewController]? = []
    
    func setScreenShots() -> [UIViewController]? {
        guard let screenshots = model?.screenshots else { return [] }
        for screenShot in screenshots {
            guard let url = screenShot.images.first?.url else { return [] }
            let imageViewController: UIViewController = getImageViewController( url: url)
            orderedViewControllers?.append(imageViewController)
        }
        return orderedViewControllers
    }
    
    private func getImageViewController( url: String) -> UIViewController {
        guard let imageViewController: GameImageViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameImageViewController") as? GameImageViewController else { return UIViewController() }
        imageViewController.url = url
        return imageViewController
    }
}
