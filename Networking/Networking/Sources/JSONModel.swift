//
//  JSONModel.swift
//  Networking
//
//  Created by 권오준 on 2022/11/13.
//

import Foundation

import Alamofire

class JSONModel {
    
    static func downloadWithNormal(
        _ url: String,
        completion: @escaping ([DataModel]) -> Void)
    {
        DispatchQueue.global().async {
            let url = URL(string: url)!
            let data = try! Data(contentsOf: url)
            let json = String(data: data, encoding: .utf8)

            completion([])
        }
    }
    
    static func downloadWithURLSession(
        _ url: String,
        completion: @escaping ([DataModel]) -> Void)
    {
        let url = URL(string: url)!
        
        URLSession.shared.dataTask(with: url) { data, _, err in
            guard err == nil else {
                print(err!.localizedDescription)
                completion([])
                return
            }
            
            if let data = data {
                
            } else {
                completion([])
            }
            
        }.resume()
    }
    
    static func downloadWithAlamofire(
        _ url: String,
        completion: @escaping ([DataModel]) -> Void)
    {
        let url = URL(string: url)!
        
        AF.request(url)
            .responseDecodable(of: [DataModel].self) { response in
                switch response.result {
                case .success(let dataModels):
                    completion(dataModels)
                case .failure(let err):
                    print(err.localizedDescription)
                    completion([])
                }
            }
    }
    
}

