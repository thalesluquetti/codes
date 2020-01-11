//
//  SplashViewController.swift
//  ExampleAppCoin
//
//  Created by Thales Luquetti Teixeira on 10/01/20.
//  Copyright © 2020 Thales Luquetti Teixeira. All rights reserved.
//

import Lottie
import UIKit

final class SplashViewController: UIViewController {

    // MARK: - Constants
    
    private let nameLottieFile: String = "splashCoin"
    private let identifierController: String = "HomeViewController"
    private let storyboardName: String = "Coin"
    
    // MARK: - Private Properties
    
    private var animationView: LOTAnimationView?

    // MARK: - Outlets
    
    @IBOutlet private weak var splashView: UIView?
    
    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addLoading()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - Private Functions
    
    private func addLoading() {
        animationView = LOTAnimationView(name: nameLottieFile, bundle: Bundle(for: SplashViewController.self))
        animationView?.loopAnimation = false
        animationView?.backgroundColor = .clear
        
        if let animationView = animationView, let splashView = splashView, !splashView.subviews.contains(animationView) {
            animationView.frame = splashView.frame
            animationView.contentMode = .scaleAspectFit
            splashView.addSubview(animationView)
            animationView.play { _ in
                self.pushToHome()
            }
        }
    }
    
    private func pushToHome() {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: identifierController)
        navigationController?.pushViewController(controller, animated: true)
    }
}

