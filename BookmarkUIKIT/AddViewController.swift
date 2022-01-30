//
//  AddViewController.swift
//  BookmarkUIKIT
//
//  Created by Aisaule Sibatova on 27.01.2022.
//

import UIKit

class AddViewController: UIViewController {
    
    private var bookMarks = [BookMarkProtocol]()
    var userDefaults = UserDefaults.standard
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Save your first bookmark"
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add bookmark", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside )
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        return button
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private func checkList() {
        if bookMarks.isEmpty {
            tableView.isHidden = true
            label.isHidden = false
        } else {
            tableView.isHidden = false
            label.isHidden = true
        }
    }
    
    let cellIdentifier = "cellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setTableView()
        addButton()
        //loadBookmarks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if bookMarks.count == 0 {
            showLabel()
        }
        if bookMarks.count > 0 
        {
            label.text = ""
        }
    }
    
    private func addButton(){
        
        view.addSubview(button)
    
        button.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(view.snp.bottom).offset(-50)
        }
    }
    
    private func showLabel() {
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    func setTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func buttonAction(){
        displayAlert()
    }
    
    func displayAlert(){
        let alertView = UIAlertController(title: "Change", message: nil, preferredStyle: .alert)
        alertView.addTextField(configurationHandler: { textField in textField.placeholder = "Bookmark title"})
        alertView.addTextField(configurationHandler: { textField in textField.placeholder = "Bookmark link(URL)"})

        let save = UIAlertAction(title: "Save", style: .default) {[weak alertView] _ in
            guard let textFields = alertView?.textFields else { return }
            if let title = textFields[0].text, let uri = textFields[1].text {
                let bookMark = BookMarks(title: title, url: uri)
                self.bookMarks.append(bookMark)
                self.tableView.reloadData()
                
            }

        }
        alertView.addAction(save)
        self.present(alertView, animated: true, completion: nil)
    }
    
    func changeAlert(index :Int){
        let alertView = UIAlertController(title: "Change", message: nil, preferredStyle: .alert)
        alertView.addTextField(configurationHandler: { textField in textField.placeholder = "Bookmark title"})
        alertView.addTextField(configurationHandler: { textField in textField.placeholder = "Bookmark link(URL)"})

        let save = UIAlertAction(title: "Save", style: .default) {[weak alertView] _ in
            guard let textFields = alertView?.textFields else { return }
            if let title = textFields[0].text, let uri = textFields[1].text {
                let bookMark = BookMarks(title: title, url: uri)
                self.bookMarks[index].title = bookMark.title
                self.bookMarks[index].url = bookMark.url
                
                self.tableView.reloadData()
            }
        }
        alertView.addAction(save)
        self.present(alertView, animated: true, completion: nil)
    }
    
    
    private func loadBookmarks() {
        bookMarks.append(BookMarks(title: "google", url: "www.google.com"))
//        bookMarks.append(BookMarks(title: "yandex", uri: "www.yandex.ru"))
//        bookMarks.append(BookMarks(title: "egov", uri: "www.egov.kz"))
    }
}

extension AddViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CustomTableViewCell else {return UITableViewCell()}
        cell.configure(name: bookMarks[indexPath.row].title )
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookMarks.count
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionDelete = UIContextualAction(style: .destructive, title: "Delete"){
            _,_,_ in
            self.bookMarks.remove(at: indexPath.row)
            tableView.reloadData()
        }
        
        let actionChange = UIContextualAction(style: .normal, title: "Change"){_,_,_ in
            self.changeAlert(index: indexPath.row)
            tableView.reloadData()
        }
        let actions = UISwipeActionsConfiguration(actions: [actionDelete, actionChange])
        return actions
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let link = bookMarks[indexPath.row].url
        if let url = URL(string: link){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
