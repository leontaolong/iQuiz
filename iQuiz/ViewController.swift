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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData(defaultUrl)
        UIApplication.shared.quizQuestionRepository.deserializaData()
        tableData = UIApplication.shared.quizQuestionRepository.getQuizCategories()
        
        categoryTableView.dataSource = self
        categoryTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }


    
    @IBAction func settingsPressed(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
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
        if (url != nil) {
            URLSession.shared.dataTask(with: url!) { (data, response, error) in
                if error == nil { // fetch online data if possible
                    let json = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [Dictionary<String, Any>]
                    UserDefaults.standard.setValue(json, forKey: "quizData")
                }
            }.resume()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

