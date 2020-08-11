//
//  ViewController.swift
//  iNote
//
//  Created by Anik on 4/7/20.
//  Copyright © 2020 Anik. All rights reserved.
//

import UIKit
import CoreData

class NotesListVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet var notelCollectionView: UICollectionView!
    
    let reuseIdentifier = "NoteCell"
    let segueIdentifier = "NoteDesctiptionIdentifier"
    
    var notes: [Note] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notelCollectionView.delegate = self
        notelCollectionView.dataSource = self
        notelCollectionView.reloadData()
        
    }
    
    @IBAction func addNewNoteButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let note = notes[indexPath.row]
        
        let noteCell: NoteCell = notelCollectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NoteCell
        
        noteCell.descriptionCellLabel.isEditable = false
        noteCell.updateCell(header: note.header!, description: note.desc!)
        style(noteCell: noteCell)
        return noteCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = (collectionView.bounds.width/2.0) - 30
        let yourHeight = yourWidth
        print("height adjusted")
        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNote"{
            if let noteShowVC = segue.destination as? NoteShowVC{
                if let cell = sender as? NoteCell{
                    noteShowVC.color = UIColor.black
                    noteShowVC.header = cell.headerLabel.text!
                    noteShowVC.desc = cell.descriptionCellLabel.text!
                }

            }
        }
    }
    
    func style(noteCell: UICollectionViewCell){
        noteCell.contentView.layer.cornerRadius = 8.0
        noteCell.contentView.layer.borderWidth = 1.0
        noteCell.contentView.layer.borderColor = UIColor.clear.cgColor
        noteCell.contentView.layer.masksToBounds = true
        
        noteCell.layer.shadowColor = UIColor.black.cgColor
        noteCell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        noteCell.layer.shadowRadius = 5.0
        noteCell.layer.shadowOpacity = 0.5
        noteCell.layer.masksToBounds = false
        noteCell.layer.shadowPath = UIBezierPath(roundedRect: noteCell.bounds, cornerRadius: noteCell.contentView.layer.cornerRadius).cgPath
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<Note>(entityName: "Note")
        
        //3
        do {
            notes = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        notelCollectionView.reloadData()
    }
    
    
    
}

