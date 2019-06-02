//
//  MoviesTableViewController.swift
//  PopularMoviesProject
//
//  Created by jets on 7/22/1440 AH.
//  Copyright © 1440 AH jets. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

let poster_URL = "https://image.tmdb.org/t/p/w500"
class MoviesTableViewController: UITableViewController,UISearchBarDelegate {
    var moviesArray:Array<Movie> = []
    var filteredData = [Movie]()
    var inSearchMode = false
    
    var moviesArrayByPopularity:Array<Movie> = []
    var moviesArrayByRate:Array<Movie> = []
    var responseMovieByPopularity:[[String: Any]]=[]
    var responseMovieByRate:[[String: Any]]=[]
    
    
    
    @IBAction func btnTopRated(_ sender: Any) {
        
        
        //        moviesArray = moviesArray.sorted(by: { (Double($0.rating) ) > (Double($1.rating) )
        //        })
        moviesArray = self.moviesArrayByRate
        self.tableView?.reloadData()
        
        
        
    }
    
    
    
    @IBAction func btnMostPopularMovies(_ sender: Any) {
        
        
        //        moviesArray = moviesArray.sorted(by: { (Double($0.popularity) ) > (Double($1.popularity) )
        //        })
        moviesArray = self.moviesArrayByPopularity
        self.tableView?.reloadData()
        
    }
    @IBOutlet weak var SearchBarInTable: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        SearchBarInTable.delegate = self
        
        
        
        
        DispatchQueue.main.async {
            Alamofire.request("https://api.themoviedb.org/3/discover/movie?sort_by=vote_average.desc&api_key=f9fff5cdf61663858e62cf2282fbf0f2").responseJSON { (response) in
                if let responseValue = response.result.value as! [String: Any]? {
                    self.responseMovieByPopularity = responseValue["results"] as! [[String: Any]]
                    for item in self.responseMovieByPopularity{
                        
                        let movie1  = Movie()
                        
                        let imageURL = item["poster_path"] as? String
                        
                        if imageURL != nil {
                            movie1.MovieID = item["id"] as! Int
                            
                            movie1.title=item["title"] as! String
                            movie1.image = poster_URL + imageURL!
                            movie1.overview=item["overview"] as! String
                            movie1.rating=item["vote_average"]! as! Double
                            movie1.releaseYear=item["release_date"]! as! String
                            movie1.popularity=item["popularity"]! as! Double
                            self.moviesArrayByRate.append(movie1)
                            
                            self.tableView?.reloadData()
                        }
                    }
                    
                    
                    
                    
                }
                
            }
            
            
            
            
            Alamofire.request("https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=f9fff5cdf61663858e62cf2282fbf0f2").responseJSON { (response) in
                if let responseValue1 = response.result.value as! [String: Any]? {
                    self.responseMovieByRate = responseValue1["results"] as! [[String: Any]]
                    for item in self.responseMovieByRate{
                        
                        let movie1  = Movie()
                        
                        let imageURL = item["poster_path"] as? String
                        
                        if imageURL != nil {
                            movie1.MovieID = item["id"] as! Int
                            movie1.overview=item["overview"] as! String
                            movie1.title=item["title"] as! String
                            movie1.image = poster_URL + imageURL!
                            movie1.rating=item["vote_average"]! as! Double
                            movie1.releaseYear=item["release_date"]! as! String
                            movie1.popularity=item["popularity"]! as! Double
                            self.moviesArrayByPopularity.append(movie1)
                            self.moviesArray.append(movie1)
                            self.tableView?.reloadData()
                        }
                    }
                    
                    
                    
                    
                }
                
            }
            
            
            
            
        }
        
        moviesArray=self.moviesArrayByPopularity
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if inSearchMode {
            
            return filteredData.count
        }
        
        else{return moviesArray.count}
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> CustomTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
//        let mov : Movie!
//        if inSearchMode {
//           mov = filteredData[indexPath.row]
//        
//        }
//        
//        else {
//          mov = moviesArray[indexPath.row]
//        }
        
        if inSearchMode {
        
            cell.txtTitle.text = filteredData[indexPath.row].title
            cell.txtRate.text = String(filteredData[indexPath.row].rating)+"/10"
            cell.MovieImage.sd_setImage(with: URL(string: filteredData[indexPath.row].image), placeholderImage: UIImage(named: "placeholder.png"))
        }
        
        else{
        
            cell.txtTitle.text = moviesArray[indexPath.row].title
            cell.txtRate.text = String(moviesArray[indexPath.row].rating)+"/10"
            cell.MovieImage.sd_setImage(with: URL(string: moviesArray[indexPath.row].image), placeholderImage: UIImage(named: "placeholder.png"))
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    @IBAction func viewCollection(_ sender: Any) {
        var collection : UiGridViewController = storyboard?.instantiateViewController(withIdentifier: "CollecionVCID") as! UiGridViewController
        self.navigationController?.pushViewController(collection, animated: true)
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let details : DetailsViewController = storyboard?.instantiateViewController(withIdentifier: "detailsVC") as! DetailsViewController
        if inSearchMode{
            details.movie = filteredData[indexPath.row]}
        else
        {
         details.movie = moviesArray[indexPath.row]
        }
        
        
        self.navigationController?.pushViewController(details, animated: true)
        
    }
   
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        
//        if searchBar.text == nil || searchBar.text == "" {
//            
//            inSearchMode = false
//            
//            view.endEditing(true)
//            
//            tableView.reloadData()
//            
//        } else {
//            
//            inSearchMode = true
//            
//            filteredData = moviesArray.filter({$0.title == searchBar.text})
//            
//            tableView.reloadData()
//        }
//    }
    
    
}
extension MoviesTableViewController {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
        
            filteredData = moviesArray
            inSearchMode = false
            tableView.reloadData()

        }
        
        else {
        
        filteredData = moviesArray.filter({$0.title.lowercased().contains(searchText.lowercased()) })
        inSearchMode = true
        tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        inSearchMode = false
        searchBar.text = ""
        tableView.reloadData()
    }
    
}



    




