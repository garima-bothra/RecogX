//
//  CommunitiesViewController.swift
//  RecogX
//
//  Created by Garima Bothra on 21/06/20.
//  Copyright © 2020 Garima Bothra. All rights reserved.
//

import UIKit

class CommunitiesViewController: UIViewController {

    var communitiesData = [Community]()
    @IBOutlet weak var profileButton: UIButton!
    var linkForWeb = ""
    var activityIndicator = UIActivityIndicatorView()
    @IBOutlet weak var communityTableView: UITableView!
    fileprivate func getData() {
        firebaseNetworking.shared.getCommunities() { completion, communities in
            self.communitiesData += communities
            self.communityTableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }

    fileprivate func initialSetup() {
        self.navigationController?.navigationBar.topItem?.title = "Explore"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        communityTableView.rowHeight =  CGFloat(integerLiteral: 100)
        communityTableView.setNeedsLayout()
        communityTableView.layoutIfNeeded()
        communityTableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        communityTableView.delegate = self
        communityTableView.dataSource = self
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
        getData()
        initialSetup()
        profileButton.tintColor = #colorLiteral(red: 0.8470588235, green: 0.631372549, blue: 0.831372549, alpha: 1)
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        initialSetup()
    }

    @IBAction func profileButtonPressed(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let profileView: ProfileViewController = mainStoryboard.instantiateViewController(withIdentifier: "profile") as! ProfileViewController
        self.navigationController?.pushViewController(profileView, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "web" {
            let dest = segue.destination as! WebsiteViewController
            dest.link = self.linkForWeb
        }
    }
}

extension CommunitiesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return communitiesData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ExploreTableViewCell = self.communityTableView.dequeueReusableCell(withIdentifier: "community") as! ExploreTableViewCell
        cell.accessoryType = .disclosureIndicator
        cell.descriptionLabel.text = communitiesData[indexPath.row].bio.trimmingCharacters(in: CharacterSet.whitespaces)
        cell.titleLabel.text = "🌟\(communitiesData[indexPath.row].name)"
        cell.descriptionLabel.sizeToFit()
        cell.descriptionLabel.layoutIfNeeded()
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        linkForWeb = communitiesData[indexPath.row].link
        performSegue(withIdentifier: "web", sender: Any.self)
    }
}

