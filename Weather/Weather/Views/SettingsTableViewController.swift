//
//  SettingsTableViewController.swift
//  Weather
//
//  Created by Jorge Mendes on 06/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import UIKit

protocol SettingsChangedDelegate {
    func unitTypeChanged(unitType: Int)
    func locationChanged(place: String)
}

class SettingsTableViewController: UITableViewController {
    
    internal var delegate: SettingsChangedDelegate?
    internal var currentLocation: String!
    internal var currentUnit: Int!
    
    fileprivate enum Segues: String {
        case LocationMap = "showMapSegue"
    }
    
    fileprivate enum SettingsType: Int {
        case Location = 0, Units, Count
    }
    
    override func loadView() {
        super.loadView()
        
        // Init layout
        self.title = NSLocalizedString("settings", comment: "")
        self.tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "sky"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsType.Count.rawValue
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case SettingsType.Location.rawValue: return 1
        case SettingsType.Units.rawValue: return 2
            
        default: return 0
        }
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == SettingsType.Units.rawValue {
            let view: HeaderView = HeaderView.create()
            view.title = NSLocalizedString("unit", comment: "")
            return view
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = nil
        
        switch indexPath.section {
        case SettingsType.Location.rawValue:
            var aCell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "location")
            if aCell == nil {
                aCell = UITableViewCell(style: .value1, reuseIdentifier: "location")
            }
            aCell?.textLabel?.text = NSLocalizedString("location", comment: "")
            aCell?.detailTextLabel?.text = self.currentLocation
            aCell?.accessoryType = .disclosureIndicator
            cell = aCell
            break
        case SettingsType.Units.rawValue:
            var aCell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "units")
            if aCell == nil {
                aCell = UITableViewCell(style: .default, reuseIdentifier: "units")
            }
            
            switch indexPath.row {
            case Constants.UnitsType.Imperial.rawValue - 1:
                aCell?.textLabel?.text = NSLocalizedString("imperial", comment: "")
            case Constants.UnitsType.Metric.rawValue - 1:
                aCell?.textLabel?.text = NSLocalizedString("metric", comment: "")
                
            default: break
            }
            
            aCell?.accessoryType = indexPath.row == self.currentUnit - 1 ? .checkmark : .none
            cell = aCell
            break
            
        default: break
        }

        cell?.textLabel?.textColor = UIColor.white
        cell?.detailTextLabel?.textColor = UIColor.white
        cell?.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        return cell!
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case SettingsType.Location.rawValue:
            self.performSegue(withIdentifier: Segues.LocationMap.rawValue, sender: self)
            break
        case SettingsType.Units.rawValue:
            self.currentUnit = indexPath.row + 1
            
            UserDefaults.standard.set(self.currentUnit, forKey: Constants.UserDefaultsKeys.units)
            UserDefaults.standard.synchronize()
            
            self.delegate?.unitTypeChanged(unitType: self.currentUnit)
            break
            
        default: break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.LocationMap.rawValue {
            let mapViewController: LocationMapViewController = segue.destination as! LocationMapViewController
            mapViewController.dataService = DataService()
            mapViewController.currentLocation = self.currentLocation
        }
    }
    
}
