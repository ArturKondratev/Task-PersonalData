//
//  ViewController.swift
//  Task
//
//  Created by Артур Кондратьев on 26.10.2022.
//

import UIKit

class PersonViewController: UIViewController {
    
    // MARK: - Private Properties
    var parentName: String?
    var parentAge: Int?
    var parentChilds = [ChildModel]()
    private var tapGest: UITapGestureRecognizer?
    private var personView: PersonView {
        return self.view as! PersonView
    }
    
    //MARK: - LifeCycle
    override func loadView() {
        self.view = PersonView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        personView.tableView.delegate = self
        personView.tableView.dataSource =  self
        tapGest = UITapGestureRecognizer(target: self, action: #selector(endEditingFunc))
        personView.addGestureRecognizer(tapGest!)
    }
    
    //MARK: - Function
    @objc func endEditingFunc() {
        self.view.endEditing(true)
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension PersonViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parentChilds.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 240
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChaildTableViewCell.reuseId, for: indexPath) as? ChaildTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        cell.selectionStyle = .none
        cell.configure(child: parentChilds[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: PersonHeader.reuseId) as? PersonHeader else { return UITableViewHeaderFooterView() }
        header.delegate = self
        
        if let name = parentName {
            header.textFieldName.text = name
        } else {
            header.textFieldName.text = ""
        }
        
        if let age = parentAge {
            header.textFieldAge.text = String("\(age)")
        } else {
            header.textFieldAge.text = ""
        }
        
        if parentChilds.count == 4 {
            header.addButton.isHidden = true
        } else {
            header.addButton.isHidden = false
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: PersonFooter.reuseId) as? PersonFooter
        footer!.delegate = self
        
        if parentChilds.count == 0 {
            footer?.deleteButton.isHidden = true
        } else {
            footer?.deleteButton.isHidden = false
        }
        return footer
    }
}

extension PersonViewController: PersonHeaderDelegate, PersonFooterDelegate, ChaildTableViewCellDelegate {
    
    //MARK: - ChaildTableViewCellDelegate
    func deleteChild(from cell: UITableViewCell) {
        guard let indexPath = personView.tableView.indexPath(for: cell) else { return }
        let row = indexPath.row
        self.parentChilds.remove(at: row)
        DispatchQueue.main.async {
            self.personView.tableView.reloadData()
        }
    }
    
    //MARK: - PersonHeaderDelegate
    func endEditPersonData(name: String?, age: String?) {
        if let name = name {
            self.parentName = name
        }
        if let age = age {
            self.parentAge = Int(age)
        }
        DispatchQueue.main.async {
            self.personView.tableView.reloadData()
        }
    }
    
    func addChild() {
        let alertController = UIAlertController(title: "Введите имя и возрост ребенка",
                                                message: nil,
                                                preferredStyle: .alert)
        alertController.addTextField()
        alertController.textFields?[0].keyboardType = .namePhonePad
        alertController.textFields?[0].placeholder = "Имя"
        alertController.addTextField()
        alertController.textFields?[1].keyboardType = .numberPad
        alertController.textFields?[1].placeholder = "Возраст"
        
        let allertOK = UIAlertAction(title: "Сохранить", style: .default) { (action) in
            let childName = alertController.textFields?[0].text
            let childAge = alertController.textFields?[1].text
            guard let name = childName, let age = Int(childAge!) else { return }
            let newChild = ChildModel(name: name, age: age)
            self.parentChilds.append(newChild)
            DispatchQueue.main.async {
                self.personView.tableView.reloadData()
            }
        }
        
        let alertCancel = UIAlertAction(title: "Отмена", style: .cancel)
        alertController.addAction(allertOK)
        alertController.addAction(alertCancel)
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - PersonFooterDelegate
    func deleteAll() {
        let actionSheet = UIAlertController(title: .none, message: .none, preferredStyle: .actionSheet)
        
        let deleteAll = UIAlertAction(title: "Сбросить данные", style: .destructive) { _ in
            self.parentChilds.removeAll()
            self.parentAge = nil
            self.parentName = nil
            DispatchQueue.main.async {
                self.personView.tableView.reloadData()
            }
        }
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        actionSheet.addAction(deleteAll)
        actionSheet.addAction(cancel)
        present(actionSheet, animated: true, completion: nil)
    }
}
