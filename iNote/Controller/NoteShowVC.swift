//
//  NoteShowVC.swift
//  iNote
//
//  Created by Anik on 4/7/20.
//  Copyright © 2020 Anik. All rights reserved.
//

import UIKit
import CoreData

class NoteShowVC: UIViewController, UITextViewDelegate {
    @IBOutlet weak var headerTextView: UITextView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var header = "Title"
    var desc = "Description"
    var color = UIColor.gray
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headerTextView.text = header
        headerTextView.textColor = color
        descriptionTextView.text = desc
        descriptionTextView.textColor = color
        
        headerTextView.delegate = self
        descriptionTextView.delegate = self
        
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {

        if textView.textColor == UIColor.gray{
            textView.text = ""
        }
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        if headerTextView.text != "" || descriptionTextView.text != ""
        {
            save(header: headerTextView.text, description: descriptionTextView.text)
        }
    }
    
    func save(header: String, description: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let note = Note(context: managedContext)
        note.header = header
        note.desc = description
     
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error saving. \(error)")
        }
        
        
        
    }
    

}
