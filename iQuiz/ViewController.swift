//
//  ViewController.swift
//  iQuiz
//
//  Created by LEON LOONG on 2/13/18.
//  Copyright © 2018 leontaolong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    @IBOutlet weak var categoryTableView: UITableView!
    private var tableData: [QuizCategory] = []
    var defaultUrl: String = "https://tednewardsandbox.site44.com/questions.json"
    var refreshControl = UIRefreshControl()
    
    var timer: Timer!
    var interval = 30 // in sec
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(ViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        self.categoryTableView.addSubview(refreshControl)
        
        fetchData(defaultUrl)
        categoryTableView.dataSource = self
        categoryTableView.delegate = self
        if timer != nil {
            timer.invalidate()
        }
        startTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if timer != nil {
            timer.invalidate()
        }
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    @IBAction func settingsPressed(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Settings", message: "Please enter an url to fetch quizzes", preferredStyle: .alert)
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Url to fetch quiz data"
            textField.text = UserDefaults.standard.string(forKey: "data_url")
        }
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Refresh Time Interval"
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Check Now", style: .default, handler: {
            alert -> Void in
            let inputUrl = alertController.textFields![0].text!
            let inputInterval = alertController.textFields![1].text!
            UserDefaults.standard.set(inputUrl, forKey: "data_url")
            UserDefaults.standard.set(inputInterval, forKey: "refresh_interval")
            self.fetchData(inputUrl)
            self.startTimer()
        }))
        
        present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "categoryTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CategoryTableViewCell
        
        let category = tableData[indexPath.row]
        cell?.imgView.image = UIImage(named: category.imgName)
        cell?.imgView.contentMode = .scaleAspectFit
        cell?.titleLabel.text = category.title
        cell?.descLabel.text = category.desc
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIApplication.shared.quizQuestionRepository.setCategory(tableData[indexPath.row])
        goToQuestionView()
    }
    
    func goToQuestionView() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "QuestionViewController") as! QuestionViewController
        vc.quizProcess = 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func fetchData(_ url: String ) {
        let url = URL(string: url)
        if url != nil {
            URLSession.shared.dataTask(with: url!) { (data, response, error) in
                if error != nil {
                    let alertController = UIAlertController(title: "Error", message: "Fetching quiz data error. Using locally stored quiz data.", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                } else { // fetch online data if possible
                    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 { // request error
                        let alertController = UIAlertController(title: "Error", message: "Fail to fetching quiz data. Request error.", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Retry", style: .default, handler: nil))
                        self.present(alertController, animated: true, completion: nil)
                    } else {
                        let json = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [Dictionary<String, AnyObject>]
                        UserDefaults.standard.setValue(json, forKey: "quizData")
                        UIApplication.shared.quizQuestionRepository.deserializaData()
                    }
                }
                // update UI
                DispatchQueue.main.async {
                    self.tableData = UIApplication.shared.quizQuestionRepository.getQuizCategories()
                    self.categoryTableView.reloadData()
                    self.refreshControl.endRefreshing()
                }
            }.resume()
        }
    }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
        if UserDefaults.standard.string(forKey: "refresh_interval") != nil {
            interval = Int(UserDefaults.standard.string(forKey: "refresh_interval")!)!
        } else {
            interval = 30
        }
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        if interval != 0 {
            interval -= 1
        } else {
            fetchData(defaultUrl)
            timer.invalidate()
            startTimer()
        }
    }
    
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        fetchData(defaultUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

