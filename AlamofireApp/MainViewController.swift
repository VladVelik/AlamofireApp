//
//  ViewController.swift
//  AlamofireApp
//
//  Created by Sosin Vladislav on 23.01.2023.
//

import UIKit

final class MainViewController: UIViewController {
    private let tableView = UITableView()
    private var pictures = [Picture]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setConstraints()
        fetchInfo()
    }
    
    private func fetchInfo() {
        NetworkManager.shared.fetchImagesInfo(url: URLs.postsList) { [weak self] result in
            switch result {
            case .success(let pictures):
                self?.pictures = pictures
                self?.tableView.reloadData()
            case .failure (let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func setTableView() {
        tableView.rowHeight = 100
        view.addSubview(tableView)

        tableView.register(TableViewCell.self,
                           forCellReuseIdentifier: TableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension MainViewController: UITableViewDelegate {}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pictures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        let id = "id: " + (pictures[indexPath.row].id ?? "0")
        let author = "author: " + (pictures[indexPath.row].author ?? "unknown")
        let img = pictures[indexPath.row].download_url ?? ""
        
        cell.configure(id: id, author: author, img: img)
        return cell
    }
}
