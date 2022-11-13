//
//  JSONString.swift
//  Networking
//
//  Created by 권오준 on 2022/11/13.
//

import Foundation

import Alamofire

class JSONString {
    
    // 네트워킹 작업을 하면, Escaping Closure를 사용하여 작업이 끝나고 얻어온 데이터를 반환할 수 있다.
    // @escaping 키워드를 통해 비동기 작업으로 얻어온 데이터를 메소드 밖에서도 사용할 수 있다.
    
    // 사용법
    // func a(completion: @escaping (String?) -> Void) { completion(json) }
    // func a(completion: ((String?) -> Void)?) { completion?(json) }
    // 위 두 코드는 같다.
    
    static func downloadWithNormal(
        _ url: String,
        completion: @escaping (String?) -> Void)
    {
        // URL 주소가 이미지 파일이나 json이면 (constentsOf: URL)을 통해 데이터를 불러올 수 있다.
        // (contentsOf: URL) 사용하면 해당 URL에서 데이터를 불러오는 시간이 발생한다.
        // 따라서, GCD를 사용하지 않고 해당 기능을 사용하면 데이터를 불러오는 시간동안 앱이 멈춘다.
        // DispatchQueue.global().async를 통해 비동기로 데이터를 불러와야 한다.
        
        DispatchQueue.global().async {
            let url = URL(string: url)!
            let data = try! Data(contentsOf: url)
            let json = String(data: data, encoding: .utf8)

            completion(json)
        }
    }
    
    static func downloadWithURLSession(
        _ url: String,
        completion: @escaping (String?) -> Void)
    {
        let url = URL(string: url)!
        
        // Swift에서는 URLSession을 사용하여 HTTP 통신을 할 수 있다.
        // 해당 작업은 비동기 스레드에서 진행이된다.
        // URLSession에서 데이터를 얻어오기(GET) 위해서는 dataTask를 사용한다.
        
        URLSession.shared.dataTask(with: url) { data, _, err in
            guard err == nil else {
                print(err!.localizedDescription)
                completion(nil)
                return
            }
            
            if let data = data,
               let json = String(data: data, encoding: .utf8) {
                completion(json)
            } else {
                completion(nil)
            }
            
        }.resume()
    }
    
    static func downloadWithAlamofire(
        _ url: String,
        completion: @escaping (String?) -> Void)
    {
        let url = URL(string: url)!
        
        // Swift에서는 HTTP 통신, 즉 네트워킹을 위한 다양한 라이브러리가 존재한다.
        // 보통 그 중 하나인 Alamofire를 가장 많이 사용한다.
        // Alamofire는 URLSession을 조금 더 작업하기 쉽고 간결하게 바꾼 라이브러리이다.
        
        AF.request(url)
            .responseString { response in
                switch response.result {
                case .success(let json):
                    completion(json)
                case .failure(let err):
                    print(err.localizedDescription)
                    completion(nil)
                }
            }
    }
    
}
