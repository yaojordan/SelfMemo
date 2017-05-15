//
//  AddViewController.swift
//  SelfMemo
//
//  Created by 姚宇鴻 on 2017/5/13.
//  Copyright © 2017年 JordanYao. All rights reserved.
//

import UIKit
import Lottie

class AddViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var ContentsText: UITextView!
    
    @IBAction func SaveTapped(_ sender: UIButton) {
        
        //guard用法，
        //let enterContents = ContentsText?.text
        //if enterContents == nil{ return }
        guard let enterContents = ContentsText?.text else{
            return
        }
        
        
        if enterContents.isEmpty || ContentsText?.text == "Write down something..."
        {
            
            let alertMessage = UIAlertController(title: "Please Type Something", message: "Your entry was left blank.", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
            
            
        }else{
            
            if let appdelegate = (UIApplication.shared.delegate as? AppDelegate){
                
                let newContents = Memo(context: appdelegate.persistentContainer.viewContext)
                newContents.contents = enterContents
                
                appdelegate.saveContext()
                
                
                /*Lottie Demo*/
                if let animationView = LOTAnimationView(name: "pencil_write") {
                    
                    animationView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
                    animationView.center = self.view.center
                    animationView.contentMode = .scaleAspectFill
                    
                    view.addSubview(animationView)
                    
                    animationView.play()
                }
                
                dismiss(animated: true, completion: nil)
                
            }
            
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //讓UITextViewDelegate中的協定有動作
        ContentsText?.delegate = self
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
