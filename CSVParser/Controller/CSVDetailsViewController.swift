//
//  CSVDetailsViewController.swift
//  CSVParser
//
//  Created by Jaime Terra on 18/12/19.
//  Copyright © 2019 Jaime Terra. All rights reserved.
//

import UIKit

class CSVDetailsViewController: UIViewController {
    
    var issueModel : IssueModel?
    private let itemsPerRow: CGFloat = 4
    @IBOutlet weak var detailsTableView: UICollectionView!
    
    private let sectionInsets = UIEdgeInsets(top: 0.0,
    left: 10.0,
    bottom: 0.0,
    right: 10.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsTableView.register(UINib(nibName: "CSVCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cellId")
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
    }
}

extension CSVDetailsViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return issueModel!.fields[section].count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return issueModel!.fields.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CSVCollectionViewRowCell
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        if(indexPath.section == 0){
            cell.titleCell.font = UIFont.boldSystemFont(ofSize: 14.0)
        }
        cell.titleCell.text = issueModel!.fields[indexPath.section][indexPath.row] as? String
        return cell
    }
}

// MARK: - Collection View Flow Layout Delegate
extension CSVDetailsViewController : UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let widthPerItem = view.frame.width / itemsPerRow

    return CGSize(width: widthPerItem, height: widthPerItem/1.5)
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
