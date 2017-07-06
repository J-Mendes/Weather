//
//  HeaderView.swift
//  Weather
//
//  Created by Jorge Mendes on 06/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import UIKit

class HeaderView: UIView {

    static var key: String = String(describing: HeaderView.self)
    static var nib: UINib = UINib(nibName: HeaderView.key, bundle: Bundle.main)
    static var height: CGFloat = 30.0
    
    internal var title: String = "" {
        didSet {
            self.titleLabel.text = self.title
        }
    }
    
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var separatorViewHeightConstraint: NSLayoutConstraint!
    
    static func create() -> HeaderView {
        return HeaderView.nib.instantiate(withOwner: nil, options: nil).first as! HeaderView
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.neutralBlueColor()
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.3
        
        self.titleLabel.text = ""
        self.separatorViewHeightConstraint.constant = 1.0 / UIScreen.main.scale
    }
    
}
