//
//  MainViewController.swift
//  MVC_Architecture
//
//  Created by mac on 17/09/2023.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private var loadButton: UIButton!
    private var tableView: UITableView!
    private var list = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadData(notification:)),
                                               name: NSNotification.Name(rawValue: Utilities.GetMoviesSuccessNotification),
                                               object: nil)
        
        setupUI()
        setupContraint()
    }
    
    private func setupUI() {
        loadButton = UIButton()
        loadButton.backgroundColor = UIColor.black
        loadButton.setTitle("Get Books", for: .normal)
        loadButton.addTarget(self, action: #selector(loadMovies), for: .touchUpInside)
        
        tableView = UITableView()
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieTableViewCell")
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.separatorInset = .zero
        tableView.backgroundColor = .lightGray
        tableView.contentInset = .init(top: 0, left: 0, bottom: 50, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
        
        self.view.addSubview(loadButton)
        self.view.addSubview(tableView)
    }
    
    private func setupContraint() {
        let frameWidth: CGFloat = UIScreen.main.bounds.width
        let frameHeight: CGFloat = UIScreen.main.bounds.height
        
        loadButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 128, height: 48))
            make.centerX.equalToSuperview()
            make.top.equalTo(48)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(loadButton.snp.bottom).offset(24)
            make.size.equalTo(CGSize(width: frameWidth, height: frameHeight))
        }
    }
    
    @objc func loadMovies() {
        ApiFetchHandler.sharedInstance.fetchAPIData()
    }
    
    @objc func reloadData(notification: Notification) {
        if let list = notification.userInfo?["movie"] as? [Movie] {
            self.list = list
            self.tableView.reloadData()
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        let movie = self.list[indexPath.row]
        cell.selectionStyle = .none
        cell.configure(movie: movie)
        return cell
    }
}
