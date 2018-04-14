//
//  ViewController.swift
//  EjercicioHasten
//
//  Created by Francisco Paramo Muñoz on 14/4/18.
//  Copyright © 2018 Francisco Paramo Muñoz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var table: UITableView!
    var connectPlayers = ConnectPlayers()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        connectPlayers.delegate = self
        
        let nib = UINib(nibName: "playerCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "cell")
        
        table.delegate = self
        table.dataSource = self
        connectPlayers.getPlayers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController : ConnectBaseDelegate {
    func startService(service: String) {
        print("Service: " + service)
    }
    
    func handleResult(isOk: Bool, service: String, error: Any?) {
        if isOk {
            if service == "players" {
                table.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return connectPlayers.games.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 25))
        view.backgroundColor = UIColor(red: 253.0/255.0, green: 240.0/255.0, blue: 196.0/255.0, alpha: 1)
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width - 30, height: 25))
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.black
        label.text = connectPlayers.games[section].name
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return connectPlayers.games[section].listPlayers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! playerCell
        let player = connectPlayers.games[indexPath.section].listPlayers[indexPath.row]
        if player.image != "" {
            cell.photo.loadImageUsingCache(withUrl: player.image)
        }
        cell.name.text = player.name
        cell.lastname.text = player.surname
        cell.year.text = player.date
        return cell
    }
    
}

