//
//  SelectColorViewController.swift
//  guitarTuner
//
//  Created by 大谷悦志 on 2021/01/22.
//  Copyright © 2021 大谷悦志. All rights reserved.
//

import UIKit
import RxSwift

class SelectColorViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var baseColor: ThemeColor = .blue
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        dataBind()
    }
    
    func dataBind() {
        UserInfo.shared.colorEvent.subscribe(onNext: {
            color in
            self.baseColor = color
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: "ColorCell", bundle: nil), forCellReuseIdentifier: "ColorCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension SelectColorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ThemeColor.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ColorCell", for: indexPath) as! ColorCell
        guard let color = ThemeColor.init(rawValue: indexPath.row) else {
            return cell
        }
        if indexPath.row == baseColor.rawValue {
            cell.checkImageView.isHidden = false
        } else {
            cell.checkImageView.isHidden = true
        }
        cell.colorLabel.text = color.name
        cell.mainColorView.backgroundColor = color.main
        cell.subColorView.backgroundColor = color.sub
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let color = ThemeColor.init(rawValue: indexPath.row) else {
            return
        }
        UserInfo.shared.setColor(color: color)
        self.navigationController?.navigationBar.barTintColor = color.tab
    }
}
