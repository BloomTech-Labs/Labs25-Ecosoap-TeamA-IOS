//
//  AddProfileViewController.swift
//  LabsScaffolding
//
//  Created by Spencer Curtis on 7/27/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

protocol AddProfileDelegate: AnyObject {
    func profileWasAdded()
}

class AddProfileViewController: UIViewController {

    // MARK: - Properties and Outlets
    
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var avatarURLTextField: UITextField!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    weak var delegate: AddProfileDelegate?
    
    var profileController: ProfileController = ProfileController.shared
    var keyboardDismissalTapRecognizer: UITapGestureRecognizer!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpKeyboardDismissalRecognizer()
        
        nameTextField.delegate = self
        emailTextField.delegate = self
        avatarURLTextField.delegate = self
    }
    
    // MARK: - Actions
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addProfile(_ sender: Any) {
        NSLog("removed 2020-08-18")
    }
    
    // MARK: - Private Methods
    
    private func setUpKeyboardDismissalRecognizer() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(recognizer)
        keyboardDismissalTapRecognizer = recognizer
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate

extension AddProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            avatarURLTextField.becomeFirstResponder()
        case avatarURLTextField:
            avatarURLTextField.resignFirstResponder()
        default:
            break
        }
        return true
    }
}
