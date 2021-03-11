//
//  ViewController.swift
//  Note-swift
//
//  Created by tino又想吃肉了 on 2021/2/9.
//

import UIKit

struct Category {
    var title : String
    var detail : Array<Note>?
}

struct Note {
    var title : String
    var detail : String?
    var time : String?
}

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,updateAll {
    
    var textCombine : Array<Category> = []
    
    var tableView : UITableView? = nil
    
    var selectedIndex : Int = -1
    
    var address : String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "AllCategory"
        
        setUp()
       
    }
    
    func setUp() {
        tableView = UITableView(frame: view.bounds)
        tableView!.delegate = self
        tableView!.dataSource = self
        tableView?.tableFooterView = UIView()
        
        self.view.addSubview(tableView!)
        
        let rightBtn = UIBarButtonItem(image: UIImage.init(systemName: "plus.circle"), style: UIBarButtonItem.Style(rawValue: 0)!, target: self, action: #selector(addCategory) )
        self.navigationItem.rightBarButtonItem = rightBtn
    }

    @objc func addCategory() {
        let alert = UIAlertController(title: "添加新文件夹", message: "输入文件夹名称", preferredStyle: UIAlertController.Style(rawValue: 1)! )
        alert.addTextField { (textField) in
            textField.placeholder = "输入名称"
        }
        
        let actionYes = UIAlertAction(title: "好", style: UIAlertAction.Style(rawValue: 0)! ) { (yes) in
            
            let temp = Category(title: alert.textFields!.first!.text!, detail: nil)
            self.textCombine.append(temp)
            
            print(alert.textFields!.first!.text!)
            
            self.tableView?.reloadData()
        }
        
        let actionNo = UIAlertAction(title: "取消", style: UIAlertAction.Style(rawValue: 2)! ) { (no) in
            
        }
        
        alert.addAction(actionNo)
        alert.addAction(actionYes)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateAll(allNote: Array<Note>) {
        var temp = self.textCombine[selectedIndex]
        temp.detail = allNote
        
        self.textCombine[selectedIndex] = temp
        
    }
    
    func store(dataToStore : Array<Any>){
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textCombine.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.imageView?.image = UIImage.init(systemName: "sun.min")
        cell.textLabel?.text = textCombine[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.selectedIndex = indexPath.row
        
        let vc = AllNoteController()
        vc.noteCombine = textCombine[indexPath.row].detail ?? []
        vc.delegate = self
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

