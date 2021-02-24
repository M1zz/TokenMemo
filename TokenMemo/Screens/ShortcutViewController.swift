//
//  ShortcutViewController.swift
//  TokenMemo
//
//  Created by 이현호 on 2020/12/05.
//

import UIKit

class ShortcutViewController: UIViewController {
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var shortcutView: UIView!
    @IBOutlet weak var shortcutTextView: UITextView!
    lazy var backdropView: UIView = {
        let bdView = UIView(frame: self.view.bounds)
        bdView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return bdView
    }()
    
    let shortcutHeight = UIScreen.main.bounds.height / 2
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        view.addSubview(backdropView)
        view.addSubview(shortcutView)
        
        doneButton.addTarget(self, action: #selector(dissmissViewController), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        backdropView.addGestureRecognizer(tapGesture)
        
        shortcutTextView.text = UIPasteboard.general.string
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }

        self.view.frame.origin.y = 0 - keyboardSize.height
    }
    
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    
    @IBAction func addShortcutButtonClicked(_ sender: Any) {
        guard let presentingViewController = self.presentingViewController else { return }
        
        self.dismiss(animated: true, completion: {
            if let addMemoView = self.storyboard?.instantiateViewController(withIdentifier: "addMemoBoardID") {
                addMemoView.modalPresentationStyle = .fullScreen
                presentingViewController.present(addMemoView, animated: true, completion: nil)
            }
        })
    }
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @objc func dissmissViewController() {
        dismiss(animated: true)
    }
}
