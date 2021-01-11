//
//  ContactPickerViewDelegate.swift
//  Contact Picker POC
//
//  Created by Ramy Sabry on 11/01/2021.
//

import Foundation


public protocol ContactPickerViewDelegate: class {
    func contactPickerOnSelectContact(selectedPhoneNumber: String)
}
