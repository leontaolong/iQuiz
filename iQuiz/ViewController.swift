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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryTableView.dataSource = self
        categoryTableView.delegate = self
        populateData()
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
    
    private func populateData() {
        let math = QuizCategory("math", "Mathematics", "It's time to test out if your math is still in elementary school")
        let marvel = QuizCategory("marvel", "Marvel Super Heroes", "It's time to test out how much you know about Marvel Sper Heroes")
        let science = QuizCategory("science", "Science", "It's time to test out if your science is still in elementary school")
        tableData += [math, marvel, science]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

