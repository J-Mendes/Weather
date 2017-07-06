//
//  ErrorView.swift
//  Weather
//
//  Created by Jorge Mendes on 06/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import UIKit

class ErrorView: UIView {

    static var key: String = String(describing: ErrorView.self)
    static var nib: UINib = UINib(nibName: ErrorView.key, bundle: Bundle.main)
    
    internal var title: String = "" {
        didSet {
            self.errorDescription.text = self.title
        }
    }
    
    @IBOutlet fileprivate weak var pullMessageLabel: UILabel!
    @IBOutlet fileprivate weak var errorImageView: UIImageView!
    @IBOutlet fileprivate weak var errorDescription: UILabel!
 
    static func create() -> ErrorView {
        return ErrorView.nib.instantiate(withOwner: nil, options: nil).first as! ErrorView
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.pullMessageLabel.textColor = UIColor.white.withAlphaComponent(0.7)
        self.pullMessageLabel.text = NSLocalizedString("pull_refresh", comment: "")
        self.errorImageView.image = #imageLiteral(resourceName: "error")
        self.errorDescription.text = ""
    }
    
    class func show(view: UIView, title: String = NSLocalizedString("error_generic", comment: "")) {
        let errorView: ErrorView = ErrorView.create()
        var frame = view.frame
        frame.origin.x = 0
        frame.origin.y = 0
        errorView.frame = frame
        errorView.title = title
        view.addSubview(errorView)
    }
    
    class func dismiss(view: UIView) {
        view.subviews.forEach {
            if $0 is ErrorView {
                $0.removeFromSuperview()
            }
        }
    }
    
}
