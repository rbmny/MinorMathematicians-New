//
//  TeacherLoginVC.swift
//  Minor Mathematicians
//
//  Created by Ricardo Aguiar Bomeny on 19/01/20.
//  Copyright © 2020 Ricardo Aguiar Bomeny. All rights reserved.
//

import UIKit
import Firebase


class TeacherLoginVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtOTP1: UITextField!
    @IBOutlet weak var txtOTP2: UITextField!
    @IBOutlet weak var txtOTP3: UITextField!
    @IBOutlet weak var txtOTP4: UITextField!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var goBtn: roundBtn!
    
    var ref = Database.database().reference()
    

    
    var inputedCode: Int = 0
    var teacherCode = 0
    var adminCode = 0
    var txt1Int: Int = 0
    var txt2Int: Int = 0
    var txt3Int: Int = 0
    var txt4Int: Int = 0
    var selectedLevel: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedLevel = txtOTP1.text


        
        ref.child(selectedLevel ?? "5").child("Teachers").child("Code").observe( .value, with: { (snapshot) in
            let fivedataCode = snapshot.value as? Int
            if let fiveactualCode = fivedataCode {
                self.teacherCode = fiveactualCode
            }
         })
        
        ref.child(selectedLevel ?? "5").child("Admins").child("Code").observe( .value, with: { (snapshot) in
            let adminDataCode = snapshot.value as? Int
            if let adminActualCode = adminDataCode {
                self.adminCode = adminActualCode
            }
         })
        
        goBtn.addTarget(self, action: #selector(runCheck), for: .touchUpInside)
        
        self.hideKeyboardWhenTappedAround()
        
        txtOTP1.delegate = self
        txtOTP2.delegate = self
        txtOTP3.delegate = self
        txtOTP4.delegate = self
        
        txtOTP1.becomeFirstResponder()
    
        backBtn.addTarget(self, action: #selector(teacherReturn), for: .touchUpInside)
        
        
    } //End of viewDidLoad
    


    
    @objc func runCheck() {

        txt1Int = Int(txtOTP1.text!) ?? 0
        txt2Int = Int(txtOTP2.text!) ?? 0
        txt3Int = Int(txtOTP3.text!) ?? 0
        txt4Int = Int(txtOTP4.text!) ?? 0
        
        inputedCode = ((txt1Int*1000)+(txt2Int*100)+(txt3Int*10)+txt4Int)
        
        if inputedCode == teacherCode {
            performSegue(withIdentifier: "TeacherConfirmed", sender: nil)
        }
        
        if inputedCode == adminCode {
                   performSegue(withIdentifier: "AdminConfirmed", sender: nil)
               }
        
    }
    
    func level() -> String {
        var grade = "5"
        if selectedLevel == nil {
        grade = self.selectedLevel!
        return grade
        }
        return grade
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           if ((textField.text?.count)! < 1 ) && (string.count > 0) {
               if textField == txtOTP1 {
                   txtOTP2.becomeFirstResponder()
               }
               
               if textField == txtOTP2 {
                   txtOTP3.becomeFirstResponder()
               }
               
               if textField == txtOTP3 {
                   txtOTP4.becomeFirstResponder()
               }
               
               if textField == txtOTP4 {
                   txtOTP4.resignFirstResponder()
               }
               
               textField.text = string
               return false
           } else if ((textField.text?.count)! >= 1) && (string.count == 0) {
               if textField == txtOTP2 {
                   txtOTP1.becomeFirstResponder()
               }
               if textField == txtOTP3 {
                   txtOTP2.becomeFirstResponder()
               }
               if textField == txtOTP4 {
                   txtOTP3.becomeFirstResponder()
               }
               if textField == txtOTP1 {
                   txtOTP1.resignFirstResponder()
               }
               
               textField.text = ""
               return false
           } else if (textField.text?.count)! >= 1 {
               textField.text = string
               return false
           }
           
           return true
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as?  fiveAdminVC
        vc?.selectedGrade = level()
        
    }
    
        @objc func teacherReturn(){
            self.performSegue(withIdentifier: "TeacherReturn", sender: nil)
        }
        

    
} //End of class
