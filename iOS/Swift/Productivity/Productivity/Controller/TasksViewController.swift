//
//  ViewController.swift
//  Productivity
//
//  Created by slaviyana chervenkondeva on 21.08.18.
//  Copyright © 2018 Slavyana Chervenkondeva. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CreateTaskDelegate, OptionsPopupDelegate  {
    
    @IBOutlet weak var taskTableView: UITableView!
    
    @IBOutlet weak var moveButton: UIButton!
    
    @IBOutlet weak var levelLabel: UILabel!
    
    @IBOutlet weak var coinsLabel: UILabel!
    
    @IBOutlet weak var expLabel: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    
    var sampleUser : User = User()
    var sampleData : [Task] = [Task]()
    var selectedIndex : Int = 0
    
    var selectedTask : Task = Task()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        taskTableView.delegate = self
        taskTableView.dataSource = self
        
        taskTableView.register(UINib(nibName: "TaskCell", bundle: nil), forCellReuseIdentifier: "taskCell")

        
        updateUserLabels()
        testData()
        configureTableView()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureTableView() {
        taskTableView.rowHeight = UITableViewAutomaticDimension
        //taskTableView.estimatedRowHeight = 65.0
    }
    
    //MARK:- Test
    func testData() {
        let firstTask : Task = Task()
        firstTask.title = "Make bed"
        firstTask.info = "Morning 08:00"
        
        let secondTask : Task = Task()
        secondTask.title = "Eat fruit"
        secondTask.info = "Afternoon 16:00"
        
        let thirdTask : Task = Task()
        thirdTask.title = "Eat veggies"
        thirdTask.info = "Evening"
        
        let fourthTask : Task = Task()
        fourthTask.title = "Slay"
        fourthTask.info = "Every day"
        
        
        let fifthTask : Task = Task()
        fifthTask.title = "Test"
        fifthTask.info = "Evening"
        
        sampleData = [firstTask, secondTask, thirdTask, fourthTask, fifthTask]
    }
    
    
    //MARK:- TableView Delegate Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
        
        cell.iconImageView.image = UIImage(named: "up.png")
        cell.titleLabel.text = sampleData[indexPath.row].title
        cell.infoLabel.text = sampleData[indexPath.row].info
        
        if (sampleData[indexPath.row].completed)
        {
            cell.contentView.backgroundColor = UIColor(red: 0.7608, green: 0.9765, blue: 0.7608, alpha: 1.0)
        }
        else if (!sampleData[indexPath.row].started){
            cell.contentView.backgroundColor = UIColor.white
        } else {
            cell.contentView.backgroundColor = UIColor(red: 0.9098, green: 0.9098, blue: 0.9098, alpha: 1.0)
        }
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedIndex = indexPath.row
        selectedTask = sampleData[indexPath.row]
        self.performSegue(withIdentifier: "showOptionsPopup", sender: self)
         tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK:- Moving cells
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        // if more sections
        // productToMove = sections[sourceIndexPath.section].sampleData[sourceIndexPath.row]
        print("Source: %d", sourceIndexPath.row)
        print("Destination: %d", destinationIndexPath.row)
        
        let productToMove = sampleData[sourceIndexPath.row]
        
        // delete from source
        sampleData.remove(at: sourceIndexPath.row)

        
        for task in sampleData {
            print(task.title)
        }
        print("----")
        
        // move to destination
        sampleData.insert(productToMove, at: destinationIndexPath.row)
        
        for task in sampleData {
            print(task.title)
        }
        print("----")

    }
    
    
    
    // disable delete buttons
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }

    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    
    //MARK:- Swipe cell
    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        if(!sampleData[indexPath.row].started)
        {
            let closeAction = UIContextualAction(style: .normal, title:  "Done", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                print("Done!")
                self.sampleData[indexPath.row].completeTask()
                self.taskTableView.reloadData()
                self.sampleUser.completeTask(completedTask: self.sampleData[indexPath.row])
                self.updateUserLabels()
                
                success(true)
            })
            //closeAction.image = UIImage(named: "tick")
            closeAction.backgroundColor = .purple
            
            return UISwipeActionsConfiguration(actions: [closeAction])
        } else {
            return  UISwipeActionsConfiguration()
        }

        
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        if(!sampleData[indexPath.row].started) {
            let modifyAction = UIContextualAction(style: .normal, title:  "Skip", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                print("Skipped action ...")
                self.sampleData[indexPath.row].skipTask()
                self.taskTableView.reloadData()
                //self.sampleUser.undoTask(undoneTask: self.sampleData[indexPath.row])
                self.updateUserLabels()
                success(true)
            })
            //modifyAction.image = UIImage(named: "hammer")
            modifyAction.backgroundColor = .blue
            
            return UISwipeActionsConfiguration(actions: [modifyAction])
        } else {
            return  UISwipeActionsConfiguration()
        }
        
    }
    
    //MARK:- Button Action
    
    @IBAction func addTaskPressed(_ sender: UIButton) {
        
        
        if(sampleUser.coins >= 500) {
            self.performSegue(withIdentifier: "showCreate", sender: self)
        }
        else {
            let alert = UIAlertController(title: "Not enough coins", message: "You need \(500 - sampleUser.coins) more coins to continue.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Buy", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Watch video", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func statsButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "showStats", sender: self)
    }
    
    @IBAction func moveButtonPressed(_ sender: UIButton) {
        
        if (!taskTableView.isEditing) {
            taskTableView.isEditing = true
            moveButton.setTitle( "Done" , for: .normal )
        }
        else {
            taskTableView.isEditing = false
            moveButton.setTitle( "Move" , for: .normal )
        }
        
    }
    
    //MARK:- Prepare for segue
    override func prepare(for segue: UIStoryboardSegue,  sender: Any?) {
        if segue.identifier == "showCreate" {
            let createVC = segue.destination as! CreateViewController
            createVC.delegate = self
        } else if (segue.identifier == "showOptionsPopup") {
            let popupVC = segue.destination as! OptionsPopupViewController
            popupVC.index = selectedIndex
            popupVC.task = selectedTask
            popupVC.delegate = self
        }
    }
    
    //MARK:- Create task delegate method
    func taskReceived(task: Task) {
        sampleUser.coins -= 500
        sampleData.append(task)
        updateUserLabels()
        self.taskTableView.reloadData()
    }
    
    //MARK: -Popup delegate
    func optionsChanged(action: String) {
        if(action == "undo") {
            print ("Undone")
            sampleUser.undoTask(undoneTask: sampleData[selectedIndex])
            sampleData[selectedIndex].undoTask()
            taskTableView.reloadData()
            updateUserLabels()
        }
    }
    
    //MARK:- Labels
    func updateUserLabels() {
        levelLabel.text = "Level \(sampleUser.level)"
        coinsLabel.text = "\(sampleUser.coins)"
        expLabel.text = "\(sampleUser.currentExp) / \(sampleUser.neededExp)"
        progressView.progress = Float(sampleUser.currentExp) / Float(sampleUser.neededExp)
        
    }
    
    
}

