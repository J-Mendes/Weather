//
//  WeatherInfoTableViewCell.swift
//  Weather
//
//  Created by Jorge Mendes on 05/07/2017.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import UIKit

class WeatherInfoTableViewCell: UITableViewCell {

    static var key: String = String(describing: WeatherInfoTableViewCell.self)
    static var nib: UINib = UINib(nibName: WeatherInfoTableViewCell.key, bundle: Bundle.main)
    static var height: CGFloat = 170.0
    
    @IBOutlet fileprivate weak var weatherImageView: UIImageView!
    @IBOutlet fileprivate weak var weatherLabel: UILabel!
    @IBOutlet fileprivate weak var maxTemperatureLabel: UILabel!
    @IBOutlet fileprivate weak var minTemperatureLabel: UILabel!
    @IBOutlet fileprivate weak var currentTemperatureLabel: UILabel!
    @IBOutlet fileprivate weak var currentTemperatureUnitLabel: UILabel!
    
    fileprivate var imageLink: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.resetView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.weatherImageView.cancelLoadImageFrom(link: self.imageLink)
        self.resetView()
    }
    
    internal func configure(weatherData: WeatherData) {
        self.imageLink = weatherData.weather.condition.imageUrl
        self.weatherImageView.loadImageFrom(link: self.imageLink, placeholder: "no_picture")
        
        self.weatherLabel.text = weatherData.weather.condition.text
        self.currentTemperatureLabel.text = "\(weatherData.weather.condition.temperature!)º"
        self.currentTemperatureUnitLabel.text = weatherData.units.temperature.capitalized
        
        if let forecast: Forecast = weatherData.weather.todayForecast {
            self.maxTemperatureLabel.text = "\(forecast.high!)º"
            self.minTemperatureLabel.text = "\(forecast.low!)º"
        }
    }
    
    
    // MARK: - Private methods
    
    fileprivate func resetView() {
        self.weatherImageView.image = nil
        self.weatherLabel.text = ""
        self.maxTemperatureLabel.text = ""
        self.minTemperatureLabel.text = ""
        self.currentTemperatureLabel.text = ""
        self.currentTemperatureUnitLabel.text = ""
    }
    
}
