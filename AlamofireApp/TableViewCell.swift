//
//  TableViewCell.swift
//  AlamofireApp
//
//  Created by Sosin Vladislav on 23.01.2023.
//

import UIKit

final class TableViewCell: UITableViewCell {
    static let identifier = "bigCell"
    
    private var idLabel = UILabel()
    private var authorLabel = UILabel()
    private var image = UIImageView()
    private var activityIndicator = UIActivityIndicatorView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(idLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(image)
        contentView.addSubview(activityIndicator)
        reuseIndicator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        idLabel.frame = CGRect(x: 10, y: 0, width: 200, height: contentView.frame.size.height-10)
        authorLabel.frame = CGRect(x: 10, y: 20, width: 250, height: contentView.frame.size.height-10)
        image.frame = CGRect(x: contentView.frame.size.width-100, y: 0, width: 100, height: 100)
        activityIndicator.frame = CGRect(x: contentView.frame.size.width-100, y: 0, width: 100, height: 100)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        idLabel.text = nil
        authorLabel.text = nil
        image.image = nil
        reuseIndicator()
    }
    
    public func configure(id: String, author: String, img: String) {
        idLabel.text = id
        authorLabel.text = author

        NetworkManager.shared.fetchImage(url: img) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.image.image = UIImage(data: imageData)
                self?.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }

    private func reuseIndicator() {
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
}
