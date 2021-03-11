//
//  AllNoteController.swift
//  Note-swift
//
//  Created by tino又想吃肉了 on 2021/2/9.
//

import UIKit
protocol updateAll {
    func updateAll(allNote:Array<Note>)
}

class AllNoteController: UIViewController,UITableViewDelegate,UITableViewDataSource,refreshNote {
    
    var noteCombine : Array<Note> = []
    
    var tableView : UITableView? = nil
    
    var selectedIndex : Int = -1
    
    var delegate : updateAll?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "AllNote"
        
        setUp()
    }
    
    private func setUp() {
        let rightBtn = UIBarButtonItem(image: UIImage.init(systemName: "plus.circle"), style: UIBarButtonItem.Style(rawValue: 0)!, target: self, action: #selector(addNote) )
        self.navigationItem.rightBarButtonItem = rightBtn
        
        self.tableView = UITableView(frame: view.bounds)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.tableFooterView = UIView()
        
        view.addSubview(self.tableView!)
    }

    @objc func addNote() {
        let alert = UIAlertController(title: "添加新备忘录", message: "输入备忘录标题", preferredStyle: UIAlertController.Style(rawValue: 1)! )
        alert.addTextField { (textField) in
            textField.placeholder = "输入标题"
        }
        
        let actionYes = UIAlertAction(title: "好", style: UIAlertAction.Style(rawValue: 0)! ) { (yes) in
            
            self.noteCombine.append(Note(title: alert.textFields!.first!.text!, detail: nil))
            
            print(alert.textFields!.first!.text!)
            
            self.tableView?.reloadData()
            self.delegate?.updateAll(allNote: self.noteCombine)
        }
        
        let actionNo = UIAlertAction(title: "取消", style: UIAlertAction.Style(rawValue: 2)! ) { (no) in
            
        }
        
        alert.addAction(actionNo)
        alert.addAction(actionYes)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteCombine.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = noteCombine[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedIndex = indexPath.row
        
        let vc = DetailNoteController()
        vc.text = noteCombine[indexPath.row].detail ?? ""
        vc.delegate = self
        vc.title = self.noteCombine[indexPath.row].title
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func updateNote(note:String) {
        //var text = noteCombine[selectedIndex]
        noteCombine[selectedIndex].detail = note
        
        self.tableView?.reloadData()
        
        self.delegate?.updateAll(allNote: self.noteCombine)
    }
}
