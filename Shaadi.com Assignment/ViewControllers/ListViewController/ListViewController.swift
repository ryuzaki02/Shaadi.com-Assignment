//
//  ListViewController.swift
//  Shaadi.com Assignment
//
//  Created by Aman on 29/01/21.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let cellIdentifier = "ListTableViewCell"
    private lazy var listViewModel = ListViewModel()
    private lazy var refreshControl = UIRefreshControl()
    private var userModelArray: [UserModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Users"
        setupTableView()
        getData(fromPull: false)
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Get data
    private func getData(fromPull: Bool){
        adjustRefresh(startRefresh: true, fromPull: fromPull)
        listViewModel.getUsersFromServer {[weak self] (userModelArr) in
            if let modelArray = userModelArr{
                self?.userModelArray = modelArray
            }
            self?.tableView.reloadData()
            self?.adjustRefresh(startRefresh: false, fromPull: fromPull)
        } errorHandler: {[weak self] (error) in
            //Handle error from here
            self?.adjustRefresh(startRefresh: false, fromPull: fromPull)
        }

    }
    
    //MARK:- Refresh control methods
    private func adjustRefresh(startRefresh: Bool, fromPull: Bool) {
        if startRefresh{
            if fromPull{
                tableView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
            }
            refreshControl.beginRefreshing()
        }else{
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            refreshControl.endRefreshing()
        }
    }
    
    //MARK:- Button Actions
    @objc func refresh(){
        getData(fromPull: true)
    }
    
    //MARK:- Setup Table view
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl
    }
}

extension ListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = UIStoryboard(name:"Main",bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.userModel = userModelArray[indexPath.row]
        detailVC.delegate = self
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ListTableViewCell
        cell.setupCell(userModel: userModelArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userModelArray.count
    }
}

extension ListViewController: DetailViewControllerProtocol{
    func starDidUpdate(userModel: UserModel) {
        for (i, model) in userModelArray.enumerated(){
            if model.userId == userModel.userId{
                userModelArray[i].updateStarred(isFavorite: userModel.starred)
            }
        }
        tableView.reloadData()
    }
}
