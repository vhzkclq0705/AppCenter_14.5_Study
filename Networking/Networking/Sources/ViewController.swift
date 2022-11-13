//
//  ViewController.swift
//  Networking
//
//  Created by 권오준 on 2022/11/13.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - UI
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var loadButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var jsonTextView: UITextView!
    @IBOutlet weak var structTextView: UITextView!
    
    // MARK: - Property
    
    private let listURL = "https://my.api.mockaroo.com/members_with_avatar.json?key=44ce18f0"
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
    }
    
    // MARK: - Func
    
    private func configureVC() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.timerLabel.text = "\(Date().timeIntervalSince1970)"
        }
    }
    
    private func setVisibleWithAnimation(_ s: Bool) {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            s
            ? self?.activityIndicator.startAnimating()
            : self?.activityIndicator.stopAnimating()
        }, completion: { [weak self] _ in
            self?.view.layoutIfNeeded()
        })
    }
    
    // completion: @escaping (String?) -> Void ... completion(json)
    // completion: ((String?) -> Void)? ... completion?(json)
    // 위 두 코드는 같다.
    
    /// Escaping closure를 이용한 비동기 API 호출
    private func downloadJSONWithEscapingClosure(
        _ url: String,
        completion: @escaping (String?) -> Void)
    {
        DispatchQueue.global().async {
            let url = URL(string: url)!
            let data = try! Data(contentsOf: url)
            let json = String(data: data, encoding: .utf8)
            
            completion(json)
        }
    }
    
//    let url = URL(string: url)!
//    let task = URLSession.shared.dataTask(with: url) { data, _, err in
//        guard err == nil else {
//            // 에러가 발생하면 .onError를 통해 에러 전달
//            emitter.onError(err!)
//            return
//        }
//
//        // 데이터가 준비가 되면 .onNext를 통해 데이터 전달
//        if let data = data,
//           let json = String(data: data, encoding: .utf8) {
//            emitter.onNext(json)
//        }
//
//        // 데이터가 준비가 되지 않으면 onCompleted를 통해 종료
//        emitter.onCompleted()
//    }
//
//    task.resume()
    
    // MARK: - Action
    
    @IBAction func didTapLoadButton(_ sender: Any) {
        jsonTextView.text = ""
        setVisibleWithAnimation(true)
        
        // Escaping closure
        downloadJSONWithEscapingClosure(listURL) { [weak self] json in
            DispatchQueue.main.async {
                self?.jsonTextView.text = json
                self?.setVisibleWithAnimation(false)
            }
        }
    }

    
}

