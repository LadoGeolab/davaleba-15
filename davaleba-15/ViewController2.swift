//
//  ViewController2.swift
//  davaleba-15
//
//  Created by Ladolado3911 on 12/30/20.
//

import UIKit

class ViewController2: UIViewController {
    
    var image: UIImage?//
    var database: [UIImage]?
    var index: Int?

    @IBOutlet weak var imageView1: UIImageView!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView1.image = image


    }
}

