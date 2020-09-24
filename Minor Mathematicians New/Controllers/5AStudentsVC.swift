//
//  5AStudentsVC.swift
//  Minor Mathematicians
//
//  Created by Ricardo Aguiar Bomeny on 21/01/20.
//  Copyright © 2020 Ricardo Aguiar Bomeny. All rights reserved.
//
import UIKit
import Firebase

class fiveAStudentsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var feedTableView: UITableView!
    @IBOutlet weak var welcomeLbl: UILabel!
    
    var posts = [Post]()
    var fetchingMore = false
    var endReached = false
    let leadingScreensForBatching:CGFloat = 3.0
    var selectedGrade = ""
    let ref = Database.database().reference()
    var exercisesLink = "noURL"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getExercisesLink()
        
        welcomeLbl.text = "Welcome, \(selectedGrade) Grade"
        
        feedTableView.layer.cornerRadius = 19
        feedTableView.dataSource = self
        feedTableView.delegate = self
        feedTableView.reloadData()

        let cellNib = UINib(nibName: "PostTableViewCell", bundle: nil)
        feedTableView.register(cellNib, forCellReuseIdentifier: "postCell")
        
        beginBatchFetch()
        
     
        
    }

    func getExercisesLink(){
        ref.child(selectedGrade).child("ExercisesURL").observe( .value, with: { (snapshot) in
        let link = snapshot.value as? String
        if let actualLink = link {
            self.exercisesLink = actualLink
        }
     })
    }

   
    func fetchPosts(completion: @escaping(_ posts:[Post]) -> ()) {
        let postsRef = ref.child(selectedGrade).child("Posts")
        let lastPost = self.posts.last
        var queryRef:DatabaseQuery
        if lastPost == nil{
            queryRef = postsRef.queryOrdered(byChild: "timestamp").queryLimited(toLast: 10)
        } else {
            let lastTimestamp = lastPost!.createdAt.timeIntervalSince1970 * 1000
            queryRef = postsRef.queryOrdered(byChild: "timestamp").queryEnding(atValue: lastTimestamp)
        }

        
        var tempPosts = [Post]()
        
        queryRef.observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                    let dict = childSnapshot.value as? [String:Any],
                let text = dict["text"] as? String,
                let url = dict["url"] as? String,
                let timestamp = dict["timestamp"] as? Double {
                    
                    if childSnapshot.key != lastPost?.id {
                        let post = Post(id: childSnapshot.key, timestamp: timestamp, text: text, url: url)
                        tempPosts.insert(post, at: 0)
                    }
                }
            }
            return completion(tempPosts)
        })
    }

    
    @IBAction func onReturnPressed(_ sender: Any){
        performSegue(withIdentifier: "fiveAStudentReturn", sender: nil)
    }
    
    @IBAction func onExercisesBtnPressed(_ sender: Any) {
        
        UIApplication.shared.open(URL(string: exercisesLink)! as URL, options: [:], completionHandler: nil)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = feedTableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
        cell.set(post: posts[indexPath.row])
        return cell
    }
    
    var cellUrl: String?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       cellUrl = posts[indexPath.row].url
        runCheck()
//        if posts[indexPath.row].url != nil {
//            UIApplication.shared.open((URL(string: "\(posts[indexPath.row].url ?? ""))") as URL?)!, options: [:], completionHandler: nil)
//        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height * leadingScreensForBatching {
            
            if !fetchingMore && !endReached {
                beginBatchFetch()
            }
        }
    }
    
    func runCheck(){
        print(cellUrl!)
        if cellUrl == "noURL" {
        print("No URL, SUCCESS")
        } else if cellUrl != nil && cellUrl != " " {
            UIApplication.shared.open(URL(string: cellUrl!)!, options: [:], completionHandler: nil)
        }
        
        
    }
    
    func beginBatchFetch(){
        fetchingMore = true
        // Fetch Posts
        fetchPosts { newPosts in
            self.posts.append(contentsOf: newPosts)
            self.endReached = newPosts.count == 0
            self.fetchingMore = false
            self.feedTableView.reloadData()
        }
    }

}
