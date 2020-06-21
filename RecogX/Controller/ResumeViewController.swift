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

    var jobsArr = [Job]()
    var link = String()
    @IBOutlet weak var resumeButton: UIButton!
    @IBOutlet weak var skillsLabel: UILabel!
    @IBOutlet weak var profileButton: UIButton!

    @IBOutlet weak var jobsTableView: UITableView!
    fileprivate func getData() {
        firebaseNetworking.shared.getJobs() { completion, jobs in
            self.jobsArr = jobs
            self.jobsTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        jobsTableView.delegate = self
        jobsTableView.dataSource = self
        profileButton.tintColor = #colorLiteral(red: 0.8470588235, green: 0.631372549, blue: 0.831372549, alpha: 1)
        self.navigationController?.navigationBar.topItem?.title = "ANALYZE"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        resumeButton.layer.cornerRadius = 10
        skillsLabel.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        getData()
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "website" {
            let dest = segue.destination as! WebsiteViewController
            dest.link = self.link
        }
    }

}

extension ResumeViewController: UIDocumentPickerDelegate, UINavigationControllerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print("\(urls)")
        firebaseNetworking.shared.uploadFile(fileURL: urls[0]) { completion in
            print("COMPLETION: \(completion)")
            if completion == false {
                self.skillsLabel.text = "An internal error occured"
                self.skillsLabel.isHidden = false
                return
            }
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

extension ResumeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobsArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: JobTableViewCell = self.jobsTableView.dequeueReusableCell(withIdentifier: "job") as! JobTableViewCell
        cell.accessoryType = .disclosureIndicator
        cell.companyLabel.text = jobsArr[indexPath.row].company.trimmingCharacters(in: CharacterSet.whitespaces)
        cell.positionLabel.text = jobsArr[indexPath.row].position
        cell.skillsLabel.text = "Skills: " + jobsArr[indexPath.row].skills

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        link = jobsArr[indexPath.row].link
        performSegue(withIdentifier: "website", sender: Any.self)
    }
}
