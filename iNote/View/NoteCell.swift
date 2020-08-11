//
//  NoteCell.swift
//  iNote
//
//  Created by Anik on 4/7/20.
//  Copyright © 2020 Anik. All rights reserved.
//

import UIKit

class NoteCell: UICollectionViewCell {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var descriptionCellLabel: UITextView!
    @IBOutlet weak var noteCellView: UIView!
    
    func updateCell(header: String, description: String){
        headerLabel.text = header
        descriptionCellLabel.text = description
        
    }
    
    
}
