//
//  RickMortyTableViewCell.swift
//  Rick And Morty
//
//  Created by Burak AKCAN on 17.07.2022.
//

import UIKit
import SnapKit
import AlamofireImage

class RickMortyTableViewCell: UITableViewCell {
   private let randomImageUrlString = "https://i.picsum.photos/id/660/200/200.jpg?hmac=5UOdBCKDcPq_zS0RAVkvSD934EYVyCEdExCagJur-g8"
    private let customImage:UIImageView = UIImageView()
    private let title:UILabel = UILabel()
    private let customDescription:UILabel = UILabel()
    
    enum Identifier:String{
        case custom = "cell"
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure(){
        addSubview(customImage)
        addSubview(title)
        addSubview(customDescription)
        title.font = .boldSystemFont(ofSize: 18)
        customDescription.font = .systemFont(ofSize: 14)
        
        customImage.snp.makeConstraints { make in
            make.height.equalTo(140)
            make.top.equalTo(contentView)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(customImage.snp.bottom).offset(10)
            make.left.right.equalTo(contentView)
            
        }
        
        customDescription.snp.makeConstraints { make in
            make.top.equalTo(title).offset(5)
            make.right.left.equalTo(title)
            make.bottom.equalToSuperview()
        }
    }
    
    func saveModel(model:Result){
        title.text = model.name
        customDescription.text = model.status
        customImage.af.setImage(withURL: URL(string: model.image ?? "") ?? URL(string: randomImageUrlString)!)
        
    }
}
