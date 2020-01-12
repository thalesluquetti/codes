//
//  HomeViewController.swift
//  ExampleAppCoin
//
//  Created by Thales Luquetti Teixeira on 10/01/20.
//  Copyright © 2020 Thales Luquetti Teixeira. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController, Identifiable {
    
    // MARK: - Constants
    
    private let cellIdentifier: String = "ratesCellIdentifier"
    
    // MARK: - Outlets
    
    @IBOutlet private weak var baseCoinTitleLabel: UILabel?
    @IBOutlet private weak var baseCoinImageView: UIImageView?
    @IBOutlet private weak var ratesCoinTableView: UITableView? {
        didSet {
            ratesCoinTableView?.delegate = self
            ratesCoinTableView?.dataSource = self
        }
    }
    
    // MARK: - Private Properties
    
    private var viewModel: HomeViewModel?
    private var shimmerView: ShimmerView? = ShimmerView.fromNib(withOwner: self)
    private var errorView: ErrorView? = ErrorView.fromNib(withOwner: self)
    
    // MARK: - Initializers
    
    static func instantiate(viewModel: HomeViewModel = HomeViewModel()) -> HomeViewController {
        let viewController: HomeViewController = UIStoryboard.viewController(from: .coin)
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindElements()
    }
    
    // MARK: - Private methods
    
    @IBAction private func segmentChanged(_ sender: UISegmentedControl) {
        viewModel?.indexSelected.value = sender.selectedSegmentIndex
    }
    
    private func bindElements() {
        viewModel?.indexSelected.bind{ [weak self] value in
            guard let weakSelf = self else { return }
            weakSelf.setupHeaderView()
            weakSelf.viewModel?.setUrlPath()
            weakSelf.viewModel?.fetchData()
        }
        
        viewModel?.statusScreen.bind{ [weak self] value in
            guard let weakSelf = self else { return }
            switch value {
            case .loading:
                weakSelf.startLoading()
            case .loaded:
                // delay para exibir shimmer
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    weakSelf.stopLoading()
                    weakSelf.ratesCoinTableView?.reloadData()
                }
            case .error:
                weakSelf.showError()
            }
        }
    }
    
    private func setupHeaderView() {
        baseCoinImageView?.image = UIImage(named: viewModel?.setupBaseCoinImage() ?? "")
        baseCoinTitleLabel?.text = viewModel?.setupBaseCoinTitleLabel()
    }
    
    private func pushToConversion(viewModel: CoinConversionSimulationViewModel) {
        let coinConversionSimulationViewController = CoinConversionSimulationViewController.instantiate(viewModel: viewModel)
        navigationController?.pushViewController(coinConversionSimulationViewController, animated: true)
    }
    
    private func showError() {
        guard let errorView = errorView else { return }
        errorView.frame = view.bounds
        view?.addSubview(errorView)
        errorView.delegate = self
    }
    
    private func startLoading() {
        guard let shimmerView = shimmerView else { return }
        shimmerView.frame = view.bounds
        view?.addSubview(shimmerView)
        shimmerView.startShimmer()
    }
    
    private func stopLoading() {
        guard let shimmerView = shimmerView else { return }
        shimmerView.removeFromSuperview()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RatesTableViewCell else {
            fatalError(Localizable.cellNotFound.localize())
        }
        guard let viewModelCell = viewModel?.getViewModelCell(index: indexPath.row) else { return UITableViewCell() }
        cell.setup(model: viewModelCell)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let initialsSelected = "not implemented"
        let viewModel = CoinConversionSimulationViewModel(initialCountrySelected: initialsSelected)
        pushToConversion(viewModel: viewModel)
    }
    
}

// MARK: - ErrorViewDelegate

extension HomeViewController: ErrorViewDelegate {
    func retryAction() {
        viewModel?.fetchData()
    }
}
