//
//  AddItemTableViewController.swift
//  CheckLists
//
//  Created by Dzhami Rakhmetov on 6/10/22.
//

import UIKit
import UserNotifications

protocol ItemDetailViewControllerDelegate: AnyObject {
    func itemDetailViewControllerDidCancel(_ controller : ItemDetailViewController)
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem)
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem)
}

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var shouldRemindSwitch: UISwitch!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    weak var delegate : ItemDetailViewControllerDelegate?
    var itemToEdit : ChecklistItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if let item = itemToEdit {
            title = "Edit item"
            textField.text = item.text
            doneBarButton.isEnabled = true
            shouldRemindSwitch.isOn = item.shouldRemind
            datePicker.date = item.dueDate
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder() // keyboard automatically showed up when the screen opened
    }
    
    // MARK: - Actions
    
    @IBAction func cancel() {
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        if let item = itemToEdit {
            item.text = textField.text!
            item.shouldRemind = shouldRemindSwitch.isOn
            item.dueDate = datePicker.date
            item.scheduleNotification()
            
            delegate?.itemDetailViewController(self, didFinishEditing: item)
            
        } else {
          let item = ChecklistItem()
          item.text = textField.text!
          item.shouldRemind = shouldRemindSwitch.isOn
          item.dueDate = datePicker.date
          item.scheduleNotification()
            
          delegate?.itemDetailViewController(self, didFinishAdding: item)
        }
      }
    
    @IBAction func shouldRemindToggled( _ switchControl : UISwitch){
        textField.resignFirstResponder()
        
          if switchControl.isOn {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .sound]) {_, _ in
                // do nothing
        }
    }
}
    // MARK: - Table View Delegates
    
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil // deselect row
    }
    
    // MARK: - Text Field Delegates
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        doneBarButton.isEnabled = !newText.isEmpty // if the text is not empty, enable the button Otherwise, don’t enable it
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        doneBarButton.isEnabled = false
        return true // handling clear button
    }
}
