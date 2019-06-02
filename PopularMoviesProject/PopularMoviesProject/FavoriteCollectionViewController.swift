//
//  FavoriteCollectionViewController.swift
//  PopularMoviesProject
//
//  Created by jets on 8/2/1440 AH.
//  Copyright © 1440 AH jets. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "FavCell"

class FavoriteCollectionViewController: UICollectionViewController {
    
    var appDelegate : AppDelegate?
    var movies:Array<Movie> = []


    override func viewDidLoad() {
        super.viewDidLoad()
        
          }
    override func viewWillAppear(_ animated: Bool) {
        let coreDataCRUD:CoreDataCRUD = CoreDataCRUD()
        movies = coreDataCRUD.getFavouriteMovies()
        self.collectionView?.reloadData()
        
        
            }

   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> ImageCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        cell.imageGrid.sd_setImage(with: URL(string: movies[indexPath.row].image), placeholderImage: UIImage(named: "placeholder.png"))
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let details : DetailsViewController = storyboard?.instantiateViewController(withIdentifier: "detailsVC") as! DetailsViewController
        details.movie = movies[indexPath.item]
        
        
//        print(movies[indexPath.item].releaseYear)
//        print(movies[indexPath.item].rating)
        self.navigationController?.pushViewController(details, animated: true)
    }


    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
