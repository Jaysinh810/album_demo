//
//  ViewController.swift
//  album_Demo
//
//  Created by Jay on 03/07/24.
//

import UIKit
import Alamofire
//import ObjectMapper
import NVActivityIndicatorView

let loaderSize = CGSize(width: 30, height: 30)

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    //MARK: ------------------------- IBOUTLETS -------------------------
    
    @IBOutlet weak var albumSearch: UISearchBar!
    
    @IBOutlet weak var albumTable: UITableView!
    
    @IBOutlet weak var albumSegment: UISegmentedControl!
    
    var modelUserData = [userModel]()
    
    
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
        
        AF.request(URL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { resp in
            switch resp.result {
            case .success(let value):
                do {
                    let jsonData = try JSONDecoder().decode([userModel].self, from: value!)
//                    print(jsonData)
                    
                    DispatchQueue.main.async {
//                        self?.data = fetchedData
                        self.modelUserData = jsonData
                        self.albumTable.reloadData()
                    }
                    
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
//        Alamofire.request(URL).responseJSON { resp in
//            switch resp.result {
//            case .success(let val):
//                print(val)
////                let responseModel = try JSOnd
//                
//            case .failure(let error):
//                print(error)
//            }
//        }
        
        
        
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
        return self.modelUserData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.albumTable.dequeueReusableCell(withIdentifier: "albumTableViewCell", for: indexPath) as! albumTableViewCell
        cell.selectionStyle = .none
        let userdata = modelUserData[indexPath.row]
        
        cell.useridLbl.text = "User ID : \(userdata.userId ?? 0)"
        cell.titleLbl.text = "Title : \(userdata.title ?? "")"
        cell.userImgView.image = UIImage(systemName: "person.circle")
        
//        cell.textLabel?.text = "Name: " + persons[indexPath.row].name + ", Age: " + String(persons[indexPath.row].age)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.albumTable.dequeueReusableCell(withIdentifier: "albumTableViewCell") as! albumTableViewCell
        cell.selectionStyle = .none
        let userdata = modelUserData[indexPath.row]
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "detailVC") as! detailVC
        vc.userid = userdata.userId
        vc.userTitle = userdata.title
//        vc.userImg = cell.userImgView.image
//        vc.favImg = 
        self.navigationController?.pushViewController(vc, animated: true)
        
//        self.albumTable.deselectRow(at: indexPath, animated: true)
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

