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
    
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var appVersionLabel: UILabel!
    
    var photoLibraryManager: PhotoLibraryManager?
    let defaults = UserDefaults.standard
    let disposeBag = DisposeBag()
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
        //label
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        appVersionLabel.text = version
        
        //notification
        NotificationCenter.default.addObserver(self, selector: #selector(SettingViewController.appBecomeActive(_:)), name: UIApplication.didBecomeActiveNotification, object: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
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
        deselectCell()
    }
    
    func presentMailView() {
        let mailViewController = MFMailComposeViewController()
        mailViewController.mailComposeDelegate = self
        mailViewController.setSubject(mailSubject)
        mailViewController.setToRecipients(toRecipients)
        self.present(mailViewController, animated: true, completion: nil)
    }
    
    func deselectCell() {
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
            self.deselectCell()
        })
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
        let info = IndicatorInfo(title: "Settings", image: UIImage(named: "cog")?.withRenderingMode(.alwaysTemplate), userInfo: Mode.none)
        return info
    }
}
