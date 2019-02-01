//
//  CreateGroupsVC.swift
//  BreakPoint
//
//  Created by Jeffrey Umandap on 15/01/2019.
//  Copyright © 2019 Jeffrey Umandap. All rights reserved.
//

import UIKit
import Firebase

class CreateGroupsVC: UIViewController {

    @IBOutlet weak var titleTextfield: InsetTextField!
    @IBOutlet weak var descriptionTextfield: InsetTextField!
    @IBOutlet weak var emailsearchTextfield: InsetTextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var groupMemberLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var emailArray = [String]()
    var chosenUserArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        emailsearchTextfield.delegate = self
        emailsearchTextfield.addTarget(self, action: #selector(textfieldDidChange), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        doneButton.isHidden = true
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
        if titleTextfield.text != "" && descriptionTextfield.text != "" {
            DataService.instance.getIds(forUsernames: chosenUserArray, handler: { (idsArray) in
                var userIds = idsArray
                userIds.append((Auth.auth().currentUser?.uid)!)
                
                DataService.instance.createGroup(withTitle: self.titleTextfield.text!, andDescription: self.descriptionTextfield.text!, forUserIds: userIds, handler: { (groupCreated) in
                    if groupCreated {
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        print("Group could not be created, please try again.")
                    }
                })
            })
        }
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
        
        if chosenUserArray.contains(emailArray[indexPath.row]) {
            cell.configureCell(profileImage: profileImage!, email: emailArray[indexPath.row], isSelected: true)
        } else {
            cell.configureCell(profileImage: profileImage!, email: emailArray[indexPath.row], isSelected: false)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else { return }
        if !chosenUserArray.contains(cell.emailLabel.text!) {
            chosenUserArray.append(cell.emailLabel.text!)
            groupMemberLabel.text = chosenUserArray.joined(separator: ", ")
            doneButton.isHidden = false
        } else {
            chosenUserArray = chosenUserArray.filter({ $0 != cell.emailLabel.text! })
            if chosenUserArray.count >= 1 {
                groupMemberLabel.text = chosenUserArray.joined(separator: ", ")
            } else {
                groupMemberLabel.text = "add people to your group"
                doneButton.isHidden = true
            }
        }
    }
}

extension CreateGroupsVC: UITextFieldDelegate {
    
}



