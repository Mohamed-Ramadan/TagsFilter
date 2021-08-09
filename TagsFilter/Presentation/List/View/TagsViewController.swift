//
//  TagsViewController.swift
//  TagsFilter
//
//  Created by Mohamed Ramadan on 08/08/2021.
//

import UIKit

class TagsViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: TagsViewModel!
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupIUI()
        self.setupTableView()
        self.bindViewModel()
    }
    
    //MARK: - Class methods
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let tagCellNib = UINib(nibName: TagTableViewCell.identifier, bundle: nil)
        self.tableView.register(tagCellNib, forCellReuseIdentifier: TagTableViewCell.identifier)
    }
    
    private func setupIUI() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: #selector(refreshTags), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
        
        // set right bar button with filter button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(didTapFilterButton))
    }
    
    @objc private func refreshTags() {
        self.viewModel.getTags()
    }
    
    @objc private func didTapFilterButton() {
        let filterViewController = TagsFilterViewController(with: TagsFilterViewModel(min: self.viewModel.min, tagged: self.viewModel.tagged), delegate: self)
        self.navigationController?.pushViewController(filterViewController, animated: true)
    }
    
    private func bindViewModel() {
        self.viewModel = TagsViewModel(repository: TagsRepositoryImplementer(tagsLocalStorage: TagsLocalStorageImplementer(), networkService: URLSessionNetworkService()))
        self.viewModel.getTags()
        
        
        self.viewModel.isLoading = { [weak self] isLoading in
            guard let self = self  else {
                return
            }
            
            DispatchQueue.main.async {
                self.activityIndicator.isHidden = !isLoading
                _ = isLoading ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
            } 
        }
        
        self.viewModel.tagsCompletionHandler = { [weak self] in
            guard let self = self  else {
                return
            }
            
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
            }
        }
        
        self.viewModel.error = { errorMsg in  
            let alertView = UIAlertController(title: "Error", message: errorMsg, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertView.addAction(okAction)
            self.present(alertView, animated: true, completion: nil)
        }
    }
}


extension TagsViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.viewModel.tags.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TagTableViewCell.identifier, for: indexPath) as? TagTableViewCell else {
            return UITableViewCell()
        }
        
        // Configure the cell...
        cell.configure(with: self.viewModel.setupTagItemViewModel(for: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension TagsViewController: TagsFilterViewControllerDelegate {
    func filterTags(with min: Int, tagged: String) {
        self.viewModel.filterTags(with: min, tagged: tagged)
    }
}
