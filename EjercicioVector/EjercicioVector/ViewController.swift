//
//  ViewController.swift
//  EjercicioVector
//
//  Created by Francisco Paramo Muñoz on 17/6/18.
//  Copyright © 2018 Francisco Paramo Muñoz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var table: UITableView!
    var connectPersons = ConnectPersons()
    var page = 1
    var loading : UIActivityIndicatorView?
    var personas : [Person] = [Person]()
    
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var topSearchView: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Ramdoms users list"
        // Do any additional setup after loading the view, typically from a nib.
        txtSearch.delegate = self
        connectPersons.delegate = self
        
        let nib = UINib(nibName: "personCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "cell")
        
        table.delegate = self
        table.dataSource = self
        showLoading()
        connectPersons.getPersons(page: page)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showSearch(_ sender: Any) {
        if topSearchView.constant == 0
        {
            UIView.animate(withDuration: 2) {
                self.topSearchView.constant = -44
            }
        }else{
            UIView.animate(withDuration: 2) {
                self.topSearchView.constant = 0
            }
        }
    }
    
    func showLoading() {
        loading = UIActivityIndicatorView(frame: UIScreen.main.bounds)
        loading?.startAnimating()
        loading?.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.5)
        self.view.addSubview(loading!)
        self.view.bringSubview(toFront: loading!)
    }
    
    func search(word : String){
        if word.trimmingCharacters(in:.whitespaces) == "" {
            personas.removeAll()
            for person in connectPersons.persons {
                personas.append(person)
            }
        }
        else {
            personas.removeAll()
            for person in connectPersons.persons {
                if person.name.lowercased().range(of:word.lowercased()) != nil {
                    personas.append(person)
                }
            }
        }
        table.reloadData()
    }
    
    @IBAction func loadClick(_ sender: Any) {
        page = 1
        txtSearch.text = ""
        showLoading()
        connectPersons.getPersons(page: page)
    }
    
}


extension ViewController : ConnectBaseDelegate {
    func startService(service: String) {
        print("Service: " + service)
    }
    
    func handleResult(isOk: Bool, service: String, error: Any?) {
        loading?.removeFromSuperview()
        if isOk {
            if service == "persons" {
                personas.removeAll()
                for person in connectPersons.persons {
                    personas.append(person)
                }
                table.reloadData()
            }
        }
    }
}


extension ViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        search(word: txtSearch.text!)
        txtSearch.resignFirstResponder()
        return true
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! personCell
        let person = personas[indexPath.row]
        if person.picture.thumb != "" {
            cell.photo.layer.cornerRadius = cell.photo.frame.size.width / 2
            cell.photo.clipsToBounds = true
            cell.photo.loadImageUsingCache(withUrl: person.picture.thumb)
        }
        cell.name.text = person.name
        cell.cell.text = person.cell
        cell.email.text = person.email
        if indexPath.row == connectPersons.persons.count - 1
        {
            page += 1
            showLoading()
            connectPersons.getPersons(page: page)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = personas[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "details") as! DetailViewController
        vc.person = person
        navigationController?.pushViewController(vc,
                                                 animated: true)
    }
    
}
