//
//  GalleryViewController.swift
//  RollingGrill
//
//  Created by Jal Irani on 10/31/17.
//  Copyright © 2017 Apptzr. All rights reserved.
//

import UIKit
import INSPhotoGallery

class GalleryViewController: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var useCustomOverlay = false
    
    lazy var photos: [INSPhotoViewable] = {
        return [
            INSPhoto(imageURL: URL(string: "http://inspace.io/assets/portfolio/thumb/13-3f15416ddd11d38619289335fafd498d.jpg"), thumbnailImage: UIImage(named: "thumbnailImage")),
            INSPhoto(imageURL: URL(string: "http://inspace.io/assets/portfolio/thumb/13-3f15416ddd11d38619289335fafd498d.jpg"), thumbnailImage: UIImage(named: "thumbnailImage")!),
            INSPhoto(image: UIImage(named: "fullSizeImage")!, thumbnailImage: UIImage(named: "thumbnailImage")!),
            INSPhoto(imageURL: URL(string: "http://inspace.io/assets/portfolio/thumb/6-d793b947f57cc3df688eeb1d36b04ddb.jpg"), thumbnailImageURL: URL(string: "http://inspace.io/assets/portfolio/thumb/6-d793b947f57cc3df688eeb1d36b04ddb.jpg")),
            INSPhoto(imageURL: URL(string: "http://inspace.io/assets/portfolio/thumb/6-d793b947f57cc3df688eeb1d36b04ddb.jpg"), thumbnailImageURL: URL(string: "http://inspace.io/assets/portfolio/thumb/6-d793b947f57cc3df688eeb1d36b04ddb.jpg")),
            INSPhoto(imageURL: URL(string: "http://inspace.io/assets/portfolio/thumb/6-d793b947f57cc3df688eeb1d36b04ddb.jpg"), thumbnailImageURL: URL(string: "http://inspace.io/assets/portfolio/thumb/6-d793b947f57cc3df688eeb1d36b04ddb.jpg"))
            
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        for photo in photos {
            if let photo = photo as? INSPhoto {
                #if swift(>=4.0)
                    photo.attributedTitle = NSAttributedString(string: "Example caption text\ncaption text", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
                #else
                    photo.attributedTitle = NSAttributedString(string: "Example caption text\ncaption text", attributes: [NSForegroundColorAttributeName: UIColor.white])
                #endif
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension GalleryViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExampleCollectionViewCell", for: indexPath) as! ExampleTableViewCell
        cell.populateWithPhoto(photos[(indexPath as NSIndexPath).row])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ExampleTableViewCell
        let currentPhoto = photos[(indexPath as NSIndexPath).row]
        let galleryPreview = INSPhotosViewController(photos: photos, initialPhoto: currentPhoto, referenceView: cell)
//        if useCustomOverlay {
//            galleryPreview.overlayView = CustomOverlayView(frame: CGRect.zero)
//        }
        
        galleryPreview.referenceViewForPhotoWhenDismissingHandler = { [weak self] photo in
            if let index = self?.photos.index(where: {$0 === photo}) {
                let indexPath = IndexPath(item: index, section: 0)
                return collectionView.cellForItem(at: indexPath) as? ExampleTableViewCell
            }
            return nil
        }
        present(galleryPreview, animated: true, completion: nil)
    }
}
