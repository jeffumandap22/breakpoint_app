//
//  FeedVC.swift
//  BreakPoint
//
//  Created by Jeffrey Umandap on 14/01/2019.
//  Copyright © 2019 Jeffrey Umandap. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var messageArray = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DataService.instance.getAllFeedMessages { (returnedMessagesArray) in
            self.messageArray = returnedMessagesArray.reversed()
            self.tableView.reloadData()
        }
    }


}

extension FeedVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as? FeedCell else { return UITableViewCell() }
        let message = messageArray[indexPath.row]
        DataService.instance.getUserImageCode(forUID: message.senderId) { (returnedImageCode) in
            var imgData = DataService.instance.getImageFromBase64(base64: returnedImageCode)
            if returnedImageCode == "" {
                imgData = UIImage(named: "defaultProfileImage")!
            }

            DataService.instance.getUserName(forUID: message.senderId) { (returnedUsername) in
                cell.configureCell(profileImage: imgData, email: returnedUsername, content: message.content)
            }
        }
        return cell
    }
    
   
}

