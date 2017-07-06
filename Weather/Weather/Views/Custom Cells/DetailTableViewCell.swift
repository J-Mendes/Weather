//
//  DetailTableViewCell.swift
//  Weather
//
//  Created by Jorge Mendes on 06/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    static var key: String = String(describing: DetailTableViewCell.self)
    static var nib: UINib = UINib(nibName: DetailTableViewCell.key, bundle: Bundle.main)
    static var height: CGFloat = 40.0
    
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        
        self.resetView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.resetView()
    }
    
    internal func configure(title: String, value: String, unit: String = "") {
        self.titleLabel.text = title
        self.valueLabel.text = "\(value)\(unit)"
    }
    
    
    // MARK: - Private methods
    
    fileprivate func resetView() {
        self.titleLabel.text = ""
        self.valueLabel.text = ""
    }
    
}
