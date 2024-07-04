//
//  ViewController.swift
//  album_Demo
//
//  Created by Jay on 03/07/24.
//

import UIKit
import Alamofire
import ObjectMapper
import NVActivityIndicatorView

let loaderSize = CGSize(width: 30, height: 30)

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    //MARK: ------------------------- IBOUTLETS -------------------------
    
    @IBOutlet weak var albumSearch: UISearchBar!
    
    @IBOutlet weak var albumTable: UITableView!
    
    @IBOutlet weak var albumSegment: UISegmentedControl!
    
    var modelAlbumData = [albumdata]?.self
    
    
    //MARK: ------------------------- VIEWDIDLOAD -------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.albumTable.delegate = self
        self.albumTable.dataSource = self
        
        self.getapicall()
    }

    
    //MARK: ------------------------- IBACTIONS -------------------------
    
    @IBAction func onClickAlbumSegment(_ sender: UISegmentedControl) {
        
    }
    
    
    //MARK: ------------------------- FUNCTIONS -------------------------
    
    func getapicall() {
        let URL = "https://jsonplaceholder.typicode.com/todos"
        
        Alamofire.request(URL).responseJSON { resp in
            switch resp.result {
            case .success(let val):
                print(val)
                
                //MAPPING DATA IN MODEL
                if let jsonArray = val as? [[String: Any]] {
                    let users = Mapper<albumdata>().mapArray(JSONArray: jsonArray)
                } else {
                    print("error data")
                }
                
                //CONVERTING DATA TO DICT. OR ARRAY (JSON PARSING)
                if let value = resp.data {
                    do{
//                        let output = try JSONSerialization.jsonObject(with: value, options: []) as? [String:Any]
//                        let tempDict = output! as NSDictionary
//                        self.tempCouponDataArr = tempDict.object(forKey: "couponData") as? NSArray
//                        let otherShared = tempDict.object(forKey: "otherShared") as? Bool
//                        let shareCoupon = tempDict.object(forKey: "shareCoupon") as? String
//                        let dict = getCouponResponseBase.init(dictionary: tempDict)
//                        self.modelCouponData = dict?.couponData
//                        self.couponTableView.reloadData()
//                        self.stopLoad()
                    }
                    catch {
//                        print("error")
//                        self.stopLoad()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
//    func filterContentForSearchText(_ searchText: String) {
//        filterdata = modelCouponData?.filter({ (template: CouponData) -> Bool in
//            let name = template.couponTitle
//            let Name = name?.range(of: searchText, options: String.CompareOptions.caseInsensitive, range: nil, locale: nil)
//         
//          return Name != nil
//        })
//    }
    
    //MARK: ------------------------- DELEGATES -------------------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.albumTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = "Name: " + persons[indexPath.row].name + ", Age: " + String(persons[indexPath.row].age)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    //SEARCH DELEGATES
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchTxt = searchBar.text {
            
        }
    }
    
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        <#code#>
//    }
//    
//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        <#code#>
//    }
    
    
    
}

//MARK: ------------------------- EXTENSIONS -------------------------

extension UIViewController : NVActivityIndicatorViewable {
    func startLoad() {
        startAnimating(loaderSize, type: .ballPulse, color: .white)
    }
    func stopLoad() {
        stopAnimating()
    }
}

