//
//  HomeViewController.swift
//  TripShip
//
//  Created by user 1 on 31/07/2017.
//  Copyright © 2017 ahmad. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    let locationMgr = CLLocationManager()
    
    var activeField: UITextField?
    //Mark : View Life Cycle method...
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.scrollView.contentSize = CGSize(width: 320, height: 568)
        let tap = UITapGestureRecognizer(target: self, action: #selector
            (tapFunction))
        self.scrollView.addGestureRecognizer(tap)
        
        //register notification
        self.registerForKeyboardNotifications()
        //end
        
        //set Textfield delegate
        self.emailField.delegate = self
        self.passwordField.delegate = self
        
        self.emailField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0);
        self.passwordField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0);
        self.emailField.tintColor = UIColor.white
        self.passwordField.tintColor = UIColor.white

        self.getLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark: UITapGesture method
    func tapFunction(sender:UITapGestureRecognizer){
        self.emailField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
    }
    //end
    
    //Mark: UITextField delegate functions
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.emailField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        activeField = nil
    }
    //end

    
    //Mark: keyboard methods
    func registerForKeyboardNotifications()
    {
        //Adding notifies on keyboard appearing
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    func deregisterFromKeyboardNotifications()
    {
        //Removing notifies on keyboard appearing
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWasShown(notification: NSNotification)
    {
        //Need to calculate keyboard exact size due to Apple suggestions
        //        self.scrollView.isScrollEnabled = true
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
        
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        if let activeField = self.activeField {
            if (!aRect.contains(activeField.frame.origin)){
                self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
        
    }
    
    func keyboardWillBeHidden(notification: NSNotification)
    {
        //Once keyboard disappears, restore original positions
        //apple method
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @IBAction func signupBtnClicked(_ sender: UIButton) {
        let vc = SignupViewController(
            nibName: "SignupViewController",
            bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func signinBtnClicked(_ sender: UIButton) {
        let vc = MapViewController(
            nibName: "MapViewController",
            bundle: nil)
//        vc.askLocation = true
        
        // 3
        let status  = CLLocationManager.authorizationStatus()
        if status == .denied || status == .restricted {
            vc.isAuthorized = false
        }
        else if(status == .authorizedWhenInUse){
            vc.isAuthorized = true
        }

        self.present(vc, animated: true, completion: nil)
    }
    
    
    func getLocation(){
        let status  = CLLocationManager.authorizationStatus()
        
        // 2
        if status == .notDetermined {
            locationMgr.requestWhenInUseAuthorization()
        //            return
        }
        
        // 3
        if status == .denied || status == .restricted {
        }
        
       
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
