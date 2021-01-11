//
//  ContactPickerViewInnerImplementation.swift
//  Contact Picker POC
//
//  Created by Ramy Sabry on 11/01/2021.
//

import UIKit
import ContactsUI


internal class ContactPickerViewInnerImplementation: NSObject {
    
    private let contactPicker = CNContactPickerViewController()
    weak var delegate: ContactPickerViewDelegate?
    
    override init() {
        super.init()
        configure()
    }
    
    private func configure() {
        contactPicker.delegate = self
        contactPicker.displayedPropertyKeys = [CNContactPhoneNumbersKey]
        contactPicker.predicateForEnablingContact = NSPredicate(format: "phoneNumbers.@count > 0")
        contactPicker.predicateForSelectionOfContact = NSPredicate(format: "phoneNumbers.@count == 1")
        contactPicker.predicateForSelectionOfProperty = NSPredicate(format: "key == 'phoneNumbers'")
        contactPicker.modalPresentationStyle = .fullScreen
    }
    
    func presentPickerView(){
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            UIApplication.topViewController()?.present(self.contactPicker, animated: true, completion: nil)
        }
    }
    
    private func setNumberFromContact(contactNumber: String) {
        let contactNumber = contactNumber.replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: " ", with: "")
            .trimmingCharacters(in: .whitespaces)
        
        delegate?.contactPickerOnSelectContact(selectedPhoneNumber: contactNumber)
        print("\nSelected Contact = ", contactNumber)
    }
}


// MARK:- CNContactPickerDelegate
extension ContactPickerViewInnerImplementation: CNContactPickerDelegate {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        if let phoneNumber = contact.phoneNumbers.first?.value.stringValue {
            setNumberFromContact(contactNumber: phoneNumber)
        }
    }
        
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
        if let phoneNo = contactProperty.value as? CNPhoneNumber {
            setNumberFromContact(contactNumber: phoneNo.stringValue)
        }
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {

    }
}
