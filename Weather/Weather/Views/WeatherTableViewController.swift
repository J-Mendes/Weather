//
//  WeatherTableViewController.swift
//  Weather
//
//  Created by Jorge Mendes on 05/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController {

    internal var dataService: DataService?

    fileprivate enum Segues: String {
        case Settings = "showSettingsSegue"
    }
    
    fileprivate enum TableSections: Int {
        case Info = 0, Details, Forecast, Count
    }
    
    fileprivate enum DetailItems: Int {
        case Humidity = 0, Visibility, Wind, Sunrise, Sunset, Count
    }
    
    fileprivate var place: String!
    fileprivate var unitsType: Int!
    fileprivate var weatherInfo: WeatherData? {
        didSet {
            if self.weatherInfo != nil {
                DispatchQueue.main.async() { () -> Void in
                    self.title = "\(self.weatherInfo!.city!), \(self.weatherInfo!.country!)"
                }
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        
        // Init layout
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "settings"), style: .done, target: self, action: #selector(showSettings(_:)))
        
        self.refreshControl?.addTarget(self, action: #selector(WeatherTableViewController.getWeatherInfo), for: .valueChanged)
        self.refreshControl?.attributedTitle = NSAttributedString(string: NSLocalizedString("updating_wheather", comment: ""), attributes: [NSForegroundColorAttributeName: UIColor.white])
        
        self.tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "sky"))
        
        // Register custom table view cells
        self.tableView.register(WeatherInfoTableViewCell.nib, forCellReuseIdentifier: WeatherInfoTableViewCell.key)
        self.tableView.register(DetailTableViewCell.nib, forCellReuseIdentifier: DetailTableViewCell.key)
        self.tableView.register(ForecastTableViewCell.nib, forCellReuseIdentifier: ForecastTableViewCell.key)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Load place
        if let place: String = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.location) {
            self.place = place
        } else {
            self.place = Constants.DefaultValues.defaultLocation
            UserDefaults.standard.set(self.place, forKey: Constants.UserDefaultsKeys.location)
            UserDefaults.standard.synchronize()
        }
        
        // Load units
        let units: Int = UserDefaults.standard.integer(forKey: Constants.UserDefaultsKeys.units)
        if units > 0 {
            self.unitsType = units
        } else {
            self.unitsType = Constants.DefaultValues.defaultUnit
            UserDefaults.standard.set(self.unitsType, forKey: Constants.UserDefaultsKeys.units)
            UserDefaults.standard.synchronize()
        }
        
        // Load weather data
        self.refreshControl?.beginRefreshing()
        self.getWeatherInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.weatherInfo != nil ? TableSections.Count.rawValue : 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case TableSections.Info.rawValue: return 1
        case TableSections.Details.rawValue: return DetailItems.Count.rawValue
        case TableSections.Forecast.rawValue: return self.weatherInfo!.weather.forecastPrevisions.count
            
        default: return 0
        }
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var view: UIView? = nil
        switch section {
        case TableSections.Details.rawValue:
            let aView: HeaderView = HeaderView.create()
            aView.title = NSLocalizedString("details", comment: "")
            view = aView
        case TableSections.Forecast.rawValue:
            let aView: HeaderView = HeaderView.create()
            aView.title = NSLocalizedString("forecast", comment: "")
            view = aView
            
        default: break
        }
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return TableSections.Info.rawValue == section ? 0.0 : HeaderView.height
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = nil
        
        switch indexPath.section {
        case TableSections.Info.rawValue:
            let aCell: WeatherInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: WeatherInfoTableViewCell.key, for: indexPath) as! WeatherInfoTableViewCell
            aCell.configure(weatherData: self.weatherInfo!)
            cell = aCell
        case TableSections.Details.rawValue:
            let aCell: DetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.key, for: indexPath) as! DetailTableViewCell
            switch indexPath.row {
            case DetailItems.Humidity.rawValue:
                aCell.configure(title: NSLocalizedString("humidity", comment: ""), value: self.weatherInfo!.atmosphere.humidity, unit: "%")
            case DetailItems.Visibility.rawValue:
                aCell.configure(title: NSLocalizedString("visibility", comment: ""), value: self.weatherInfo!.atmosphere.visibility, unit: self.weatherInfo!.units.distance)
            case DetailItems.Wind.rawValue:
                aCell.configure(title: NSLocalizedString("wind", comment: ""), value: self.weatherInfo!.wind.speed, unit: self.weatherInfo!.units.speed)
            case DetailItems.Sunrise.rawValue:
                aCell.configure(title: NSLocalizedString("sunrise", comment: ""), value: self.weatherInfo!.astronomy.sunrise.hourFormat(), unit: "h")
            case DetailItems.Sunset.rawValue:
                aCell.configure(title: NSLocalizedString("sunset", comment: ""), value: self.weatherInfo!.astronomy.sunset.hourFormat(), unit: "h")

            default: break
            }
            cell = aCell
        case TableSections.Forecast.rawValue:
            let aCell: ForecastTableViewCell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.key, for: indexPath) as! ForecastTableViewCell
            aCell.configure(forecast: self.weatherInfo!.weather.forecastPrevisions[indexPath.row])
            cell = aCell
            
        default: break
        }

        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case TableSections.Info.rawValue: return WeatherInfoTableViewCell.height
        case TableSections.Details.rawValue: return DetailTableViewCell.height
        case TableSections.Forecast.rawValue: return ForecastTableViewCell.height
            
        default: return 0.0
        }
    }
    
    
    // MARK: - Navigation
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.Settings.rawValue {
            let settingsViewController: SettingsTableViewController = segue.destination as! SettingsTableViewController
            settingsViewController.currentLocation = self.place
            settingsViewController.currentUnit = self.unitsType
        }
    }
    
    @IBAction func showSettings(_ sender: Any?) {
        self.performSegue(withIdentifier: Segues.Settings.rawValue, sender: self)
    }
    
    
    // MARK: - Private methods
    
    @objc fileprivate func getWeatherInfo() {
        guard self.dataService != nil else {
            ErrorView.show(view: self.view)
            self.refreshControl?.endRefreshing()
            return
        }
        
        self.dataService?.getWeather(place: self.place, units: self.unitsType, completion: { (weatherData: WeatherData?, error: Error?) in
            if error == nil {
                if weatherData != nil {
                    self.weatherInfo = weatherData;
                    self.tableView.reloadData()
                } else {
                    ErrorView.show(view: self.view, title: NSLocalizedString("error_place", comment: ""))
                }
            } else {
                ErrorView.show(view: self.view)
            }
            
            ErrorView.dismiss(view: self.view)
            self.refreshControl?.endRefreshing()
        })
    }

}
