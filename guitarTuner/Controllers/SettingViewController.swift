//
//  SettingViewController.swift
//  guitarTuner
//
//  Created by 大谷悦志 on 2019/06/25.
//  Copyright © 2019 大谷悦志. All rights reserved.
//

import UIKit
import RxSwift
import XLPagerTabStrip
import MessageUI

class SettingViewController: UITableViewController {
    
    @IBOutlet weak var baseFrequencyLable: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var appVersionLabel: UILabel!
    @IBOutlet weak var clearView: UIView!
    
    let pickerView = UIPickerView()
    let pickerViewHeight: CGFloat = 300
    var pickerIndexPath: IndexPath?
    var photoLibraryManager: PhotoLibraryManager?
    let defaults = UserDefaults.standard
    let disposeBag = DisposeBag()
    private let frequencyArray = ["440", "441", "442"]
    private let toRecipients = ["324etsushi@gmail.com"]
    private let mailSubject = "Feedback（SimpleTuner）"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //photoLibraryManager = PhotoLibraryManager(parentViewController: self)
        dataBind()
        setup()
    }
    
    func dataBind() {
        UserInfo.shared.colorEvent.subscribe(onNext: {
            color in
            self.colorLabel.text = color.name
        }).disposed(by: disposeBag)
    }
    
    func setup() {
        //view
        let width = self.view.frame.width
        let height = self.view.frame.height
        
        clearView.isUserInteractionEnabled = true
        clearView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapView)))
        pickerView.frame = CGRect(x: 0, y: height, width: width, height: pickerViewHeight)
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = UIColor.clear
        pickerView.setValue(UIColor.mainTextColor, forKey: "textColor")
        self.view.addSubview(pickerView)
        
        //label
        let baseFrequencyText = String(format: "%.0f", Pitch.baseFrequency)
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        baseFrequencyLable.text = baseFrequencyText + "Hz"
        appVersionLabel.text = version
        
        //notification
        NotificationCenter.default.addObserver(self, selector: #selector(SettingViewController.appBecomeActive(_:)), name: UIApplication.didBecomeActiveNotification, object: nil)
        
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
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                UIView.animate(withDuration: 0.2, animations: {
                self.pickerView.frame = CGRect(x:0, y:height - self.pickerViewHeight, width:width, height:self.pickerViewHeight)
                })
            //case 1:
                //photoLibraryManager?.callPhotoLibrary()
            default :
                return
            }
        } else if indexPath.section == 1 {
            switch indexPath.row {
            case 1:
                guard let reviewURL = URL(string: "https://apps.apple.com/app/id1563149768?action=write-review") else {
                    return
                }
                UIApplication.shared.open(reviewURL, options: [:], completionHandler: nil)
            case 2:
                if MFMailComposeViewController.canSendMail() == false {
                    return
                }
                presentMailView()
            default:
                return
            }
        }
    }
    
    //レビューから戻ってきた際のCellのハイライト解除用
    @objc func appBecomeActive(_ notification: Notification) {
        deselctCell()
    }
    
    @objc func tapView(sender: UITapGestureRecognizer) {
        let width = self.view.frame.width
        let height = self.view.frame.height
        
        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
    
        UIView.animate(withDuration: 0.2, animations: {
            self.pickerView.frame = CGRect(x: 0, y: height, width: width, height: self.pickerViewHeight)
        })
    }
    
    func presentMailView() {
        let mailViewController = MFMailComposeViewController()
        mailViewController.mailComposeDelegate = self
        mailViewController.setSubject(mailSubject)
        mailViewController.setToRecipients(toRecipients)
        self.present(mailViewController, animated: true, completion: nil)
    }
    
    func deselctCell() {
        guard let indexPathForSelectedRow = tableView.indexPathForSelectedRow else {
            return
        }
        tableView.deselectRow(at: indexPathForSelectedRow, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension SettingViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            print("##### Email send Cancelld #####")
        case .sent:
            print("##### Email sent successfully #####")
        case .failed:
            print("##### Email send faild #####")
        case .saved:
            print("##### Email saved #####")
        }
        controller.dismiss(animated: true, completion: {
            self.deselctCell()
        })
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

extension SettingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        defaults.setUIImageToData(image: image, forKey: "backgroundImage")
    }
}

extension SettingViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        let info = IndicatorInfo(title: "Settings", image: UIImage(named: "cog")?.withRenderingMode(.alwaysTemplate))
        return info
    }
}
