//
//  ContactPickerView.swift
//  Contact Picker POC
//
//  Created by Ramy Sabry on 11/01/2021.
//

import Foundation
import ContactsUI



public class ContactPickerView: NSObject {

    private var innerImplementation = ContactPickerViewInnerImplementation()
    
    public weak var delegate: ContactPickerViewDelegate? {
        didSet {
            innerImplementation.delegate = delegate
        }
    }
    
    public override init() {
        super.init()
    }
    
    public func presentPickerView(){
        innerImplementation.presentPickerView()
    }
}


