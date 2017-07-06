//
//  ForecastTableViewCell.swift
//  Weather
//
//  Created by Jorge Mendes on 05/07/2017.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    static var key: String = String(describing: ForecastTableViewCell.self)
    static var nib: UINib = UINib(nibName: ForecastTableViewCell.key, bundle: Bundle.main)
    static var height: CGFloat = 70.0
    
    @IBOutlet fileprivate weak var weatherImageView: UIImageView!
    @IBOutlet fileprivate weak var weekDayLabel: UILabel!
    @IBOutlet fileprivate weak var weatherLabel: UILabel!
    @IBOutlet fileprivate weak var maxTemperatureLabel: UILabel!
    @IBOutlet fileprivate weak var minTemperatureLabel: UILabel!
    
    fileprivate var imageLink: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        
        self.resetView()
        self.minTemperatureLabel.textColor = UIColor.lightBlueColor()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.weatherImageView.cancelLoadImageFrom(link: self.imageLink)
        self.resetView()
    }
    
    internal func configure(forecast: Forecast) {
        self.imageLink = forecast.imageUrl
        self.weatherImageView.loadImageFrom(link: self.imageLink, placeholder: "no_picture")
        
        self.weekDayLabel.text = forecast.date.isTomorrow() ? NSLocalizedString("tomorrow", comment: "") : forecast.date.weekdayValue()
        self.weatherLabel.text = forecast.text
        self.maxTemperatureLabel.text = "\(forecast.high!)º"
        self.minTemperatureLabel.text = "\(forecast.low!)º"
    }
    
    
    // MARK: - Private methods
    
    fileprivate func resetView() {
        self.weatherImageView.image = nil
        self.weekDayLabel.text = ""
        self.weatherLabel.text = ""
        self.maxTemperatureLabel.text = ""
        self.minTemperatureLabel.text = ""
    }
    
}
