//
//  ViewController.swift
//  Networking
//
//  Created by 권오준 on 2022/11/13.
//

import UIKit

import Alamofire

class ViewController: UIViewController {
    
    // MARK: - UI
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var jsonTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Property
    
    private let listURL = "https://my.api.mockaroo.com/members_with_avatar.json?key=44ce18f0"
    
    var dataModels: [DataModel] = []
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
    }
    
    // MARK: - Func
    
    private func configureVC() {
        tableView.dataSource = self
        tableView.delegate = self
        
        let nib = UINib(nibName: "Cell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Cell.id)
        
        let timer = Timer.scheduledTimer(
            timeInterval: 0.1,
            target: self,
            selector: #selector(fetchTime(_:)),
            userInfo: nil,
            repeats: true)
        RunLoop.current.add(timer, forMode: .common)
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
    
    private func fetchTextView(_ text: String?) {
        DispatchQueue.main.async {
            self.jsonTextView.text = text
            self.setVisibleWithAnimation(false)
        }
    }
    
    private func fetchTableView(_ data: [DataModel]) {
        DispatchQueue.main.async {
            self.dataModels = data
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Action
    
    @objc func fetchTime(_ sender: Any) {
        timerLabel.text = "\(Date().timeIntervalSince1970)"
    }
    
    @IBAction func didTapLoadButton(_ sender: Any) {
        jsonTextView.text = ""
        setVisibleWithAnimation(true)
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            JSONString.downloadWithNormal(listURL) { [weak self] text in
                print("Data(contentsOF:)로 String 불러오기 완료")
                self?.fetchTextView(text)
            }
            
            JSONModel.downloadWithNormal(listURL) { [weak self] data in
                print("Data(contentsOF:)로 DataModel 불러오기 완료")
                self?.fetchTableView(data)
            }
        case 1:
            JSONString.downloadWithURLSession(listURL) { [weak self] text in
                print("URLSession으로 String 불러오기 완료")
                self?.fetchTextView(text)
            }
            
            JSONModel.downloadWithURLSession(listURL) { [weak self] data in
                print("URLSession으로 DataModel 불러오기 완료")
                self?.fetchTableView(data)
            }
        case 2:
            JSONString.downloadWithAlamofire(listURL) { [weak self] text in
                print("Alamofire로 String 불러오기 완료")
                self?.fetchTextView(text)
            }
            
            JSONModel.downloadWithAlamofire(listURL) { [weak self] data in
                print("Alamofire로 DataModel 불러오기 완료")
                self?.fetchTableView(data)
            }
        default: break
        }
    }
    
}

// MARK: - TableView DataSource & Delegate

extension ViewController: UITableViewDataSource,
                          UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int)
    -> Int
    {
        dataModels.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath)
    -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Cell.id) as? Cell else {
            return UITableViewCell()
        }
        
        let data = dataModels[indexPath.row]
        cell.updateCell(data)
        
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath)
    -> CGFloat
    {
        return 130
    }
    
}
