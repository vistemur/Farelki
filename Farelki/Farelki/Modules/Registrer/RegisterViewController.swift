//
//  RegisterViewController.swift
//  Farelki
//
//  Created by роман поздняков on 07/04/2019.
//  Copyright © 2019 romchick. All rights reserved.
//

import UIKit

enum ImageSource {
    case photoLibrary
    case camera
}

final class RegisterViewController: UIViewController, UINavigationControllerDelegate {
    
    private let xibFileName = "RegisterViewController"
    private var imagePicker: UIImagePickerController!
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var photoButton: UIButton!
    @IBOutlet private weak var NameTextField: UITextField!
    
    init() {
        super.init(nibName: xibFileName,
                   bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setGestureRecognizer()
        configureUI()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        PersistanceService.firstEntry = true
    }
    
    @IBAction func photoButtonPressed(_ sender: UIButton) {
        showPhotoAlert()
    }
    
    @IBAction func applyButtonPressed(_ sender: UIButton) {
        UserDefaults.standard.set(NameTextField.text, forKey: "name")
        dismiss(animated: false)
    }
    
}

// MARK: - UI
extension RegisterViewController {
    
    private func showPhotoAlert() {
       
        let alertController = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(
            title: "take photo",
            style: .default) { [weak self] _ in
                self?.selectImageFrom(.camera)
        }
        let galleryAction = UIAlertAction(
            title: "choose from gallery",
            style: .default) { [weak self] _ in
                self?.selectImageFrom(.photoLibrary)
        }
        let cancelAction = UIAlertAction(title:"Cancel",
                                         style: .cancel)
        alertController.addAction(cameraAction)
        alertController.addAction(galleryAction)
        alertController.addAction(cancelAction)
        present(alertController,
                animated: true)
    }
    
    private func configureUI() {
        configureAvatarImageView()
        configurePhotoButton()
        configureNameLabel()
        configureImage()
    }
    
    private func configureAvatarImageView() {
        let cornerRadius =  photoButton.frame.height / 2
        avatarImageView.layer.cornerRadius = cornerRadius
    }
    
    private func configureImage() {
        avatarImageView.image = loadImageFromDiskWith(fileName: "avatar")
    }
    
    private func configureNameLabel() {
        let name = UserDefaults.standard.object(forKey: "name") ?? ""
        NameTextField.text = name as? String
    }
    
    private func configurePhotoButton() {
        let cornerRadius =  photoButton.frame.height / 2
        let inset: CGFloat = 15 / 76 * photoButton.frame.height
        photoButton.layer.cornerRadius = cornerRadius
        photoButton.contentEdgeInsets.bottom = inset
        photoButton.contentEdgeInsets.top = inset
        photoButton.contentEdgeInsets.left = inset
        photoButton.contentEdgeInsets.right = inset
    }
    
}

extension RegisterViewController: UIImagePickerControllerDelegate {
    
    func selectImageFrom(_ source: ImageSource) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        switch source {
        case .camera:
            imagePicker.sourceType = .camera
        case .photoLibrary:
            imagePicker.sourceType = .photoLibrary
        }
        present(imagePicker,
                animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true,
                            completion: nil)
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("Image not found!")
            return
        }
        avatarImageView.image = selectedImage
        // here we save selectedImage
        saveImage(imageName: "avatar", image: selectedImage)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true,
                completion: nil)
    }
    
}

// MARK: - UIGestureRecognizerDelegate
extension RegisterViewController: UIGestureRecognizerDelegate {
    
    private func setGestureRecognizer() {
        let gestureRecognizer = UITapGestureRecognizer(target: self,
                                                       action: #selector(pressEmptySpaceAction(gesture:)))
        gestureRecognizer.delegate = self
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc private func pressEmptySpaceAction(gesture: UITapGestureRecognizer) {
        let touchPoint = gesture.location(in: view)
        if !NameTextField.point(inside: touchPoint, with: nil) {
            NameTextField.resignFirstResponder()
        }
    }
}

func saveImage(imageName: String, image: UIImage) {
    
    guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
    
    let fileName = imageName
    let fileURL = documentsDirectory.appendingPathComponent(fileName)
    guard let data = image.jpegData(compressionQuality: 1) else { return }
    
    //Checks if file exists, removes it if so.
    if FileManager.default.fileExists(atPath: fileURL.path) {
        do {
            try FileManager.default.removeItem(atPath: fileURL.path)
            print("Removed old image")
        } catch let removeError {
            print("couldn't remove file at path", removeError)
        }
        
    }
    
    do {
        try data.write(to: fileURL)
    } catch let error {
        print("error saving file with error", error)
    }
    
}



func loadImageFromDiskWith(fileName: String) -> UIImage? {
    
    let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
    
    let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
    let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
    
    if let dirPath = paths.first {
        let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
        let image = UIImage(contentsOfFile: imageUrl.path)
        return image
    }
    
    return nil
}

