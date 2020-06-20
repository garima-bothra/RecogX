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
    @IBOutlet weak var saveButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        genderTextField.delegate = self
        dropDown.delegate = self
        dropDown.dataSource = self
        self.dropDown.isHidden = true
        self.saveButton.layer.cornerRadius = 10
        self.mailTextField.text = getEmail()
        self.mailTextField.isEnabled = false
        self.navigationController?.navigationBar.topItem?.title = "About You"
        self.navigationController?.navigationBar.prefersLargeTitles = true
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

     func setParams() -> [String:Any]?{
        var param : [String:Any]
        appUser.name =  nameTextfield.text!
        appUser.phone = callTextField.text!
        appUser.mail = mailTextField.text!
        appUser.gender = genderTextField.text!
        param = ["name": nameTextfield.text, "phone": callTextField.text, "mail": mailTextField.text, "gender": genderTextField.text]
        return param
    }

    @IBAction func saveButtonPressed(_ sender: Any) {
        if nameTextfield.text == "" {
            dismissAlert(titlepass: "No Name", message: "Please enter your name")
            return
        }
        if callTextField.text != "" {
            let phone = callTextField.text!
            if !phone.isValidPhone {
                dismissAlert(titlepass: "Invalid Number", message: "Please enter a valid phone number")
            }
        }else {
                dismissAlert(titlepass: "No phone number", message: "Please enter your phone number")
                return
            }
        if genderTextField.text == "" {
                   dismissAlert(titlepass: "Select Gender", message: "Please select 'Not specified' if you do not wish to specify!")
                   return
               }
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let tabController: UITabBarController = storyboard.instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
        if let params = setParams(){
            firebaseNetworking.shared.fillUserForm(param: params) { (result) in
                if result {
                    print("User data has been saved ")
                    self.present(tabController, animated: true, completion: nil)
                }else{
                    self.authAlert(titlepass: "Sorry", message: "Please Try again")
                }
            }
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
