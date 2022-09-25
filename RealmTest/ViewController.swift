//
//  ViewController.swift
//  RealmTest
//
//  Created by クワシマ・ユウキ on 2022/09/26.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "test")!
        
        let filename = UUID.init().uuidString + ".jpg"
        image.saveToDocuments(filename: filename)
        
        let newImage = UIImage.getFromDocuments(filename: filename)
        imageView.image = newImage
    }
}

extension UIImage {
    func saveToDocuments(filename:String){
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent(filename)
        if let data = self.jpegData(compressionQuality: 1.0) {
            do {
                try data.write(to: fileURL)
            } catch {
                print(error)
            }
        }
    }
    static func getFromDocuments(filename: String) -> UIImage {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let data = try! Data(contentsOf: documentsDirectory.appendingPathComponent(filename))
        let image = UIImage(data: data)
        return image!
    }
}
