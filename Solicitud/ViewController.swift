//
//  ViewController.swift
//  Solicitud
//
//  Created by LABMAC02 on 05/04/19.
//  Copyright © 2019 UTNG. All rights reserved.
//

import UIKit
import Firebase

import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = myList[indexPath.row]
        return cell
    }
    
    var ref = DatabaseReference.init()
    
    
    @IBOutlet var textPersonText: UITextField!
    
    @IBOutlet var txtTelNum: UITextField!
    
    @IBOutlet var txtAddresText: UITextField!
    
    @IBOutlet var txtPositionText: UITextField!
    
    @IBOutlet var myTab: UITableView!
    
    var myList:[String] = []
    var handle:DatabaseHandle?
    //var ref :DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loginAnony()
        self.ref = Database.database().reference()
        listar()
        
    }
    

    func loginAnony() {
        Auth.auth().signInAnonymously(){
            (user, error) in
            //code here
        
            if let error = error {
                print("Cannot login: \(error)")
            }else{
                print("user UID \(String(describing: user?.user))")
    }
    
}
    }
        
        
    @IBAction func buSendToRom(_ sender: Any) {
        
        let txt = ["nombre" : textPersonText.text!,
                   "numero" : txtTelNum.text!,
                   "Addres" : txtAddresText.text!,
                   "Possition" : txtPositionText.text!]
        
        self.ref.child("Name").child(textPersonText.text!).setValue(txt)
        textPersonText.text! = ""
        txtTelNum.text! = ""
        txtAddresText.text! = ""
        txtPositionText.text! = ""
        
    
    }
    
    @IBAction func butUpdate(_ sender: Any) {
        
        self.ref.child("Name").child(textPersonText.text!).setValue(["nombre": textPersonText.text!,"numero": txtTelNum.text!, "Addres": txtAddresText.text!, "Possition": txtPositionText.text!])
        textPersonText.text! = ""
        txtTelNum.text! = ""
        txtAddresText.text! = ""
        txtPositionText.text! = ""
        listar()
    }
    
    
    
    @IBAction func butDelate(_ sender: Any) {
        
        self.ref.child("Name").child(textPersonText.text!).removeValue()
        textPersonText.text! = ""
        txtTelNum.text! = ""
        txtAddresText.text! = ""
        txtPositionText.text! = ""
        listar()
    }
    
    @IBAction func butMost(_ sender: Any) {
        
    }
    
    func listar() {
        self.myList.removeAll()
       // self.myTab.reloadData()
        handle = self.ref.child("Name").observe(.childAdded, with: { (snapshot) in
           if let item = snapshot.value as? [String : String]{
            self.myList.append(" \(item["nombre"]!) \(item["numero"]!)")
            self.myTab.numberOfRows(inSection: self.myList.count)
            self.myTab.reloadData()
              }
            
            
        })
       
       
}

}
