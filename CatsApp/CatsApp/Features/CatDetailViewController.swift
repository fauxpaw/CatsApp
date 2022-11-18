//
//  CatDetailViewController.swift
//  CatsApp
//
//  Created by Michael Sweeney on 11/18/22.
//

import UIKit

class CatDetailViewController: UIViewController {
    
    @IBOutlet weak var originalImageView: UIImageView!
    @IBOutlet weak var previewImageView: UIImageView!
    
    var image: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (image != nil) {
            originalImageView.image = image
            previewImageView.image = image
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print(error.localizedDescription)
        } else {
            print("save succesful")
        }
    }
    
    @IBAction func sepiaFilterTapped(_ sender: Any) {
        let context = CIContext()
        guard let sepiaFilter = CIFilter(name:FilterType.sepia.rawValue) else { return }
        guard let img = self.previewImageView.image else { return }
        guard let inputImage = CIImage(image: img) else { return }
        sepiaFilter.setValue(inputImage, forKey: kCIInputImageKey)
        sepiaFilter.setValue(0.9, forKey: kCIInputIntensityKey)
        guard let sepiaImage = sepiaFilter.outputImage else { return }
        guard let output = context.createCGImage(sepiaImage, from: inputImage.extent) else { return }
        self.previewImageView.image = UIImage(cgImage: output)
        
    }
    
    @IBAction func noirFilterTapped(_ sender: Any) {
        let context = CIContext()
        guard let noirFilter = CIFilter(name: FilterType.noir.rawValue) else { return }
        guard let img = self.previewImageView.image else { return }
        guard let inputImage = CIImage(image: img) else { return }
        noirFilter.setValue(inputImage, forKey: kCIInputImageKey)
        guard let noirImage = noirFilter.outputImage else { return }
        guard let output = context.createCGImage(noirImage, from: inputImage.extent) else { return }
        self.previewImageView.image = UIImage(cgImage: output)
    }
    
    @IBAction func savePhotoTapped(_ sender: Any) {
        
        guard let image = previewImageView.image else { return }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.saveCompleted), nil)
        self.dismiss(animated: true)
    }
    
    @IBAction func revertImageTapped(_ sender: Any) {
        self.previewImageView.image = image
    }
    
}
