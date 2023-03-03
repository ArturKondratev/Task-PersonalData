//
//  ChaildTableViewCell.swift
//  Task
//
//  Created by Артур Кондратьев on 26.10.2022.
//

import UIKit

protocol ChaildTableViewCellDelegate: AnyObject {
    func deleteChild(from cell: UITableViewCell)
}

class ChaildTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let reuseId = "ChaildTableViewCell"
    weak var delegate: ChaildTableViewCellDelegate?
    
    // MARK: - Subviews
    let nameLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Имя"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let tfName: UITextField = {
        let tf =  UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Введите имя"
        tf.autocapitalizationType = .sentences
        return tf
    }()
    
    let ageLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Возраст"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let tfAge: UITextField = {
        let tf =  UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Введите возраст"
        tf.keyboardType = .numberPad
        return tf
    }()
    
    let deleteButton: UIButton = {
        let delBt = UIButton(type: .system)
        delBt.translatesAutoresizingMaskIntoConstraints = false
        delBt.setTitle("Удалить", for: .normal)
        delBt.image(for: .normal)
        delBt.backgroundColor = .clear
        delBt.addTarget(self, action: #selector(deleteChild), for: .touchUpInside)
        return delBt
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = .clear
    }
    
    // MARK: - Methods
    func configure(child: ChildModel) {
        tfName.text = child.name
        tfAge.text = String("\(child.age)")
    }
    
    @objc func deleteChild() {
        delegate?.deleteChild(from: self)
    }
    
    // MARK: - UI
    private func setConstraints() {
        contentView.addSubview(nameLable)
        contentView.addSubview(tfName)
        contentView.addSubview(ageLable)
        contentView.addSubview(tfAge)
        contentView.addSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            nameLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLable.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30),
            
            tfName.topAnchor.constraint(equalTo: nameLable.bottomAnchor, constant: 10),
            tfName.leftAnchor.constraint(equalTo: nameLable.leftAnchor),
            tfName.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            
            ageLable.topAnchor.constraint(equalTo: tfName.bottomAnchor, constant: 20),
            ageLable.leftAnchor.constraint(equalTo: nameLable.leftAnchor),
            
            tfAge.topAnchor.constraint(equalTo: ageLable.bottomAnchor, constant: 10),
            tfAge.leftAnchor.constraint(equalTo: ageLable.leftAnchor),
            tfAge.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            
            deleteButton.topAnchor.constraint(equalTo: nameLable.bottomAnchor),
            deleteButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20)
        ])
    }
}
