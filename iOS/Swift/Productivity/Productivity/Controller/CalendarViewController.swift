//
//  CalendarViewController.swift
//  Productivity
//
//  Created by slaviyana chervenkondeva on 29.08.18.
//  Copyright © 2018 Slavyana Chervenkondeva. All rights reserved.
//

import UIKit
import JTAppleCalendar
import SwiftDate

class CalendarViewController: UIViewController, JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate, UITableViewDelegate, UITableViewDataSource,
UIScrollViewDelegate, OptionsPopupDelegate{



    let formatter = DateFormatter()
    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var taskTableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    
    var sampleData : [Task] = [Task]()
    var sampleUser : User = User()
    var showData : [Task] = [Task]()
    var selectedTask : Task = Task()
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var stackHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCalendarView()
        taskTableView.dataSource = self
        taskTableView.delegate = self
        scrollView.delegate = self
        
        taskTableView.bounces = false
        taskTableView.isScrollEnabled = false
        
        taskTableView.register(UINib(nibName: "TaskCell", bundle: nil), forCellReuseIdentifier: "taskCell")
        
        configureTableView()
        calendarView.visibleDates() { (visibleDates) in
            self.setupViewsOfCalender(from: visibleDates)
        }
    }
    
    func configureTableView() {
        taskTableView.rowHeight = UITableViewAutomaticDimension
        taskTableView.estimatedRowHeight = 80.0
        taskTableView.reloadData()
        taskTableView.layoutIfNeeded()
    }
    
    func setupViewsOfCalender(from visibleDates: DateSegmentInfo) {
        let date = visibleDates.monthDates.first!.date
        
        self.formatter.dateFormat = "yyyy"
        self.yearLabel.text = self.formatter.string(from: date)
        
        self.formatter.dateFormat = "MMMM"
        self.monthLabel.text = self.formatter.string(from: date)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupCalendarView() {
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
    }

    func handleCellSelected(view: JTAppleCell?, cellState: CellState) {
        guard let validCell = view as? CalendarCell else {return}
        
        if(cellState.isSelected) {
            validCell.selectedView.isHidden = false
        } else {
            validCell.selectedView.isHidden = true
        }
    }
    
    func handleCellTextColour(view: JTAppleCell?, cellState: CellState) {
        guard let validCell = view as? CalendarCell else {return}
        if cellState.isSelected {
            validCell.dateLabel.textColor = UIColor.white
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                validCell.dateLabel.textColor = UIColor.black
            } else {
                validCell.dateLabel.textColor = UIColor.lightGray
            }
        }
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
    
        let myCustomCell = calendar.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
        sharedFunctionToConfigureCell(myCustomCell: myCustomCell, cellState: cellState, date: date)
        return myCustomCell

    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2018 01 01")!
        let endDate = formatter.date(from: "2018 12 31")!
        
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
        return parameters
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        // This function should have the same code as the cellForItemAt function
        let myCustomCell = cell as! CalendarCell
        sharedFunctionToConfigureCell(myCustomCell: myCustomCell, cellState: cellState, date: date)
    }
    
    func sharedFunctionToConfigureCell(myCustomCell: CalendarCell, cellState: CellState, date: Date) {
        myCustomCell.dateLabel.text = cellState.text
        
        handleCellSelected(view: myCustomCell, cellState: cellState)
        handleCellTextColour(view: myCustomCell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {

        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColour(view: cell, cellState: cellState)
        
        showCells(forDate: date)
        
    }
        
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
         handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColour(view: cell, cellState: cellState)
        
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupViewsOfCalender(from: visibleDates)
        
        
    }
    
    func showCells(forDate date: Date) {
        showData = [Task]()
        let normalDate = DateInRegion(date, region: Region.local)
        let weekDay = normalDate.weekday
        print("Supposed weekday \(weekDay)")
        
        for task in sampleData {
            if(normalDate.weekOfYear - task.startDate.weekOfYear) % task.everyXWeeks == 0 {
                if(task.weekDays["\(weekDay)"] == 1) {
                    showData.append(task)
                }
            }
        }
        
        calculateHeight()
        
    }
    
    func calculateHeight() {
        taskTableView.reloadData()
        taskTableView.layoutIfNeeded()
        
        let tableHeight = taskTableView.contentSize.height + taskTableView.contentInset.bottom + taskTableView.contentInset.top
        tableViewHeight.constant = tableHeight
        taskTableView.layoutIfNeeded()
        
        let height = tableHeight + stackHeight.constant + 40
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: height)
        
        
        print(tableHeight)
        print(height)
    }

    // MARK:- Tableview
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        for task in sampleData {
            print(task.isEqual(showData[indexPath.row]))
        }
        selectedTask = showData[indexPath.row]
//        selectedIndex = indexPath.row
//        selectedTask = sampleData[indexPath.row]
//        print(sampleData[indexPath.row].weekDays)
        self.performSegue(withIdentifier: "showOptionsPopup", sender: self)
//        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
        
        cell.iconImageView.image = UIImage(named: "up.png")
        cell.titleLabel.text = showData[indexPath.row].title
        cell.infoLabel.text = showData[indexPath.row].info
        //cell.infoLabel.sizeToFit()
        cell.infoLabel.numberOfLines = 0
        cell.infoLabel.lineBreakMode = .byWordWrapping
        cell.timesDoneLabel.text = "\(showData[indexPath.row].timesCompleted) / \(showData[indexPath.row].timesADay)"
        cell.progressBar.progress = Float(showData[indexPath.row].timesCompleted) / Float((showData[indexPath.row].timesADay))
        
        //progressView.progress = Float(sampleUser.currentExp) / Float(sampleUser.neededExp)

        if (showData[indexPath.row].completed)
        {
            cell.contentView.backgroundColor = UIColor(red: 0.7608, green: 0.9765, blue: 0.7608, alpha: 1.0)
        }
        else if (showData[indexPath.row].skipped){
            cell.contentView.backgroundColor = UIColor(red: 0.9098, green: 0.9098, blue: 0.9098, alpha: 1.0)
        } else {
            cell.contentView.backgroundColor = UIColor.white
        }
        return cell;
    }
    
    //MARK:- Popup
    
    func updateDefaults() {
        let defaults = UserDefaults.standard
        
        
        var savedData = [[String : Any]]()
        print("sampleData............")
        print(sampleData)
        for data in sampleData {
            print(data)
            savedData.append(data.toDictionary())
            print("savedData............")
            print(savedData)
        }
        
        defaults.set(savedData, forKey: "tasks")
        defaults.set(sampleUser.toDictionary(), forKey: "user")
        defaults.synchronize()
    }

    

    
    func optionsChanged(action: String, task: Task) {
        var selectedIndex = 0
        
        for i in 0...sampleData.count - 1 {
            if(sampleData[i].isEqual(selectedTask)) {
                selectedIndex = i
            }
        }
        
        switch action {
            case "undo":
                print ("Undone")
                sampleUser.undoTask(undoneTask: sampleData[selectedIndex])
                sampleData[selectedIndex].undoTask()
                taskTableView.reloadData()

            case "edit":
                print ("Edited")
                sampleData[selectedIndex] = task
                taskTableView.reloadData()
            

            case "delete":
                print ("Deleted")
                sampleData.remove(at: selectedIndex)
                sampleUser.coins += 500

                //updateUserLabels()
                taskTableView.reloadData()

            default:
                print ("Default")
            }

            updateDefaults()
        
    }
    
    //MARK:- Segue

    override func prepare(for segue: UIStoryboardSegue,  sender: Any?) {

        if (segue.identifier == "showOptionsPopup") {
            let popupVC = segue.destination as! OptionsPopupViewController
            popupVC.task = selectedTask
            popupVC.delegate = self
        }
        
    }
    

}
