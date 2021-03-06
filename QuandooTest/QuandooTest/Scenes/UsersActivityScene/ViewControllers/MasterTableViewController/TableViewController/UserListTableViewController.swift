//
//  UserListTableViewController.swift
//  QuandooTest
//
//  Created by Midhun P Mathew on 11/8/16.
//  Copyright © 2016 Midhun P Mathew. All rights reserved.
//

import UIKit

class UserListTableViewController: UITableViewController {
    
    var users = [UserModel]()
    var selectedUser:UserModel?
    var anchorRect:CGRect?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Users"
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor(red: 0.0 / 255.0 , green: 122.0 / 255.0, blue: 255.0 / 255.0, alpha: 1)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(UserListTableViewController.refresh), for: UIControlEvents.valueChanged)
        self.refreshControl = refreshControl
        // For showing master as initial view in iPhones.
        self.splitViewController?.delegate = self
        self.splitViewController?.preferredDisplayMode = UISplitViewControllerDisplayMode.allVisible
        // For Table view dynamic height.
        tableView.estimatedRowHeight = 220.0
        tableView.rowHeight = UITableViewAutomaticDimension
        populateUIWithUsers()
    }
    
    // MARK: - Webservice calling and UI updation.
    func populateUIWithUsers(){
        
        func reloadTableView(){
            dispatchOnMainQueue {
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
        }
        // calling web service.
         ApiRequestManager.apiRequest.fetchUsers { (isSucess, users) in
            self.users = users
            reloadTableView()
        }
    }
    // pull to refresh action method.
    func refresh() {
        populateUIWithUsers()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    @IBAction func unwinFromUserInfoPopUp(segue:UIStoryboardSegue)  {
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let idetifier = segue.identifier
        let navController = segue.destination as! UINavigationController
        if idetifier == "show_userInfoPopUp" {
            navController.popoverPresentationController?.sourceRect = anchorRect!
            let userInfoView =  navController.topViewController as! UserInfoViewController
            userInfoView.userInfo = selectedUser
        }else if idetifier == "show_userPosts" {
            let userPostListView = navController.topViewController as! UserPostListViewController
            userPostListView.userId = selectedUser?.id
            userPostListView.userDisplayName = (selectedUser?.name) ?? ""
        }
    }
    
}
// MARK: - Tableview Methods
extension UserListTableViewController {
    
    override  func numberOfSections(in tableView: UITableView) -> Int{
        var numOfSections: Int = 0
        if users.count > 0 {
            numOfSections                = 1
            tableView.backgroundView = nil
        }
        else{
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x:0, y:0, width:tableView.bounds.size.width, height:tableView.bounds.size.height))
            noDataLabel.text             = "No data available, use pull to refresh"
            noDataLabel.textColor        = UIColor.black
            noDataLabel.textAlignment    = .center
            tableView.backgroundView = noDataLabel
        }
        return numOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "userList_cell", for: indexPath) as! UserListTableViewCell
        cell.indexPath = indexPath
        cell.delegate = self
        let user = users[indexPath.row]
        cell.nameLabel.text = user.name
        cell.usernameLabel.text = user.username
        cell.emailLabel.text = user.email
        func addressStringFromAddresModel(address:AddressModel) -> String{
            let addressString = address.street + "\n" + address.suite + "\n" + address.city + "\n" + address.zipcode
            return addressString;
        }
        cell.addressLabel.text = addressStringFromAddresModel(address: user.address)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedUser = users[indexPath.row]
        self.performSegue(withIdentifier: "show_userPosts", sender: self)
    }
    

}

// MARK: - UISplitViewController Delegate Methods
extension UserListTableViewController : UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true;
    }
}
// MARK: - UserListTableViewCell Delegate method
extension UserListTableViewController : UserListTableViewCellDelegate {
    func userListCell(cell: UserListTableViewCell, initiatedAction action: CellActions, atTheIndexPath indexPath: IndexPath) {
        selectedUser = users[indexPath.row]
        switch action {
        case .userInfo:
            anchorRect = cell.convert(cell.userInfoButton.frame, to: self.tableView)
            self.performSegue(withIdentifier: "show_userInfoPopUp", sender: self)
        case .userPosts:
            self.performSegue(withIdentifier: "show_userPosts", sender: self)
            
        }
    }
}
