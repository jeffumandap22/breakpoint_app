//
//  CreateGroupsVC.swift
//  BreakPoint
//
//  Created by Jeffrey Umandap on 15/01/2019.
//  Copyright © 2019 Jeffrey Umandap. All rights reserved.
//

import UIKit

class CreateGroupsVC: UIViewController {

    @IBOutlet weak var titleTextfield: InsetTextField!
    @IBOutlet weak var descriptionTextfield: InsetTextField!
    @IBOutlet weak var emailsearchTextfield: InsetTextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var groupMemberLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var emailArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        emailsearchTextfield.delegate = self
        emailsearchTextfield.addTarget(self, action: #selector(textfieldDidChange), for: .editingChanged)
    }
    
    @objc func textfieldDidChange() {
        if emailsearchTextfield.text == "" {
            emailArray = []
            tableView.reloadData()
        } else {
            DataService.instance.getEmail(forSearchQuery: emailsearchTextfield.text!, handler: { (returnedEmailArray) in
                self.emailArray = returnedEmailArray
                self.tableView.reloadData()
            })
        }
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}

extension CreateGroupsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else { return UITableViewCell() }
        let profileImage = UIImage(named: "defaultProfileImage")
        cell.configureCell(profileImage: profileImage!, email: emailArray[indexPath.row], isSelected: true)
        
        return cell
    }
}

extension CreateGroupsVC: UITextFieldDelegate {
    
}



