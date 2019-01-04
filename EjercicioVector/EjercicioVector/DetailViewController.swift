//
//  DetailViewController.swift
//  EjercicioVector
//
//  Created by Francisco Paramo Muñoz on 17/6/18.
//  Copyright © 2018 Francisco Paramo Muñoz. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var cell: UILabel!
    @IBOutlet weak var email: UILabel!
    
    var person : Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photo.loadImageUsingCache(withUrl: (person?.picture.large)!)
        name.text = person?.name
        cell.text = person?.cell
        email.text = person?.email
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
