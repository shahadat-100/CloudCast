//
//  LocationViewController.swift
//  CloudCast
//
//  Created by shahadat on 11/1/25.
//

import UIKit

class LocationViewController: UIViewController {

    @IBOutlet weak var LocationTable: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()

      
        
        LocationTable.delegate = self
        LocationTable.dataSource = self
        
        LocationTable.register(UINib(nibName: "LocationTableViewCell", bundle: nil), forCellReuseIdentifier: "LocationTableViewCell")
        
        
    }
   
}


extension LocationViewController:UITableViewDelegate
{
    
}

extension LocationViewController:UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let tableViewCell = self.LocationTable.dequeueReusableCell(withIdentifier: "LocationTableViewCell") as? LocationTableViewCell else
        {
            return UITableViewCell()
        }
        
        return tableViewCell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 185
    }
    
    
}
