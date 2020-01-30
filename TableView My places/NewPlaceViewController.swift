//
//  NewPlaceViewController.swift
//  TableView My places
//
//  Created by Андрей Шевчук on 19.01.2020.
//  Copyright © 2020 Андрей Шевчук. All rights reserved.
//

import UIKit

class NewPlaceViewController: UITableViewController {


   
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var namePlace: UITextField!
    @IBOutlet weak var locationPlace: UITextField!
    @IBOutlet weak var typePlace: UITextField!
    
    override func viewDidLoad() {
      
        super.viewDidLoad()
        
        
        tableView.tableFooterView = UIView()
        saveButton.isEnabled = false
        namePlace.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        
    }
    
  
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: -  Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
           
            let actionSheet = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "Camera",
                                       style: .default) { (_) in
                                       self.chooseImagePicker(source: .camera)
            }
            let photo = UIAlertAction(title: "Photo",
                                      style: .default) { (_) in
                                      self.chooseImagePicker(source: .photoLibrary)
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            present(actionSheet, animated: true)
            
        }else{
            view.endEditing(true)
        }
    }
     func saveNewPlace(){
        
        
        let image = placeImage.image
        let imageData = image?.pngData()
        let newPlace = Place(name: namePlace.text!, location: locationPlace.text, type: typePlace.text, imageData: imageData)
        StorageManager.saveObject(newPlace)
        
        

    }
}


   // MARK: - textField delegate
    extension NewPlaceViewController: UITextFieldDelegate{
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        @objc private func textFieldChanged(){
            if namePlace.text?.isEmpty == false{
                saveButton.isEnabled = true
            }else{
                saveButton.isEnabled = false
            }
        }
        
    }

//MARK: - work with image
 
extension NewPlaceViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func chooseImagePicker(source: UIImagePickerController.SourceType){
        
        if UIImagePickerController.isSourceTypeAvailable(source){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        placeImage.image = info[.editedImage] as? UIImage
        placeImage.contentMode = .scaleToFill
        placeImage.clipsToBounds = true
        dismiss(animated: true, completion: nil)
    }
}

