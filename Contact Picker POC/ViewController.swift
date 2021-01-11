//
//  ViewController.swift
//  Contact Picker POC
//
//  Created by Ramy Sabry on 11/01/2021.
//

import UIKit
import ContactsUI


class ViewController: UIViewController {
    
    @IBOutlet weak var selectContactButton: UIButton!
    @IBOutlet weak var contactTextfield: UITextField!
    
    var contactPicker = ContactPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        view.backgroundColor = UIColor.white
        contactTextfield.keyboardType = .phonePad
        contactPicker.delegate = self
    }
    
    @IBAction func selectContactButtonAction(_ sender: UIButton) {
        selectContactActionFired()
    }
    
    
    // MARK:- Select Contact
    private func selectContactActionFired() {
        CNContactStore().requestAccess(for: .contacts) { (access, error) in
          print("Access: \(access)")
            switch access {
            case true:
                self.contactPicker.presentPickerView()
                break
            case false:
                break
            }
        }
    }
}


extension ViewController: ContactPickerViewDelegate {
    func contactPickerOnSelectContact(selectedPhoneNumber: String) {
        contactTextfield.text = selectedPhoneNumber
    }
}
