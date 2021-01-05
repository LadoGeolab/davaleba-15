//
//  ViewController.swift
//  davaleba-15
//
//  Created by Ladolado3911 on 12/29/20.
//

import UIKit
import Photos

class ViewController: UIViewController {
    
    let scrollDirection: UICollectionView.ScrollDirection = .vertical
    //let minLineSpacing: CGFloat = 10
    let itemsInRow: CGFloat = 3
    
    var editingMode: Bool = true
    
    @IBOutlet weak var collectView: UICollectionView!
    var database = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectView.dataSource = self
        collectView.delegate = self
        
        for a in 0..<5 {
            database.append(UIImage(named: "\(a + 1).jpg")!)
        }
        
        self.navigationItem.setRightBarButton(UIBarButtonItem(title: "წაშლა", style: .plain, target: self, action: #selector(act)), animated: true)
        
        self.navigationItem.setLeftBarButton(UIBarButtonItem(title: "დამატება", style: .plain, target: self, action: #selector(allowAccessToPhotos)), animated: true)
    }
    
    @objc func act(_ sender: UIBarButtonItem) {
        collectView.isEditing = !collectView.isEditing
        sender.title = sender.title == "წაშლა" ? "მზადაა" : "წაშლა"
        editingMode = sender.title == "წაშლა" ? true : false
        collectView.reloadData()
    }
    
    @objc func allowAccessToPhotos(_ sender: UIBarButtonItem) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        //vc.allowsEditing = true
        present(vc, animated: true)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return database.count
        //return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let cell_editable = cell as? CollectCell
        
        cell_editable!.indexPath = indexPath
        cell_editable!.colview = collectionView
        
        cell_editable?.layer.borderColor = UIColor.black.cgColor
        cell_editable?.layer.borderWidth = 1
        
        cell_editable!.delegate = self
        cell_editable!.btn.isHidden = editingMode

        cell_editable?.imageView!.image = database[indexPath.item]
        cell_editable?.imageView!.contentMode = .scaleAspectFill

        //let layout = collectView.collectionViewLayout as? UICollectionViewFlowLayout
    
        return cell_editable!
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController2") as? ViewController2
        vc2?.image = database[indexPath.item]
        vc2?.database = database
        vc2?.index = indexPath.item
        self.navigationController?.pushViewController(vc2!, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension ViewController: EditDatabase {
    func editDatabase(indexPath index: IndexPath) {
        database.remove(at: index.item)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectView.frame.width * 0.33)
        let height = width
        
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.minimumInteritemSpacing = 0
        layout?.minimumLineSpacing = 2
        
        
        return CGSize(width: width, height: height)
        
        
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //print("\(info)")
        let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")] as? UIImage
        picker.dismiss(animated: true) {
            self.database.append(image!)
            self.collectView.reloadData()
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}



