//
//  personalVC.swift
//  
//
//  Created by Erica Wang on 2017-07-25.
//
//

import UIKit
import Firebase

class personalVC: UIViewController {
    @IBOutlet weak var nameLbl: UILabel!

    @IBOutlet weak var serialLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var peopleLbl: UILabel!
    @IBOutlet weak var provinceLbl: UILabel!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var energyLbl: UILabel!
    
    @IBOutlet weak var promoLbl: UITextView!
    
    var name = String()
    var serial = String()
    var email = String()
    var province = String()
    var people = String()
    var promo = String()
    var energy = String()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
        menuButton.target = self.revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        var email = FIRAuth.auth()?.currentUser?.email as! String
        
        FIRDatabase.database().reference().child("Users").observe(.childAdded, with: {
            snapshot in
            
            let snapshotValue = snapshot.value as? NSDictionary
            
            self.name = (snapshotValue?["Name"] as? String)!
            self.serial = (snapshotValue?["Serial"] as? String)!
            self.email = (snapshotValue?["Email"] as? String)!
            self.province = (snapshotValue?["Province"] as? String)!
            self.people = (snapshotValue?["Number of people"] as? String)!
            self.promo = FIRAuth.auth()?.currentUser?.uid as! String
            self.energy = (snapshotValue?["Milestone"] as? String)!
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func seeAction(_ sender: Any) {
        nameLbl.text = "Name: \(name)"
        serialLbl.text = "Serial Number: \(serial)"
        emailLbl.text = "Email: \(email)"
        provinceLbl.text = "Province: \(province)"
        peopleLbl.text = "# of people in household: \(people)"
        promoLbl.text = "Promotion code: \(promo)"
        energyLbl.text = "Next milestone: \(energy)"
        
        nameLbl.isHidden = false
        serialLbl.isHidden = false
        emailLbl.isHidden = false
        provinceLbl.isHidden = false
        peopleLbl.isHidden = false
        promoLbl.isHidden = false
        energyLbl.isHidden = false
    }

}
