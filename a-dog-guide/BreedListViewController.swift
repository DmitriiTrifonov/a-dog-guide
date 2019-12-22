//
//  BreedListViewController.swift
//  a-dog-guide
//
//  Created by Dmitrii Trifonov on 16.12.2019.
//  Copyright © 2019 Dmitrii Trifonov. All rights reserved.
//

import UIKit
import ResourceNetworking

class FakeReachability: ReachabilityProtocol {
    var isReachable: Bool = true
}

class BreedListViewController: UIViewController {

    let networkHelper = NetworkHelper(reachability: FakeReachability())
    
    struct CellIdentifiers {
        static let breedCell = "BreedTableViewCell"
    }
    
    
    @IBOutlet var tableView: UITableView!
    
    let semaphore = DispatchSemaphore(value: 1)
    
    var breeds: [Dog] = []{
        didSet {
            semaphore.signal()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        willSet {
            semaphore.wait()
        }
    }
    
    var imgUrl: [DogImage]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "BreedTableViewCell", bundle: nil), forCellReuseIdentifier: CellIdentifiers.breedCell)

        _ = networkHelper.load(resource: ResourceFactory().createResource()) { [weak self] result in
        switch result{
        case let .success(answer):
            self!.breeds = Dog.createDogList(from: Breed.getBreedList(from: answer.message))
        default:
            break
        }
           }
        
        tableView.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}

extension BreedListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.breedCell) as! BreedTableViewCell
        //cell.breedLabel.text = breeds[indexPath.row].name
        let dog = breeds[indexPath.row]
        cell.breedLabel.text = dog.caps
        print(dog.photoGetUrl)
        dog.getImgUrl {
            i in
            cell.setImage(from: i)
        }
        return cell
    }
}

