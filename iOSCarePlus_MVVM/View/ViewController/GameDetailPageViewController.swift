//
//  GameDetailPageViewController.swift
//  iOSCarePlus_MVVM
//
//  Created by 송서영 on 2021/02/19.
//

import UIKit

class GameDetailPageViewController: UIPageViewController {
    private var orderedViewControllers: [UIViewController]? = []
    
    var viewModel: GameDetailPageViewModel = GameDetailPageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        viewModel.setScreenShots()?.forEach {
            orderedViewControllers?.append($0)
        }
        setFirstViewController()
    }
    required init?(coder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    func setFirstViewController() {
        if let firstViewController: UIViewController = orderedViewControllers?.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
            print("fisrt viewcontroller setting")
        }
    }
}

// MARK: - pageViewController dataSource
extension GameDetailPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex: Int = orderedViewControllers?.firstIndex(of: viewController) else { return nil }
        let beforeIndex: Int = currentIndex - 1
        guard beforeIndex >= 0, (orderedViewControllers?.count ?? 0) > 0 else { return nil }
        return orderedViewControllers?[beforeIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex: Int = orderedViewControllers?.firstIndex(of: viewController) else { return nil }
        let afterIndex: Int = currentIndex + 1
        guard let count = orderedViewControllers?.count,
              afterIndex < count else { return nil }
        return orderedViewControllers?[afterIndex]
    }
}
