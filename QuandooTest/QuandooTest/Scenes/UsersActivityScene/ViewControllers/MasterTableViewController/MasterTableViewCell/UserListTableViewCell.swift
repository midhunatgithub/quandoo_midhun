//
//  UserListTableViewCell.swift
//  QuandooTest
//
//  Created by Midhun P Mathew on 11/8/16.
//  Copyright © 2016 Midhun P Mathew. All rights reserved.
//

import UIKit
enum CellActions {
    case userInfo
    case userPosts
}
class UserListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userPostsButton: UIButton!
    @IBOutlet weak var userInfoButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    weak var delegate:UserListTableViewCellDelegate?
    var indexPath:IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func userPostsButtonCliked(_ sender: AnyObject) {
        self.delegate?.userListCell(cell: self, initiatedAction: CellActions.userPosts, atTheIndexPath: self.indexPath!)
        
    }
    @IBAction func userInfoButtonCliked(_ sender: AnyObject) {
          self.delegate?.userListCell(cell: self, initiatedAction: CellActions.userInfo, atTheIndexPath: self.indexPath!)
    }
}
protocol UserListTableViewCellDelegate : class{
    func userListCell(cell:UserListTableViewCell, initiatedAction action:CellActions, atTheIndexPath indexPath:IndexPath)
}
