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
    
    // MARK: - Private Properties
    
    private var animationView: LOTAnimationView?
    private let viewModel: SplashViewModel = SplashViewModel()

    // MARK: - Outlets
    
    @IBOutlet private weak var splashView: UIView?
    @IBOutlet private weak var titleLabel: UILabel? {
        didSet {
            titleLabel?.text = viewModel.setupTitleLabel()
        }
    }
    
    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addAnimation()
    }
    
    // MARK: - Private Functions
    
    private func setupView() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
        
    private func addAnimation() {
        animationView = LOTAnimationView(name: viewModel.animationSplash(), bundle: Bundle(for: SplashViewController.self))
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
        let homeViewController = HomeViewController.instantiate()
        navigationController?.pushViewController(homeViewController, animated: true)
    }
}

