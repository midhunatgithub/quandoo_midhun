//
//  UserPostListViewController.swift
//  QuandooTest
//
//  Created by Midhun P Mathew on 11/8/16.
//  Copyright © 2016 Midhun P Mathew. All rights reserved.
//

import UIKit
class UserPostListViewController: UIViewController {
    var userId:Int?
    var userDisplayName = ""
    var posts = [UserPostModel]()
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var postListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Posts"
        postListTableView.estimatedRowHeight = 75.0
        postListTableView.rowHeight = UITableViewAutomaticDimension
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        headerLabel.text = userDisplayName
        populateUIWithPosts()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Webservice calling and UI updation.
    func populateUIWithPosts(){
        // user id is nill then return.
        guard let id = userId else {
            return
        }
        let userIdString = "\(id)"
        func reloadTableViewOnMainQueue(){
            dispatchOnMainQueue {
                self.postListTableView.reloadData()
            }
        }
        // calling webservice.
        ApiRequestManager.apiRequest.fetchUserPostsWithUserId(userId: userIdString) { (isSucess, posts) in
             self.posts = posts
             reloadTableViewOnMainQueue()
        }

    }
    
}
extension UserPostListViewController :  UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int{
        var numOfSections: Int = 0
        if posts.count > 0{
            numOfSections                = 1
            postListTableView.backgroundView = nil
        }
        else{
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x:0, y:0, width:postListTableView.bounds.size.width, height:postListTableView.bounds.size.height))
            noDataLabel.text             = "No data available, Please select a user"
            noDataLabel.textColor        = UIColor.black
            noDataLabel.textAlignment    = .center
            postListTableView.backgroundView = noDataLabel
        }
        return numOfSections
    }
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "postList_cell", for: indexPath) as! UserPostCell
        let post = posts[indexPath.row]
        cell.titelLabel.text = post.title
        cell.messegeLabel.text = post.body
        return cell
    }

}
