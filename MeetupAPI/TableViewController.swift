//
//  TableViewController.swift
//  MeetupAPI
//
//  Created by Andrew Barber on 10/2/16.
//  Copyright © 2016 Invictus. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var cityListings : UITableView!
    
    class CityMeetUps {
        
        let city : String?
        let state : String?
        
        init (city : String?, state : String?) {
            
            self.city = city
            self.state = state
            
        }
        
    }
    
    
    
    var cities = [CityMeetUps]()
    var cityMeetUpsAPI : String = "API STRING GOES HERE YEAH"
    
    //-----------------------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityListings.delegate = self
        cityListings.dataSource = self

        
        let url = URL(string : cityMeetUpsAPI)
        
        //------------------------------------------------------------------------------------------
        
        if let url = url {
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: url, completionHandler: { (data, reponse, error) in
                
                guard let data = data else { return }
                
                var json: Any?
                do {
                    json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                } catch let error {
                    print("error = \(error)")
                }
            
                if let json = json as? [[String : AnyObject]] {
                    
                    for dictionary in json {
                        
                        let city = dictionary["INFORMATION NEEDED HERE"] as? String
                        let state = dictionary["INFORMATION NEEDED HERE"] as? String
                        
                        let selectedCity = CityMeetUps(city: city, state : state)
                        
                        self.cities.append(selectedCity)
                        
                        print("\(selectedCity.city) \(selectedCity.state)")
                        
                    }
                    
                }
                
                DispatchQueue.main.async {
                    self.cityListings.reloadData()
                }
                
        })
        
            task.resume()
            
    }
    //-----------------------------------------------------------------------------------------------
    func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    //-----------------------------------------------------------------------------------------------
    
        func tableView(_ : UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return cities.count
            
        }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomCell
        
        let yourCity = cities[indexPath.row]
        
        cell.city.text = yourCity.city
        cell.state.text = yourCity.state
        
        return cell
        
    }

}

}
