//
//  DetailNoteController.swift
//  Note-swift
//
//  Created by tino又想吃肉了 on 2021/2/9.
//

import UIKit

protocol refreshNote {
    func updateNote(note:String)
}

class DetailNoteController: UIViewController,UITextViewDelegate {
    let SreenWidth = UIScreen.main.bounds.size.width
    
    let SreenHeight = UIScreen.main.bounds.size.height
    
    var delegate : refreshNote?
    
    var text : String = ""
    
    var textView : UITextView? = nil
    
    var tool : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //title = "Detail Note"
        
        textView = UITextView(frame: view.bounds)
        view.addSubview(textView!)
        textView!.font = UIFont.systemFont(ofSize: 25)
        textView!.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView?.text = self.text
        textView?.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        if(self.text != self.textView!.text){
            self.delegate?.updateNote(note: self.textView!.text)
        }else{
            
        }
        
    }
    
    func setupToolBar() -> UIView{
        let bgView = UIView(frame: CGRect(x: 10, y: self.SreenHeight - 200, width: self.SreenWidth - 20, height: 80))
        bgView.layer.cornerRadius = 15
        bgView.backgroundColor = UIColor(white: 0.8, alpha: 0.9)
        bgView.isHidden = true
        self.textView!.addSubview(bgView)
        
        return bgView
    }
    
    func textViewDidBeginEditing(_ textView: UITextView){
        self.tool = setupToolBar()
        UIView.animate(withDuration: 1) {
            
            self.tool?.isHidden = false
            self.tool?.alpha = 0.2
            self.tool?.alpha = 1
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView){
        UIView.animate(withDuration: 1) {
            self.tool?.isHidden = true
        }
    }
}
