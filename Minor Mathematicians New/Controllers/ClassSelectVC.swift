//
//  ViewController.swift
//  Minor Mathematicians
//
//  Created by Ricardo Aguiar Bomeny on 29/11/19.
//  Copyright © 2019 Ricardo Aguiar Bomeny. All rights reserved.
//

import UIKit

class ClassSelectVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    private let dataSource = ["5", "4", "3", "2", "1"]
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var getStartedBtn: roundBtn!
    
    var selectedGrade: String?



    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedGrade = dataSource[row]
    }
    
//    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//
//        let attString = NSAttributedString(string: dataSource[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
//        return attString
//    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.tintColor = .white
        pickerView.dataSource = self
        pickerView.delegate = self
        
        backBtn.addTarget(self, action: #selector(studentReturnFunc), for: .touchUpInside)
        
    }
    @IBAction func getStartedPressed(_ sender: Any) {
        checkSelection()
        performSegue(withIdentifier: "fiveAStudents", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? fiveAStudentsVC
        vc?.selectedGrade = selectedGrade!
    }
    
    func checkSelection(){
        if selectedGrade == nil {
            selectedGrade = "5"
        }
    }
    
    @objc func studentReturnFunc(){
        performSegue(withIdentifier: "StudentReturn", sender: nil)
    }

}
    


