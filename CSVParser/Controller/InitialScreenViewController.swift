//
//  InitialScreenViewController.swift
//  CSVParser
//
//  Created by Jaime Terra on 19/12/19.
//  Copyright © 2019 Jaime Terra. All rights reserved.
//

import Foundation
import UIKit

class InitialScreenViewController : UIViewController {
    
    @IBOutlet weak var initialMainView: UIView!
    @IBOutlet weak var fileNameTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func onStartParseTouched(_ sender: Any) {
        animateActivityIndicator(on: true)
        let csvString = Utils.readDataFromCSV(fileName: fileNameTextField.text!)
        
        if(csvString == nil){
            self.createAlert(title: "Error", message: "File not found or missing. Please check if the file really exists.")
        } else if(csvString == "") {
            self.createAlert(title: "Empty Field", message: "Please type a name for the desired file.")
        }else {
            let csvStringFormatted = Utils.removeCSVUnnecessaryCharacters(string: csvString!)
            let issueModel = IssueModel()
            issueModel.populateFields(csvString: csvStringFormatted)
            animateActivityIndicator(on: false)
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let destinationVC = storyBoard.instantiateViewController(withIdentifier: "CSVDetailsViewController") as! CSVDetailsViewController
            destinationVC.issueModel = issueModel
            navigationController?.pushViewController(destinationVC, animated: true)
        }
        
    }
    
    func animateActivityIndicator(on: Bool){
        if(on) {
            activityIndicator.startAnimating()
            initialMainView.isUserInteractionEnabled = false
        } else {
            activityIndicator.stopAnimating()
            initialMainView.isUserInteractionEnabled = true
        }
    }
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
