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
    let pickerViewHeight: CGFloat = 200
    
    var pickerIndexPath :IndexPath?
    let underMargin: CGFloat = 40
    
    private let frequencyArray = ["440", "441", "442"]
    var baseFrequency = 440
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = self.view.frame.width
        let height = self.view.frame.height
        
        pickerView.frame = CGRect(x: 0, y: height, width: width, height: pickerViewHeight)
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = UIColor.white
        //pickerView.transform = CGAffineTransform(scaleX: 1, y: )
        self.view.addSubview(pickerView)
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let width = self.view.frame.width
        let height = self.view.frame.height
    
        pickerIndexPath = indexPath
        let index = frequencyArray.findIndex{$0 == String(baseFrequency)}
        pickerView.selectRow(index[0], inComponent: 0, animated: true)
        pickerView.reloadAllComponents()
        
        if indexPath.section == 0{
            UIView.animate(withDuration: 0.2, animations:{
                self.pickerView.frame = CGRect(x:0, y:height - self.pickerViewHeight, width:width, height:self.pickerViewHeight)}
        )
        }
        
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
    
    /*@objc func doneTapped() {
        
        UIView.animate(withDuration: 0.2) {
            let width = self.view.frame.width
            let height = self.view.frame.height
            
            self.pickerView.frame = CGRect(x: 0, y: height + self.pickerToolBarHeight, width: width, height: self.pickerViewHeight)
            self.pickerToolBar.frame = CGRect(x: 0, y: height, width: width, height: self.pickerToolBarHeight)
        }
        print(pickerView.frame)
        print(pickerToolBar.frame)
        print(self.view.frame)
    }*/
}

extension Array {
    func findIndex(includeElement: (Element) -> Bool) -> [Int] {
        var indexArray:[Int] = []
        for (index, element) in enumerated() {
            if includeElement(element) {
                indexArray.append(index)
            }
        }
        return indexArray
    }
}
