//
//  TeacherVC.swift
//  Minor Mathematicians
//
//  Created by Ricardo Aguiar Bomeny on 20/01/20.
//  Copyright © 2020 Ricardo Aguiar Bomeny. All rights reserved.
//

import UIKit
import Firebase

class TeacherVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var feedTableView: UITableView!
    
    var gradeSelected = ""
    var exercisesLink = "noURL"
    var progressLink = "noURL"
    var posts = [Post]()
    var fetchingMore = false
    var endReached = false
    let leadingScreensForBatching:CGFloat = 3.0
    
    let ref = Database.database().reference()
    
    func getLinkExercises() -> String {
        var link = ""
        if gradeSelected == "5" {
        link = "https://drive.google.com/drive/folders/0AFpZc_dk-uM8Uk9PVA"
        return link
        } else if gradeSelected == "4" {
        link = "link4"
        return link
        } else if gradeSelected == "3" {
        link = "link3"
        return link
        }
        return link
    }
    func getLinkProgress() -> String {
         var link = ""
         if gradeSelected == "5" {
         link = "https://docs.google.com/spreadsheets/d/1_WFSsKdMgBYTbr7MRwkVexqbExif6DsfxJ_JP1EgxvQ/view"
         return link
         } else if gradeSelected == "4" {
         link = "link4"
         return link
         } else if gradeSelected == "3" {
         link = "link3"
         return link
         }
         return link
     }
    
    @IBAction func onExercisesBtnPressed(_ sender: Any) {
        UIApplication.shared.open(URL(string: exercisesLink)! as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func studentProgressBtnIsClicked(_ sender: Any) {
            UIApplication.shared.open(URL(string: progressLink)! as URL, options: [:], completionHandler: nil)
    }
    
    func getExercisesLink(){
        ref.child(gradeSelected).child("ExercisesURL").observe( .value, with: { (snapshot) in
        let link = snapshot.value as? String
        if let actualLink = link {
            self.exercisesLink = actualLink
        }
     })
    }
    
    func getProgressLink(){
        ref.child(gradeSelected).child("ProgressURL").observe( .value, with: { (snapshot) in
        let link = snapshot.value as? String
        if let actualLink = link {
            self.progressLink = actualLink
        }
     })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getExercisesLink()
        getProgressLink()
        
        backBtn.addTarget(self, action: #selector(returnAll), for: .touchUpInside)
        feedTableView.layer.cornerRadius = 19
        feedTableView.dataSource = self
        feedTableView.delegate = self
        feedTableView.reloadData()
        
        let cellNib = UINib(nibName: "PostTableViewCell", bundle: nil)
        feedTableView.register(cellNib, forCellReuseIdentifier: "postCell")
        
        beginBatchFetch()
        
    }
    
    @objc func returnAll(){
        performSegue(withIdentifier: "TeacherReturnSelect", sender: nil)
    }





            
    

        
        
        func fetchPosts(completion: @escaping(_ posts:[Post]) -> ()) {
            let postsRef = Database.database().reference().child(gradeSelected).child("Posts")
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
