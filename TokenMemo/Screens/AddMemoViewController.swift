//
//  AddMemoViewController.swift
//  TokenMemo
//
//  Created by 이현호 on 2020/12/03.
//

import UIKit

class AddMemoViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var addMemoButton: UIButton!
    @IBOutlet weak var addMemoButtonBottomConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillTextIfExist()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        titleTextField.text = ""
        descriptionTextView.text = ""

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    private func fillTextIfExist() {
        if let content = UIPasteboard.general.string,
           self.modalTransitionStyle == .coverVertical {
            descriptionTextView.text = content
        }
    }
    
    
    private func saveAllData() {
        PersistenceManager.save(memos: list)
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        addMemoButtonBottomConstraint.constant = keyboardSize.height
        UIView.animate(withDuration: 0.30, delay: 0.1 ,animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    
    @objc func keyboardWillHide(notification: NSNotification) {
        addMemoButtonBottomConstraint.constant = 16
        UIView.animate(withDuration: 0.30, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    
    @IBAction func clickedAddMemoButton(_ sender: Any) {
        guard let title = titleTextField.text, let description = descriptionTextView.text else {
            // TODO: Alert
            return
        }
        
        let item: MemoItem = MemoItem(title: title, description: description)
        list.append(item)
        
        saveAllData()
        
        HelperFunctions.makeToast("저장되었습니다.")
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    @IBAction func removeAllButtonClicked(_ sender: Any) {
        titleTextField.text = ""
        descriptionTextView.text = ""
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}
