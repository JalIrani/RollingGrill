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
    
    //            INSPhoto(imageURL: URL(string: "http://inspace.io/assets/portfolio/thumb/6-d793b947f57cc3df688eeb1d36b04ddb.jpg"), thumbnailImageURL: URL(string: "http://inspace.io/assets/portfolio/thumb/6-d793b947f57cc3df688eeb1d36b04ddb.jpg")),
    //            INSPhoto(imageURL: URL(string: "http://inspace.io/assets/portfolio/thumb/6-d793b947f57cc3df688eeb1d36b04ddb.jpg"), thumbnailImageURL: URL(string: "http://inspace.io/assets/portfolio/thumb/6-d793b947f57cc3df688eeb1d36b04ddb.jpg")),
    //            INSPhoto(imageURL: URL(string: "http://inspace.io/assets/portfolio/thumb/6-d793b947f57cc3df688eeb1d36b04ddb.jpg"), thumbnailImageURL: URL(string: "http://inspace.io/assets/portfolio/thumb/6-d793b947f57cc3df688eeb1d36b04ddb.jpg"))
    //            INSPhoto(imageURL: URL(string: "http://scontent.cdninstagram.com/t51.2885-15/s480x480/e35/16122719_1181034925345942_4797100224747143168_n.jpg?ig_cache_key=MTQzMTE2MjA4NzIzMzAyMTY1MA%3D%3D.2"), thumbnailImage: UIImage(named: "thumbnailImage")),
    
    lazy var photos: [INSPhotoViewable] = {
        return [
            INSPhoto(image: UIImage(named: "1FullSize")!, thumbnailImage: UIImage(named: "1FullSize")!),
            INSPhoto(image: UIImage(named: "2FullSize")!, thumbnailImage: UIImage(named: "2FullSize")!),
            INSPhoto(image: UIImage(named: "3FullSize")!, thumbnailImage: UIImage(named: "3FullSize")!),
            INSPhoto(image: UIImage(named: "4FullSize")!, thumbnailImage: UIImage(named: "4FullSize")!),
            INSPhoto(image: UIImage(named: "5FullSize")!, thumbnailImage: UIImage(named: "5FullSize")!),
            INSPhoto(image: UIImage(named: "6FullSize")!, thumbnailImage: UIImage(named: "6FullSize")!),
            INSPhoto(image: UIImage(named: "7FullSize")!, thumbnailImage: UIImage(named: "7FullSize")!),
            INSPhoto(image: UIImage(named: "8FullSize")!, thumbnailImage: UIImage(named: "8FullSize")!),
            INSPhoto(image: UIImage(named: "9FullSize")!, thumbnailImage: UIImage(named: "9FullSize")!),
            INSPhoto(image: UIImage(named: "10FullSize")!, thumbnailImage: UIImage(named: "10FullSize")!),
            INSPhoto(image: UIImage(named: "11FullSize")!, thumbnailImage: UIImage(named: "11FullSize")!),
            INSPhoto(image: UIImage(named: "12FullSize")!, thumbnailImage: UIImage(named: "12FullSize")!),
            INSPhoto(image: UIImage(named: "13FullSize")!, thumbnailImage: UIImage(named: "13FullSize")!),
            INSPhoto(image: UIImage(named: "14FullSize")!, thumbnailImage: UIImage(named: "14FullSize")!)
            
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
//        for photo in photos {
//            if let photo = photo as? INSPhoto {
//                #if swift(>=4.0)
//                    photo.attributedTitle = NSAttributedString(string: "Example caption text\ncaption text", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
//                #else
//                    photo.attributedTitle = NSAttributedString(string: "Example caption text\ncaption text", attributes: [NSForegroundColorAttributeName: UIColor.white])
//                #endif
//            }
//        }
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((collectionView.frame.size.width)/2) - 8, height: 145)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 1
//    }
}
