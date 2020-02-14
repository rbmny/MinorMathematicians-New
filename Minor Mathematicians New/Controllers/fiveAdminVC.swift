//
//  AdminVC.swift
//  Minor Mathematicians
//
//  Created by Ricardo Aguiar Bomeny on 26/01/20.
//  Copyright © 2020 Ricardo Aguiar Bomeny. All rights reserved.
//

import UIKit
import Firebase

class fiveAdminVC: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var postTxtField: UITextView!
    @IBOutlet weak var postBtn: UIButton!
    @IBOutlet weak var urlTxtView: UITextField!
    
    var selectedGrade = ""

    
    
    @IBAction func handlePostBtn() {
        
        let postRef = Database.database().reference().child("Fifth Grade").child("Posts").childByAutoId()

        
        let postObject = [
            "text": postTxtField.text!,
            "timestamp": [".sv":"timestamp"],
            "url": urlTxtView.text!
            
        ] as [String:Any]
        

        
        postRef.setValue(postObject, withCompletionBlock: { error, ref in
            if error == nil {
                self.dismiss(animated: true, completion: nil)

            } else {
                //Handle err
            }
        })
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        view.frame.origin.y = -280
        if urlTxtView.text == "noURL" {
            urlTxtView.text = String()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        view.frame.origin.y = 0
        if urlTxtView.text == nil || urlTxtView.text == "" {
            urlTxtView.text = "noURL"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        urlTxtView.resignFirstResponder()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if postTxtField.text == "Insert message here" {
            postTxtField.text = String()
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if postTxtField.text == nil {
                postTxtField.text = "Insert message here"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postTxtField.layer.cornerRadius = 19
        urlTxtView.layer.cornerRadius = 19
        
        postTxtField.delegate = self
        
        urlTxtView.delegate = self
        urlTxtView.resignFirstResponder()
        urlTxtView.returnKeyType = .done
        
        self.hideKeyboardWhenTappedAround()
        
        }
    
    @objc func keyboardWillChange(notification: Notification) {
        print("Keyboard will show: \(notification.name.rawValue)")
        view.frame.origin.y = -265
        }
    }
