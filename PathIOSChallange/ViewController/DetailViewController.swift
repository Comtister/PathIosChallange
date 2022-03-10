//
//  DetailViewController.swift
//  PathIOSChallange
//
//  Created by Oguzhan Ozturk on 10.03.2022.
//

import UIKit
import RxSwift

class DetailViewController: UIViewController {

    @IBOutlet weak var characterImageView : UIImageView!
    @IBOutlet weak var nameLbl : UILabel!
    @IBOutlet weak var descriptionLbl : UILabel!
    @IBOutlet weak var comicsTableView : UITableView!
    @IBOutlet weak var indicator : UIActivityIndicatorView!
    
    private var character : MarvelCharacter
    private var comics : [Comic] = []
    
    private let disposeBag = DisposeBag()
    
    required init?(coder: NSCoder , character : MarvelCharacter) {
        self.character = character
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        getComics()
    }
    
    private func setupViews(){
        characterImageView.kf.indicatorType = .activity
        characterImageView.kf.setImage(with: character.imageDownloadUrl)
        
        nameLbl.text = character.name
        descriptionLbl.text = character.description
        
        comicsTableView.delegate = self
        comicsTableView.dataSource = self
        
    }
    
    private func getComics(){
        indicator.startAnimating()
        NetworkServiceManager.shared.sendRequest(resultType: ComicResponseModel.self, request: ComicsRequestModel(charID: String(character.id))).subscribe(onSuccess:{ [weak self] comics in
            print(comics.results)
            self?.comics.append(contentsOf: comics.results)
            self?.comicsTableView.reloadData()
            self?.indicator.stopAnimating()
        },onFailure:{ [weak self] error in
            self?.alert(error: error.localizedDescription)
        }).disposed(by: disposeBag)
    }


}

extension DetailViewController : UITableViewDataSource , UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel!.text = comics[indexPath.row].title
        return cell
    }
    
    
    
    
}
