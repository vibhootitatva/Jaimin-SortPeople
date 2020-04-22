//
//  ViewController.swift
//  SortPeople
//
//  Created by PCQ184 on 22/04/20.
//  Copyright © 2020 PCQ184. All rights reserved. 
//

import UIKit
import  Contacts
import ContactsUI
//import TinderSwipeView

class PeopleViewController: UIViewController{
            var contactdata = [Any]()
            var personinfo: [UserModel] = []
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    private var swipeView: TinderSwipeView<UserModel>!{
        didSet{
            self.swipeView.delegate = self
        }
    }
    
       override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { granted, error in
            guard granted else {
                DispatchQueue.main.async {
                    self.presentSettingsalert()
                }
                return
            }

            var contacts = [CNContact]()
            let request = CNContactFetchRequest(keysToFetch: [CNContactIdentifierKey as NSString, CNContactFormatter.descriptorForRequiredKeys(for: .fullName)])
            do {
                try store.enumerateContacts(with: request) { contact, stop in
                    contacts.append(contact)
                }
            } catch {
                print(error)
            }
            
            let formatter = CNContactFormatter()
            formatter.style = .fullName
            
            for contact in contacts {
                print(formatter.string(from: contact) ?? "???")
                self.contactdata.append(formatter.string(from: contact) ?? "???")
            }
        }
        
        
        
    }
    func presentSettingsalert() {
        let alert = UIAlertController(title: "Permission to Contacts", message: "This app needs access to contacts in order to ...", preferredStyle:.alert)
        alert.addAction(UIAlertAction(title: "Go to Settings", style: .default) { _ in
            let url = URL(string: UIApplication.openSettingsURLString)!
            UIApplication.shared.open(url)
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}
extension PeopleViewController:TinderSwipeViewDelegate {
     func dummyAnimationDone() {
            UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveLinear, animations: {
                self.bottomView.alpha = 1.0
            }, completion: nil)
            print("Watch out shake action")
        }
        
        func didSelectCard(model: Any) {
            print("Selected card")
        }
        
        func fallbackCard(model: Any) {
            let userModel = model as! UserModel
            print("Cancelling \(userModel.name!)")
        }
        
        func cardGoesLeft(model: Any) {
            let userModel = model as! UserModel
            print("Watchout Left \(userModel.name!)")
        }
        
        func cardGoesRight(model : Any) {
            let userModel = model as! UserModel
            print("Watchout Right \(userModel.name!)")
        }
        
        func undoCardsDone(model: Any) {
            let userModel = model as! UserModel
            print("Reverting done \(userModel.name!)")
        }
        
        func endOfCardsReached() {
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveLinear, animations: {
                self.bottomView.alpha = 0.0
            }, completion: nil)
             print("End of all cards")
        }
        
        func currentCardStatus(card object: Any, distance: CGFloat) {
        print(distance)
        }
    }

    

