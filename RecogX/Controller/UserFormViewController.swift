//
//  UserFormViewController.swift
//  RecogX
//
//  Created by Garima Bothra on 20/06/20.
//  Copyright © 2020 Garima Bothra. All rights reserved.
//

import UIKit

class UserFormViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var callTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var dropDown: UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        genderTextField.delegate = self
        dropDown.delegate = self
        dropDown.dataSource = self
        self.dropDown.isHidden = true
        self.navigationItem.title = "About You"
        self.navigationItem.largeTitleDisplayMode = .always
        // Do any additional setup after loading the view.
    }

    var list = ["Male", "Female", "Not specified"]

    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{

        return list.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

       // self.view.endEditing(true)
        return list[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        self.genderTextField.text = self.list[row]
        self.dropDown.isHidden = true
        self.genderTextField.endEditing(true)
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {

        if textField == self.genderTextField {
            self.dropDown.reloadAllComponents()
            self.dropDown.isHidden = false
            self.dropDown.reloadAllComponents()
            //if you don't want the users to se the keyboard type:

            textField.endEditing(true)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
