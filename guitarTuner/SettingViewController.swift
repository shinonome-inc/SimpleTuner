//
//  SettingViewController.swift
//  guitarTuner
//
//  Created by 大谷悦志 on 2019/06/25.
//  Copyright © 2019 大谷悦志. All rights reserved.
//

import Foundation
import UIKit

class SettingViewController: UITableViewController {
    
    let pickerView = UIPickerView()
    let pickerViewHeight: CGFloat = 400
    let pickerToolBar = UIToolbar()
    let pickerToolBarHeight: CGFloat = 30
    
    var pickerIndexPath :IndexPath?
    
    private let frequencyArray = ["440", "441", "442"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = self.view.frame.width
        let height = self.view.frame.height
        
        pickerView.frame = CGRect(x: 0, y: height + pickerToolBarHeight, width: width, height: pickerViewHeight)
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = UIColor.white
        self.view.addSubview(pickerView)
        
        pickerToolBar.frame = CGRect(x: 0, y: height, width: width, height: pickerToolBarHeight)
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneBtn = UIBarButtonItem(title: "完了", style: .plain, target: self, action: #selector(self.doneTapped))
        pickerToolBar.items = [flexible,doneBtn]
        self.view.addSubview(pickerToolBar)
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let width = self.view.frame.width
        let height = self.view.frame.height
    
        pickerIndexPath = indexPath
        pickerView.reloadAllComponents()
        
        UIView.animate(withDuration: 0.2, animations:{
            self.pickerToolBar.frame = CGRect(x:0, y:height - self.pickerViewHeight - self.pickerToolBarHeight, width:width, height:self.pickerToolBarHeight)
            self.pickerView.frame = CGRect(x:0, y:height - self.pickerViewHeight, width:width, height:self.pickerViewHeight)}
        )
        
        
        
        print(pickerView.frame)
        print(pickerToolBar.frame)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension SettingViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return frequencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return frequencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        guard let pickerIndexPath = pickerIndexPath else {
            return
        }
        let cell = tableView.cellForRow(at:pickerIndexPath )
        cell?.detailTextLabel?.text = "\(frequencyArray[row])Hz"
    }
    
    @objc func doneTapped() {
        
        UIView.animate(withDuration: 0.2) {
            let width = self.view.frame.width
            let height = self.view.frame.height
            
            self.pickerView.frame = CGRect(x: 0, y: height + self.pickerToolBarHeight, width: width, height: self.pickerViewHeight)
            self.pickerToolBar.frame = CGRect(x: 0, y: height, width: width, height: self.pickerToolBarHeight)
        }
        print(pickerView.frame)
        print(pickerToolBar.frame)
        print(self.view.frame)
    }
}


