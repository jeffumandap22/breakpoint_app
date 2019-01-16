//
//  GroupFeedVC.swift
//  BreakPoint
//
//  Created by Jeffrey Umandap on 16/01/2019.
//  Copyright © 2019 Jeffrey Umandap. All rights reserved.
//

import UIKit

class GroupFeedVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var groupTitleLabel: UILabel!
    @IBOutlet weak var membersLabel: UILabel!
    @IBOutlet weak var messageTextField: InsetTextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var sendButtonView: UIView!
    
    var group: Group?
    
    func initData(forGroup group: Group) {
        self.group = group
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sendButtonView.bindToKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupTitleLabel.text = group?.groupTitle
        DataService.instance.getEmails(group: group!) { (returnedEmails) in
            self.membersLabel.text = returnedEmails.joined(separator: ", ")
        }
        
        
    }

    @IBAction func backbuttonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendButtonPressed(_ sender: Any) {
        
    }
    
}
