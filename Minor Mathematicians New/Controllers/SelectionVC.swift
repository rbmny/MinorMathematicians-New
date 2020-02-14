//
//  SelectionVC.swift
//  Minor Mathematicians
//
//  Created by Ricardo Aguiar Bomeny on 04/12/19.
//  Copyright © 2019 Ricardo Aguiar Bomeny. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

class SelectionVC: UIViewController {

    @IBOutlet weak var teacherBtn: roundBtn!
    @IBOutlet weak var studentBtn: roundBtn!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        teacherBtn.addTarget(self, action: #selector(teacherClicked), for: .touchUpInside)
        studentBtn.addTarget(self, action: #selector(studentClicked), for: .touchUpInside)
        
    }
    
    @objc func teacherClicked() {
        self.performSegue(withIdentifier: "TeacherVC", sender: nil)
    }

    @objc func studentClicked() {
        self.performSegue(withIdentifier: "ClassSelectVC", sender: nil)
    }

}
