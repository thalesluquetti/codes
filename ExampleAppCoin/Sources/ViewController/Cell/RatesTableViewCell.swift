//
//  RatesTableViewCell.swift
//  ExampleAppCoin
//
//  Created by Thales Luquetti Teixeira on 11/01/20.
//  Copyright © 2020 Thales Luquetti Teixeira. All rights reserved.
//

import UIKit

final class RatesTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var rateValueLabel: UILabel?
    @IBOutlet private weak var coinTitleLabel: UILabel?
    @IBOutlet private weak var countryImageView: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Public methods
    
    func setup(model: RatesTableViewCellViewModel) {
        rateValueLabel?.text = model.valueCoin.toCurrency(initial: model.getImageName())
        coinTitleLabel?.text = model.getTitleCoin()
        countryImageView?.image = UIImage(named: model.getImageName())
    }
}
