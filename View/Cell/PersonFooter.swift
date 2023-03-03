//
//  PersonFooter.swift
//  Task
//
//  Created by Артур Кондратьев on 26.10.2022.
//

import UIKit

protocol PersonFooterDelegate: AnyObject {
    func deleteAll()
}

class PersonFooter: UITableViewHeaderFooterView {
    
    // MARK: - Properties
    static let reuseId = "PersonFooter"
    weak var delegate: PersonFooterDelegate?
    
    // MARK: - Subviews
    let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Очистить", for: .normal)
        button.tintColor = .red
        button.backgroundColor = .clear
        button.layer.cornerRadius = 30
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.red.cgColor
        button.addTarget(self, action: #selector(deleteAll), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    @objc func deleteAll() {
        delegate?.deleteAll()
    }
    
    // MARK: - UI
    func setConstraints() {
        contentView.addSubview(deleteButton)
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10),
            deleteButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 80),
            deleteButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -80)
        ])
    }
}
