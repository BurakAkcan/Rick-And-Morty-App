//
//  RickMortyViewController.swift
//  RickAndMorty
//
//  Created by Burak AKCAN on 16.07.2022.
//

import UIKit
import SnapKit

protocol RickMortyOutput{
    func changeLoading(isLoad:Bool)
    func saveDatas(values:[Result])
}

//Başka bir controllerdan türetilmeyeceği için final kullanırız ve performansı da arttırmış oluruz
final class RickMortyViewController: UIViewController {
    
    //MARK: -View Properties
    private let labelTitle:UILabel = UILabel()
    private let tableView :UITableView = UITableView()
    private let indicator:UIActivityIndicatorView = UIActivityIndicatorView()
    private let titleImage:UIImageView = UIImageView()
    
    //MARK: -Properties
    private lazy var results:[Result] = []
    lazy var viewModel:IRickMortyViewModel = RickMortyViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        drawDesign()
        viewModel.setDelegate(output: self)
        viewModel.fetcItems()
    }
}

extension RickMortyViewController:RickMortyOutput{
    func changeLoading(isLoad: Bool) {
        isLoad ? indicator.startAnimating() : indicator.stopAnimating()
    }
    
    func saveDatas(values: [Result]) {
        results = values
        tableView.reloadData()
    }
}

extension RickMortyViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : RickMortyTableViewCell = tableView.dequeueReusableCell(withIdentifier: RickMortyTableViewCell.Identifier.custom.rawValue, for: indexPath) as! RickMortyTableViewCell
        cell.saveModel(model: results[indexPath.row])
        return cell
    }
}

extension RickMortyViewController{
    
    private func drawDesign(){
        DispatchQueue.main.async {
            self.view.backgroundColor = .white
           // self.tableView.backgroundColor = .red
            self.labelTitle.text = "Rick And Morty"
            self.indicator.color = .gray
            self.labelTitle.font = .boldSystemFont(ofSize: 30)
            self.tableView.separatorStyle = .none
        }
        tableView.register(RickMortyTableViewCell.self, forCellReuseIdentifier: RickMortyTableViewCell.Identifier.custom.rawValue)
        indicator.startAnimating()
        tableView.rowHeight = 200
        }
    
    //MARK: - initialize Func
   private func configure(){
        view.addSubview(labelTitle)
        view.addSubview(indicator)
        view.addSubview(tableView)
       tableView.delegate = self
       tableView.dataSource = self
     
       labelTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.greaterThanOrEqualTo(12)
        }
        
       tableView.snp.makeConstraints { make in
            make.top.equalTo(labelTitle.snp.bottom).offset(20)
            make.bottom.equalToSuperview()
            make.left.right.equalTo(labelTitle)
        }
       
        indicator.snp.makeConstraints { make in
            make.height.equalTo(labelTitle)
            make.right.equalTo(labelTitle).offset(-5)
            make.top.equalTo(labelTitle)
        }
       
    }
}


//Snapkit Usage
//top.equalToSuperView => sayfanın en üstünde olacak
//left.equalToSuperView.Ofset(value) => solda ve arada padding olacak (Ofset pddin vermemizi sağlar)
//make.top.equalTo(labelTitle.snp.bottom).offset(20) => labelın altından 10 padding ver


