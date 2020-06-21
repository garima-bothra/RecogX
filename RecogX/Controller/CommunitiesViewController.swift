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
    var linkForWeb = ""
    @IBOutlet weak var communityTableView: UITableView!
    fileprivate func getData() {
        firebaseNetworking.shared.getCommunities() { completion, communities in
            self.communitiesData += communities
            self.communityTableView.reloadData()
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
        getData()
        initialSetup()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        initialSetup()
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
        cell.titleLabel.text = communitiesData[indexPath.row].name
        cell.descriptionLabel.sizeToFit()
        cell.descriptionLabel.layoutIfNeeded()
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        linkForWeb = communitiesData[indexPath.row].link
        performSegue(withIdentifier: "web", sender: Any.self)
    }
}

