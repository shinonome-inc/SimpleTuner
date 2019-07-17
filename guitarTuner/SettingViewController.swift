//
//  SettingViewController.swift
//  guitarTuner
//
//  Created by 大谷悦志 on 2019/06/25.
//  Copyright © 2019 大谷悦志. All rights reserved.
//

import UIKit

class SettingViewController: UITableViewController {
    
    let pickerView = UIPickerView()
    let pickerViewHeight: CGFloat = 300
    var pickerIndexPath :IndexPath?
    private let frequencyArray = ["440", "441", "442"]
    
    @IBOutlet weak var baseFrequencyLable: UILabel!
    @IBOutlet weak var clearView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = self.view.frame.width
        let height = self.view.frame.height
        
        //関係ないとこタッチでpickerが閉じるよ。ハイライトも解除するよ
        clearView.isUserInteractionEnabled = true
        clearView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapView)))
        
        pickerView.frame = CGRect(x: 0, y: height, width: width, height: pickerViewHeight)
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = UIColor.white
        self.view.addSubview(pickerView)
        
        let baseFrequencyText = String(format: "%.0f", Pitch.baseFrequency)
        baseFrequencyLable.text = baseFrequencyText + "Hz"
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let width = self.view.frame.width
        let height = self.view.frame.height
    
        pickerIndexPath = indexPath
        //現在の値までpickerが回転
        let baseFrequencyText = String(format: "%.0f", Pitch.baseFrequency)
        let selectedIndex = frequencyArray.index(of: baseFrequencyText)
        guard let index = selectedIndex else {
            return
        }
        pickerView.selectRow(index, inComponent: 0, animated: true)
        pickerView.reloadAllComponents()
        //湧き出すpicker
        if indexPath.section == 0 {
            UIView.animate(withDuration: 0.2, animations: {
                self.pickerView.frame = CGRect(x:0, y:height - self.pickerViewHeight, width:width, height:self.pickerViewHeight)
                })
        }
        
    }
    //
    @objc func tapView(sender: UITapGestureRecognizer) {
        let width = self.view.frame.width
        let height = self.view.frame.height
        
        //ハイライト解除
        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
        //沈むpicker
        UIView.animate(withDuration: 0.2, animations: {
            self.pickerView.frame = CGRect(x: 0, y: height, width: width, height: self.pickerViewHeight)
        })
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
        
        guard let baseFrequency = Double(frequencyArray[row]) else {
            return
        }
        
        Pitch.baseFrequency = baseFrequency
        let baseFrequencyText = String(format: "%.0f", Pitch.baseFrequency)
        baseFrequencyLable.text = baseFrequencyText + "Hz"
    }
    
}
