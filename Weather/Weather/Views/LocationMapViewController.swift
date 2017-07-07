//
//  LocationMapViewController.swift
//  Weather
//
//  Created by Jorge Mendes on 07/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import UIKit
import MapKit

class LocationMapViewController: UIViewController {

    internal var dataService: DataService?
    internal var currentLocation: String!
    
    @IBOutlet fileprivate weak var descriptionLabel: UILabel!
    @IBOutlet fileprivate weak var locationMap: MKMapView!
    @IBOutlet fileprivate weak var placeView: UIView!
    @IBOutlet fileprivate weak var placeLabel: UILabel!
    
    fileprivate var locationManager: CLLocationManager?
    
    override func loadView() {
        super.loadView()
        
        // Init layout
        self.title = NSLocalizedString("location", comment: "")
        self.descriptionLabel.text = NSLocalizedString("map_description", comment: "")
        
        self.locationMap.layer.cornerRadius = 10.0
        self.locationMap.layer.borderWidth = 1.0 / UIScreen.main.scale
        self.locationMap.layer.borderColor = UIColor.lightGray.cgColor
        self.locationMap.layer.masksToBounds = true
        
        let mask: CAShapeLayer = CAShapeLayer()
        mask.path = UIBezierPath(roundedRect: self.placeView.bounds, byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 10.0, height: 10.0)).cgPath
        self.placeView.layer.mask = mask
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
    
    fileprivate func addCurrentLocationPin() {
        CLGeocoder().geocodeAddressString(self.currentLocation) { (placemarks: [CLPlacemark]?, error: Error?) in
            if error == nil && placemarks != nil && placemarks!.count > 0 {
                let place: MKPlacemark = MKPlacemark(placemark: placemarks!.first!)
                
                var region: MKCoordinateRegion = self.locationMap.region
                region.center = (place.region as? CLCircularRegion)!.center
                region.span.latitudeDelta /= 8
                region.span.longitudeDelta /= 8
                
                self.locationMap.setRegion(region, animated: true)
                self.locationMap.addAnnotation(place)
                
                self.placeLabel.text = self.currentLocation
                if self.placeView.isHidden {
                    self.placeView.alpha = 0.0
                    UIView.animate(withDuration: 0.3, animations: {
                        self.placeView.isHidden = false
                        self.placeView.alpha = 0.7
                    })
                }
            }
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
