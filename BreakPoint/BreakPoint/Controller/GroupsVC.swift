//
//  GoupsVC.swift
//  BreakPoint
//
//  Created by Jeffrey Umandap on 14/01/2019.
//  Copyright © 2019 Jeffrey Umandap. All rights reserved.
//

import UIKit

class GroupsVC: UIViewController {
    @IBOutlet weak var groupsTableView: UITableView!
    
    var groupArray = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupsTableView.delegate = self
        groupsTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataService.instance.REF_GROUPS.observe(.value) { (snapShot) in
            DataService.instance.getAllGroups { (returnedGroupsArray) in
                self.groupArray = returnedGroupsArray
                self.groupsTableView.reloadData()
            }
        }
    }
    
    

}

extension GroupsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = groupsTableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as? GroupCell else { return UITableViewCell() }
        let group = groupArray[indexPath.row]
        
        cell.configureCell(title: group.groupTitle, description: group.groupDesc, memberCount: group.memberCount)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let groupFeedVC = storyboard?.instantiateViewController(withIdentifier: "GroupFeedVC") as? GroupFeedVC else { return }
        groupFeedVC.initData(forGroup: groupArray[indexPath.row])
        present(groupFeedVC, animated: true, completion: nil)
        
    }
    
}

