//
//  ResumeViewController.swift
//  RecogX
//
//  Created by Garima Bothra on 20/06/20.
//  Copyright © 2020 Garima Bothra. All rights reserved.
//

import UIKit
import MobileCoreServices

class ResumeViewController: UIViewController {

    @IBOutlet weak var resumeButton: UIButton!
    @IBOutlet weak var skillsLabel: UILabel!
    @IBOutlet weak var profileButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        profileButton.imageView?.image?.withTintColor(#colorLiteral(red: 0.8470588235, green: 0.631372549, blue: 0.831372549, alpha: 1))
        self.navigationController?.navigationBar.topItem?.title = "ANALYZE"
        resumeButton.layer.cornerRadius = 10
        skillsLabel.isHidden = true
        // Do any additional setup after loading the view.
    }
    @IBAction func resumeButtonPressed(_ sender: Any) {
        attachDocument()
    }

    @IBAction func profileButtonPressed(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let profileView: ProfileViewController = mainStoryboard.instantiateViewController(withIdentifier: "profile") as! ProfileViewController
        self.navigationController?.pushViewController(profileView, animated: true)
    }

    private func attachDocument() {
        let types = [kUTTypePDF, kUTTypeText, kUTTypeRTF, kUTTypeSpreadsheet]
        let importMenu = UIDocumentPickerViewController(documentTypes: types as [String], in: .import)

        if #available(iOS 11.0, *) {
            importMenu.allowsMultipleSelection = true
        }

        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet

        present(importMenu, animated: true)
    }

}

extension ResumeViewController: UIDocumentPickerDelegate, UINavigationControllerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print("\(urls)")
        firebaseNetworking.shared.uploadFile(fileURL: urls[0]) { completion in
            print("COMPLETION: \(completion)")
            self.skillsLabel.text = "Processing..."
            self.skillsLabel.isHidden = false
            firebaseNetworking.shared.getSkills() { (completion, skills) in
                var text = "SKILLS: \n\n"
                if completion == true {
                    for skill in skills {
                        text += skill + "\n\n"
                        print("SKILL: \(skill)")
                    }
                    self.skillsLabel.text = text
                    print(text)
                }
            }
        }
    }

     func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
