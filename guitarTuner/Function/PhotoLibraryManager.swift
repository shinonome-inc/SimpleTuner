//
//  PhotoLibraryManager.swift
//  guitarTuner
//
//  Created by 大谷悦志 on 2020/05/05.
//  Copyright © 2020 大谷悦志. All rights reserved.
//

import Photos
import UIKit

struct PhotoLibraryManager {
    
    var parentViewController: UIViewController!
    
    init(parentViewController: UIViewController) {
        self.parentViewController = parentViewController
    }
    
    func requestAuthorization() {
        
        let status = PHPhotoLibrary.authorizationStatus()
        if (status == PHAuthorizationStatus.denied) {
            let alert = UIAlertController(title: "addmition to accece photo library", message:
                "you need to admit the accece to the photo library. Please change settings. ", preferredStyle: .alert)
            let settingAction = UIAlertAction(title: "change settings", style: .default)
            { (_) -> Void in
                guard let _ = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
            }
            alert.addAction(settingAction)
            alert.addAction(UIAlertAction(title: "cancel", style: .cancel) { _ in
                })
            self.parentViewController.present(alert, animated: true)
        }
    }
    
    func callPhotoLibrary() {
        requestAuthorization()
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            let picker = UIImagePickerController()
            picker.modalPresentationStyle = UIModalPresentationStyle.popover
            picker.delegate = self.parentViewController as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            picker.sourceType = UIImagePickerController.SourceType.photoLibrary
            
            if let popover = picker.popoverPresentationController {
                popover.sourceView = self.parentViewController.view
                popover.sourceRect = self.parentViewController.view.frame
                popover.permittedArrowDirections = UIPopoverArrowDirection.any
            }
            self.parentViewController.present(picker, animated: true, completion: nil)
        }
    }
}

extension UserDefaults {
    
    func setUIImageToData(image: UIImage, forKey: String) {
        let data = image.pngData()
        self.set(data, forKey: forKey)
    }
    
    func userDefaultImage(forKey: String) -> UIImage?{
        guard let data = self.data(forKey: forKey) else {
            return nil
        }
        guard let image = UIImage(data: data) else {
            return nil
        }
        return image
    }
}
