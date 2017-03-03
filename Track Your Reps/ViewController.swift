//
//  ViewController.swift
//  Track Your Reps
//
//  Created by Benjamin Bernstein on 3/1/17.
//  Copyright © 2017 Burning Flowers. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UITableViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var votingPostions = [VotingPosition]()
    
    var currentState: String? {
        didSet {
            ProPublica().fetchAllMembersForState(currentstate: currentState!) { (returnMembers) in
                self.members = returnMembers.flatMap { return $0 }
            }
        }
    }
    
    var members = [Member]() {
        didSet {
            tableView.reloadData()
            ProPublica().fetchMember(memberID: "K000388") { (votingpositions) in
                print("voting positions are now \(votingpositions)")
                self.votingPostions = votingpositions
            }
        }
    }
    
    // for each member in members, fetchmember with member.ID
    // when you get it, take out the latest voting position
    // append latesting position to that member
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        instantiateLocation()
        
        tableView.delegate = self
        tableView.rowHeight = 125
   
    }
    
    
    
    
    // MARK: Table View Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! MainCell
        cell.nameLabel.text = members[indexPath.row].name
        cell.partyLabel.text = String(describing: members[indexPath.row].party)
        cell.twitterLabel.text = "@" + "\(members[indexPath.row].twitterID)"
        cell.recentLabel.text = "Voting on Intelligence Bill in 30 minutes"
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    // MARK: Location Methods
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!) { (placemarks, error) in
            if placemarks?.count != 0 {
                let pm = (placemarks?[0])! as CLPlacemark
                self.displayLocationInfo(placemark: pm)
            } else {
                print ("we had a problem with the data received")
            }
        }
    }
    
    func displayLocationInfo(placemark: CLPlacemark) {
        locationManager.stopUpdatingLocation()
        self.navigationItem.title = "Reps for \(String(describing: placemark.administrativeArea!))"
        guard (placemark.administrativeArea != nil) else { return }
        if currentState != placemark.administrativeArea {
            currentState = placemark.administrativeArea
        }
        
    }
    
    func instantiateLocation() {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            locationManager.startUpdatingLocation()
        }
        
    }
    
}

