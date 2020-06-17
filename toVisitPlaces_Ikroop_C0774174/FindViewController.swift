//
//  ViewController.swift
//  toVisitPlaces_Ikroop_C0774174
//
//  Created by VirkIkroop on 2020-06-14.
//  Copyright © 2020 VirkIkroop. All rights reserved.
//

import UIKit

class FindViewController: UITableViewController{
    var places : [Places]?
        
        var deleteArray : [Places]?
        
        let defaults = UserDefaults.standard
        
        override func viewDidLoad() {
            super.viewDidLoad()
        
        }
        
        override func viewWillAppear(_ animated: Bool) {
            loadData()
            self.tableView.reloadData()
            
        }
        
        func getDataFilePath() -> String {
               let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
               let filePath = documentPath.appending("/places-data.txt")
               return filePath
           }
        
        func loadData() {
            places = [Places]()
            
            let filePath = getDataFilePath()
            
            if FileManager.default.fileExists(atPath: filePath){
                do{
                    //creating string of file path
                 let fileContent = try String(contentsOfFile: filePath)
                    
                    let contentArray = fileContent.components(separatedBy: "\n")
                    for content in contentArray{
                       
                        let placeContent = content.components(separatedBy: ",")
                        if placeContent.count == 6 {
                            let place = Places(placeLat: Double(placeContent[0]) ?? 0.0, placeLong: Double(placeContent[1]) ?? 0.0, placeName: placeContent[2], city: placeContent[3], postalCode: placeContent[4], country: placeContent[5])
                            places?.append(place)
                        }
                }
 
                }
                catch{
                    print(error)
                }
            }
        }
        
        func deleteRow() {
            let filePath = getDataFilePath()

            var saveString = ""
            for place in self.deleteArray!{
               saveString = "\(saveString)\(place.placeLat),\(place.placeLong),\(place.placeName),\(place.city),\(place.country),\(place.postalCode)\n"
                do{
               try saveString.write(toFile: filePath, atomically: true, encoding: .utf8)
                }
                catch{
                    print(error)
                }
            }
        }

      
      

        override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return places?.count ?? 0
        }

        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let place = self.places![indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell")
            cell?.textLabel?.text = place.placeName + " , " + place.city
            cell?.detailTextLabel?.text = place.country + " , " + place.postalCode
            
    //        cell?.contentView.backgroundColor = UIColor.
        
    //        print(place.placeName, place.country)
            return cell!
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        }

      
        
       
        // Override to support editing the table view.
        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
            if editingStyle == .delete {
                
                self.places?.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                
                self.deleteArray = self.places
                deleteRow()
            
                
            }
        }
        

       
    }

