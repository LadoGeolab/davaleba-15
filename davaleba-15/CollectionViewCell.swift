//
//  CollectionViewCell.swift
//  davaleba-15
//
//  Created by Ladolado3911 on 12/30/20.
//

import UIKit

protocol EditDatabase {
    func editDatabase(indexPath index: IndexPath)
}


class CollectCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var btn: UIButton!
    
    var delegate: EditDatabase?
    
    var indexPath: IndexPath?
    var colview: UICollectionView?

    
    @IBAction func btnact(_ sender: Any) {
        print("\(String(describing: indexPath))")
        colview?.deleteItems(at: [indexPath!])
        delegate!.editDatabase(indexPath: indexPath!)
    }

}
