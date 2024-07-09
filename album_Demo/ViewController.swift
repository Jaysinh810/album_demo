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
    
    @IBOutlet weak var nodataLbl: UILabel!
    @IBOutlet weak var albumTable: UITableView!
    
    @IBOutlet weak var albumSegment: UISegmentedControl!
    
    var modelUserData = [userModel]()
    var filterFavouriteData = [userModel]()
    var filterSearchData = [userModel]()
    var favFlag: Bool = false
    var searchFlag: Bool = false
    
    
    //MARK: ------------------------- VIEWDIDLOAD -------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.albumTable.delegate = self
        self.albumTable.dataSource = self
        self.albumSearch.delegate = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        
        self.getapicall()
    }

    
    //MARK: ------------------------- IBACTIONS -------------------------
    
    @IBAction func onClickAlbumSegment(_ sender: UISegmentedControl) {
        switch self.albumSegment.selectedSegmentIndex {
        case 0:
            self.favFlag = false
            self.albumSearch.isHidden = false
            self.nodataLbl.isHidden = true
            self.albumTable.reloadData()
        case 1:
            self.favFlag = true
            self.albumSearch.isHidden = true
            self.onSelectFavouriteSegment()
            self.albumTable.reloadData()
        default:
            return;
        }
    }
    
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        let index = sender.view?.tag
        print("==> starred index", index!)
        modelUserData[index ?? 0].isFavourite.toggle()
        print("==> flag", modelUserData[index!].isFavourite)
//        print(modelUserData)
//        print(self.filterFavouriteData)
        self.onSelectFavouriteSegment()
        self.albumTable.reloadData()
        
//        self.albumTable.reloadRows(at: [IndexPath(row: index ?? 0, section: 0)], with: .automatic)
        
    }
    
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        self.albumSearch.resignFirstResponder()
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
    
    func onSelectFavouriteSegment() {
        if self.favFlag == true {
            self.filterFavouriteData = self.modelUserData.filter({$0.isFavourite})
//            print("--", self.filterFavouriteData)
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
        if self.favFlag == true {
            if self.filterFavouriteData.count == 0 {
                self.nodataLbl.isHidden = false
                return self.filterFavouriteData.count
            }
            self.nodataLbl.isHidden = true
            return self.filterFavouriteData.count
        }
        if self.searchFlag == true {
            return self.filterSearchData.count
        }
        return self.modelUserData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TO STORE DATA IN USERDEFAULTS
//        var rowsWhichAreChecked = UserDefaults.standard.array(forKey: "workoutFavorite") as? [userModel] ?? [userModel]()
        let cell = self.albumTable.dequeueReusableCell(withIdentifier: "albumTableViewCell", for: indexPath) as! albumTableViewCell
        
        cell.favouriteBtn.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        cell.favouriteBtn.addGestureRecognizer(tapGestureRecognizer)
        
        cell.selectionStyle = .none
//        let userdata = modelUserData[indexPath.row]
        if favFlag == true {
            let userdata = filterFavouriteData[indexPath.row]
            cell.useridLbl.text = "User ID : \(userdata.userId ?? 0)"
            cell.titleLbl.text = "Title : \(userdata.title ?? "")"
            cell.favouriteBtn.image = userdata.isFavourite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
            cell.favouriteBtn.tag = (userdata.id ?? 0) - 1

        } else {
            if searchFlag == true {
                let userdata = filterSearchData[indexPath.row]
                cell.useridLbl.text = "User ID : \(userdata.userId ?? 0)"
                cell.titleLbl.text = "Title : \(userdata.title ?? "")"
                cell.favouriteBtn.image = userdata.isFavourite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
                cell.favouriteBtn.tag = (userdata.id ?? 0) - 1
                cell.userImgView.image = UIImage(systemName: "person.circle")
                
                return cell
            }
            let userdata = modelUserData[indexPath.row]
            cell.useridLbl.text = "User ID : \(userdata.userId ?? 0)"
            cell.titleLbl.text = "Title : \(userdata.title ?? "")"
            cell.favouriteBtn.image = userdata.isFavourite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
            cell.favouriteBtn.tag = (userdata.id ?? 0) - 1

        }
        
        cell.userImgView.image = UIImage(systemName: "person.circle")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.albumTable.dequeueReusableCell(withIdentifier: "albumTableViewCell") as! albumTableViewCell
        cell.selectionStyle = .none
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "detailVC") as! detailVC
        
        if favFlag == true {
            let userdata = filterFavouriteData[indexPath.row]
            vc.userid = userdata.userId
            vc.userTitle = userdata.title
//        vc.userImg = cell.userImgView.image
            vc.favFlag = userdata.isFavourite
            vc.detailid = userdata.id
        } else {
            if searchFlag == true {
                let userdata = filterSearchData[indexPath.row]
                vc.userid = userdata.userId
                vc.userTitle = userdata.title
    //        vc.userImg = cell.userImgView.image
                vc.favFlag = userdata.isFavourite
                vc.detailid = userdata.id
            }
            let userdata = modelUserData[indexPath.row]
            vc.userid = userdata.userId
            vc.userTitle = userdata.title
//        vc.userImg = cell.userImgView.image
            vc.favFlag = userdata.isFavourite
            vc.detailid = userdata.id
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //SEARCH DELEGATES
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.filterSearchData = self.modelUserData
        }
        else {
            self.filterSearchData = self.modelUserData.filter({$0.title!.lowercased().contains(searchText.lowercased())})
            print(filterSearchData)
            self.searchFlag = true
        }
        self.albumTable.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.filterSearchData = self.modelUserData
        self.searchFlag = false
        self.albumTable.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.albumSearch.resignFirstResponder()
    }
    
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

