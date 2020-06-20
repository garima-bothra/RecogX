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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func resumeButtonPressed(_ sender: Any) {
        attachDocument()
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ResumeViewController: UIDocumentPickerDelegate, UINavigationControllerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print("\(urls)")
        firebaseNetworking.shared.uploadFile(fileURL: urls[0]) { completion in
            print("COMPLETION: \(completion)")
        }
    }

     func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
