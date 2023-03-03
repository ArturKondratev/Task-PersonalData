//
//  PersonHeader.swift
//  Task
//
//  Created by Артур Кондратьев on 26.10.2022.
//

import UIKit

protocol PersonHeaderDelegate: AnyObject {
    func addChild()
    func endEditPersonData(name: String?, age: String?)
}

class PersonHeader: UITableViewHeaderFooterView, UITextFieldDelegate {
    
    // MARK: - Properties
    static let reuseId = "PersonHeader"
    weak var delegate: PersonHeaderDelegate?
    
    // MARK: - Subviews
    let infoLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Персональные данные"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    let nameLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Имя"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    var textFieldName: UITextField = {
        let tf =  UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Введите имя"
        tf.autocapitalizationType = .sentences
        tf.clearButtonMode = .whileEditing
        tf.minimumFontSize = .leastNonzeroMagnitude
        let overlayButton = UIButton(type: .custom)
        tf.leftView = overlayButton
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
    
    var textFieldAge: UITextField = {
        let tf =  UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Введите возраст"
        tf.keyboardType = .numberPad
        tf.clearButtonMode = .whileEditing
        return tf
    }()
    
    let childLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Дети(макс.5)"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    let addButton: UIButton = {
        let addBt = UIButton(type: .system)
        addBt.translatesAutoresizingMaskIntoConstraints = false
        addBt.setTitle("+ Добавить ребенка", for: .normal)
        addBt.tintColor = .systemBlue
        addBt.backgroundColor = .clear
        addBt.layer.cornerRadius = 25
        addBt.layer.borderWidth = 2
        addBt.layer.borderColor = UIColor.systemBlue.cgColor
        addBt.addTarget(self, action: #selector(addChild), for: .touchUpInside)
        return addBt
    }()
    
    // MARK: - Init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setConstraints()
        textFieldName.delegate = self
        textFieldAge.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    @objc func addChild() {
        delegate?.addChild()
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.endEditPersonData(name: textFieldName.text,
                                    age: textFieldAge.text)
    }
    
    // MARK: - UI
    private func setConstraints() {
        contentView.addSubview(infoLable)
        contentView.addSubview(nameLable)
        contentView.addSubview(textFieldName)
        contentView.addSubview(ageLable)
        contentView.addSubview(textFieldAge)
        contentView.addSubview(childLable)
        contentView.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            
            infoLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            infoLable.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            
            nameLable.topAnchor.constraint(equalTo: infoLable.bottomAnchor, constant: 10),
            nameLable.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30),
            
            textFieldName.topAnchor.constraint(equalTo: nameLable.bottomAnchor, constant: 10),
            textFieldName.leftAnchor.constraint(equalTo: nameLable.leftAnchor),
            textFieldName.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            
            ageLable.topAnchor.constraint(equalTo: textFieldName.bottomAnchor, constant: 20),
            ageLable.leftAnchor.constraint(equalTo: nameLable.leftAnchor),
            
            textFieldAge.topAnchor.constraint(equalTo: ageLable.bottomAnchor, constant: 10),
            textFieldAge.leftAnchor.constraint(equalTo: ageLable.leftAnchor),
            textFieldAge.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            
            addButton.topAnchor.constraint(equalTo: textFieldAge.bottomAnchor, constant: 20),
            addButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            addButton.widthAnchor.constraint(equalToConstant: 200),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            
            childLable.centerYAnchor.constraint(equalTo: addButton.centerYAnchor),
            childLable.leftAnchor.constraint(equalTo: infoLable.leftAnchor)
        ])
    }
}

