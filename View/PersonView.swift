//
//  PersonView.swift
//  Task
//
//  Created by Артур Кондратьев on 21.12.2022.
//

import UIKit

class PersonView: UIView {
    
    // MARK: - Subviews
    private(set) lazy var tableView = UITableView()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTableView()
        setupViews()
    }
    
    // MARK: - UI
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(PersonHeader.self, forHeaderFooterViewReuseIdentifier: PersonHeader.reuseId)
        tableView.register(ChaildTableViewCell.self, forCellReuseIdentifier: ChaildTableViewCell.reuseId)
        tableView.register(PersonFooter.self, forHeaderFooterViewReuseIdentifier: PersonFooter.reuseId)
    }
    
    func setupViews() {
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
