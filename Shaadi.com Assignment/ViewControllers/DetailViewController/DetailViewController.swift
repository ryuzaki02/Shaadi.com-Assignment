//
//  DetailViewController.swift
//  Shaadi.com Assignment
//
//  Created by Aman on 29/01/21.
//

import UIKit

protocol DetailViewControllerProtocol {
    func starDidUpdate(userModel: UserModel)
}

class DetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var starButton: UIButton!
    var userModel: UserModel!
    private var cellIdentifier = "DetailTableViewCell"
    var delegate: DetailViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Detail"
        setupTableView()
        updateBarButtonItem(starred: userModel.starred)
    }
    
    //MARK:- Setup Table view
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    //MARK:- Button Actions
    @objc func starButtonAction(){
        userModel.updateStarred(isFavorite: !userModel.starred)
        updateBarButtonItem(starred: userModel.starred)
        delegate?.starDidUpdate(userModel: userModel)
    }
    
    //MARK:- Setup bar button item
    private func updateBarButtonItem(starred: Bool) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: starred ? "starred" : "star"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(starButtonAction))
    }
}

extension DetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DetailTableViewCell
        switch indexPath.row {
        case 0:
            cell.nameLabel.text = "Name: " + (userModel.name ?? "Guest")
        case 1:
            cell.nameLabel.text = "User Name: " + (userModel.userName ?? "Guest")
        case 2:
            let suite = userModel.addressModel?.suite ?? "NA"
            let street = userModel.addressModel?.street ?? "NA"
            let city = userModel.addressModel?.city ?? "NA"
            let zipcode = userModel.addressModel?.zipcode ?? "NA"
            cell.nameLabel.text = "Address: " + suite + street + city + zipcode
        case 3:
            let name = userModel.companyModel?.name ?? "NA"
            let catchPhrase = userModel.companyModel?.catchPhrase ?? "NA"
            cell.nameLabel.text = "Company: " + name + "\n" + catchPhrase
        case 4:
            let phone = userModel.phone ?? "NA"
            let website = userModel.website ?? "NA"
            cell.nameLabel.text = "Phone: " + phone + "\n" + website
        default:
            cell.nameLabel.text = "Not available"
        }
        return cell
    }
}

extension DetailViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
