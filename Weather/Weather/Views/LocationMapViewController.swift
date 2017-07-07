//
//  LocationMapViewController.swift
//  Weather
//
//  Created by Jorge Mendes on 07/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import UIKit
import MapKit

protocol LocationChangedDelegate: class {
    func locationChanged(place: String)
}

class LocationMapViewController: UIViewController {
    
    internal weak var delegate: LocationChangedDelegate?
    internal var dataService: DataService?
    internal var currentLocation: String!
    
    @IBOutlet fileprivate weak var descriptionLabel: UILabel!
    @IBOutlet fileprivate weak var mapContainerView: UIView!
    @IBOutlet fileprivate weak var locationMap: MKMapView!
    @IBOutlet fileprivate weak var placeView: UIView!
    @IBOutlet fileprivate weak var placeLabel: UILabel!
    
    @IBOutlet fileprivate weak var infoView: UIView!
    @IBOutlet fileprivate weak var infoActivityIndicator: UIActivityIndicatorView!
    @IBOutlet fileprivate weak var infoText: UILabel!
    
    fileprivate var locationManager: CLLocationManager?
    fileprivate var place: MKPlacemark!
    
    override func loadView() {
        super.loadView()
        
        // Init layout
        self.title = NSLocalizedString("location", comment: "")
        self.descriptionLabel.text = NSLocalizedString("map_description", comment: "")
        
        self.mapContainerView.layer.cornerRadius = 10.0
        self.mapContainerView.layer.borderWidth = 1.0 / UIScreen.main.scale
        self.mapContainerView.layer.borderColor = UIColor.lightGray.cgColor
        self.mapContainerView.layer.masksToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Ask for user location permission
        self.locationManager = CLLocationManager()
        self.locationManager!.delegate = self
        self.locationManager!.requestWhenInUseAuthorization()
        
        // Center map and drop pin on current location
        self.addCurrentLocationPin()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Manage location update
    
    @IBAction func touchMap(_ sender: UIGestureRecognizer) {
        guard sender.state != .began else {
            return
        }
        
        self.showInfoView()
        
        let point: CGPoint = sender.location(in: self.locationMap)
        let coordinate: CLLocationCoordinate2D = self.locationMap.convert(point, toCoordinateFrom: self.locationMap)
        
        self.updatePlaceFromCoordinates(coordinate: coordinate)
    }
    
    fileprivate func updatePlaceFromCoordinates(coordinate: CLLocationCoordinate2D) {
        self.dataService?.getPlace(latitude: coordinate.latitude, longitude: coordinate.longitude, completion: { (place: String?, error: Error?) in
            if error == nil && place != nil {
                self.currentLocation = place
                self.placeLabel.text = self.currentLocation
                
                UserDefaults.standard.set(self.currentLocation, forKey: Constants.UserDefaultsKeys.location)
                UserDefaults.standard.synchronize()
                
                self.addCurrentLocationPin()
            } else {
                self.infoActivityIndicator.isHidden = true
                self.infoText.text = NSLocalizedString("error_updating_place", comment: "")
                Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.hideInfoView), userInfo: nil, repeats: false)
            }
        })
    }
    
    fileprivate func addCurrentLocationPin() {
        CLGeocoder().geocodeAddressString(self.currentLocation) { (placemarks: [CLPlacemark]?, error: Error?) in
            if error == nil && placemarks != nil && placemarks!.count > 0 {
                var region: MKCoordinateRegion = self.locationMap.region
                if self.place != nil {
                    self.locationMap.removeAnnotation(self.place)
                    self.delegate?.locationChanged(place: self.currentLocation)
                } else {
                    region.span.latitudeDelta /= 8
                    region.span.longitudeDelta /= 8
                }
                
                self.place = MKPlacemark(placemark: placemarks!.first!)
                region.center = (self.place.region as? CLCircularRegion)!.center
                
                self.locationMap.setRegion(region, animated: true)
                self.locationMap.addAnnotation(self.place)
                
                self.placeLabel.text = self.currentLocation
                if self.placeView.isHidden {
                    self.placeView.alpha = 0.0
                    UIView.animate(withDuration: 0.3, animations: {
                        self.placeView.isHidden = false
                        self.placeView.alpha = 0.7
                    })
                }
                
                self.hideInfoView()
            } else {
                DispatchQueue.main.async {
                    self.showInfoView()
                    self.infoActivityIndicator.isHidden = true
                    self.infoText.text = NSLocalizedString("error_updating_place", comment: "")
                    Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.hideInfoView), userInfo: nil, repeats: false)
                }
            }
        }
    }

    
    // MARK: Manage info view visibility
    
    fileprivate func showInfoView() {
        if self.infoView.isHidden {
            self.infoText.text = NSLocalizedString("updating_place", comment: "")
            self.infoView.alpha = 0.0
            UIView.animate(withDuration: 0.3, animations: {
                self.infoActivityIndicator.isHidden = false
                self.infoView.isHidden = false
                self.infoView.alpha = 0.3
            })
        }
    }
    
    @objc fileprivate func hideInfoView() {
        if !self.infoView.isHidden {
            self.infoView.alpha = 1.0
            UIView.animate(withDuration: 0.2, animations: {
                self.infoView.isHidden = true
                self.infoView.alpha = 0
            })
        }
    }
    
}

extension LocationMapViewController: CLLocationManagerDelegate {
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .notDetermined {
            switch status {
            case .denied, .restricted:
                let alert: UIAlertController = UIAlertController(title: nil, message: NSLocalizedString("no_permission_request", comment: ""), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("ignore_button", comment: ""), style: .default, handler: nil))
                alert.addAction(UIAlertAction(title: NSLocalizedString("settings_button", comment: ""), style: .cancel, handler: { (action: UIAlertAction) in
                    if UIApplication.shared.canOpenURL(URL(string: UIApplicationOpenSettingsURLString)!) {
                        DispatchQueue.main.async() { () -> Void in
                            UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
                        }
                    }
                }))
                self.present(alert, animated: true, completion: nil)
                
            default: break
            }
        }
    }
    
}
