//
//  ViewController.swift
//  a-dog-guide
//
//  Created by Dmitrii Trifonov on 07.12.2019.
//  Copyright © 2019 Dmitrii Trifonov. All rights reserved.
//

import UIKit
import ResourceNetworking

class FakeReachability: ReachabilityProtocol {
    var isReachable: Bool = true
}

class ViewController: UIViewController {
    
    let networkHelper = NetworkHelper(reachability: FakeReachability())
    
    var breeds: [Breed] = []
    
    var imgUrl: DogImage? = nil
    
    @IBOutlet weak var showAllBreeds: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = networkHelper.load(resource: ResourceFactory().createResource()) { [weak self] result in
        switch result{
        case let .success(answer):
            self!.breeds = Breed.getBreedList(from: answer.message)
        default:
            break
        }
           }
        
        _ = networkHelper.load(resource: ResourceFactory().createImageResource()) { [weak self] result in
        switch result{
        case let .success(a):
            print(a)
            self!.imgUrl = a
        default:
            break
        }
           }
        
        // Do any additional setup after loading the view.
    }

    @IBAction func onButton(_ sender: UIButton) {
        print(imgUrl?.imageUrl ?? "Failed")
    
    }
    
}

