//
//  ViewController.swift
//  server data
//
//  Created by Syed.Reshma Ruksana on 1/25/20.
//  Copyright © 2020 Syed.Reshma Ruksana. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    


    
    var tableview:UITableView!
    
    
    var bikeModels = [String]()
    
    var id = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        serverData()
        
        tableview = UITableView()
        tableview = UITableView(frame: view.frame, style: UITableView.Style.grouped)
        
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.register( UITableViewCell.self, forCellReuseIdentifier: "abc")
        view.addSubview(tableview)
        
        // Do any additional setup after loading the view.
    }


func serverData()
{
    
    let stringURL = "https://rhtvhdthuh.execute-api.ap-South-1.amazonaws.com/dev/bikebrandmodels"
    let URLLink = URL(string: stringURL)
    var request = URLRequest(url: URLLink!)
   
    
   
    let task = URLSession.shared.dataTask(with: request) { (data, connection, error)
        in
        guard let data = data else {
            
            print("error")
            return
        }
        
        
        let jsonData =  try? (JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any])
        
        print(jsonData)
        
//        request.httpMethod = "POST"
//        request.httpBody = jsonData![String]
        
        
        
        let bikeBrands = jsonData!["BikeBrandModels"] as!  [[String:Any]]
        
        for data in 0..<bikeBrands.count
        {
            
            let name =  bikeBrands[data]["BrandName"] as! String
            self.bikeModels.append("\(name)")
           
            
            var modelID = bikeBrands[data]["BrandID"] as! Int64
            self.id.append("\(modelID)")
            
            
            
            
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
            
            
        }
    }
//            URLRequestObj = URLRequest(url: URL(string: ! )
//
//            URLRequestObj.httpMethod =  "GET"
//
//    dataTaskObj = URLSession.shared.dataTask(with: URLRequestObj, completionHandler: { (data, URLResponse, Error) in
//
//        do{
//            var convertedData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
//
//             print(convertedData)
//
            
            
        

   
//     https://jsonplaceholder.typicode.com/
//        "https://jsonplaceholder.typicode.com/comments"
        
   
    task.resume()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bikeModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell =  tableView.dequeueReusableCell(withIdentifier: "abc", for: indexPath)
        
        cell.textLabel?.text=id[indexPath.row]
//        cell.textLabel?.text = bikeModels [indexPath.row]
        
        
        
        return cell
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

