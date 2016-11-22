//
//  UserInfoViewController.swift
//  QuandooTest
//
//  Created by Midhun P Mathew on 11/8/16.
//  Copyright © 2016 Midhun P Mathew. All rights reserved.
//

import UIKit
import MapKit
class UserInfoViewController: UITableViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var streentLabel: UILabel!
    @IBOutlet weak var suitLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var zipcodeLabel: UILabel!
    @IBOutlet weak var locationMapView: MKMapView!
    @IBOutlet weak var comapanyNameLabel: UILabel!
    @IBOutlet weak var industryLabel: UILabel!
    @IBOutlet weak var serviceLabel: UILabel!
    var userInfo:UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "User Details"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        populateUIWithData()
    }
    func populateUIWithData(){
        
        guard let user = userInfo else {
            return
        }
        
        nameLabel.text = user.name
        usernameLabel.text = user.username
        emailLabel.text = user.email
        websiteLabel.text = user.website
        phoneLabel.text = user.phone
        streentLabel.text = user.address.street
        suitLabel.text = user.address.suite
        cityLabel.text = user.address.city
        zipcodeLabel.text = user.address.zipcode
        comapanyNameLabel.text = user.company.name
        industryLabel.text = user.company.catchPhrase
        serviceLabel.text = user.company.bs
        let annotation = MKPointAnnotation()
        
        let latitude = Double(user.address.geoLocation.latitude) ?? 0.0
        let longitude = Double(user.address.geoLocation.longitude) ?? 0.0
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        annotation.coordinate = coordinate
        locationMapView.addAnnotation(annotation)
        
    }
   

}
