//
//  ViewController.swift
//  equipo
//
//  Created by Anton McConville on 2016-05-14.
//  Copyright © 2016 IBM. All rights reserved.
//

import UIKit

import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var teamMap: MKMapView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        /* Center on Buenos Aires */
        
        let initialLocation = CLLocation(latitude: -34.603333, longitude: -58.381667)

        centerMapOnLocation(initialLocation)
        
        /* Read data from swift app on Bluemix */
        
        let data:NSData = self.getJSON("http://swiftcfsummit.mybluemix.net/")
        
        /* Parse data and build up map annotations */
        
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            
            let item = json[0]
            
            if let team = item["Argentina"] as? [[String: AnyObject]] {
            
                for player in team {
                    
                    var latitude:Double
                    var longitude:Double
                    
                    if let name = player["Name"] as? String {
        
                        if let lng = player["Lng"] as? NSNumber{
                    
                            if let lat = player["Lat"]as? NSNumber{
                    
                                latitude = Double(lat)
                            
                                longitude = Double(lng)
                            
                                /* Create map annotation */
                            
                                let annotation = Player(latitude: latitude, longitude: longitude)
                            
                                annotation.title = name;
                            
                                /* Add pin to map */
                            
                                teamMap.addAnnotation(annotation)
                            }
                        }
                    }
                }
            }
        } catch {
            print("error serializing JSON: \(error)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func centerMapOnLocation(location: CLLocation) {
        
        let regionRadius: CLLocationDistance = 1000000

        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 1, regionRadius * 1)
        teamMap.setRegion(coordinateRegion, animated: true)
    }

    func getJSON(urlToRequest: String) -> NSData{
        return NSData(contentsOfURL: NSURL(string: urlToRequest)!)!
    }
    
}
