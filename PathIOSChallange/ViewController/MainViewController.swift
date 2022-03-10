//
//  MainViewController.swift
//  PathIOSChallange
//
//  Created by Oguzhan Ozturk on 9.03.2022.
//

import UIKit
import RxSwift
import Kingfisher

class MainViewController: UIViewController {

    @IBOutlet weak var characterCollection : UICollectionView!
    @IBOutlet weak var indicator : UIActivityIndicatorView!
    private var characters : [MarvelCharacter] = []
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        getRequest()
        
    }
    
    private func getRequest(){
        indicator.startAnimating()
        NetworkServiceManager.shared.sendRequest(resultType: CharactersResponse.self, request: CharacterProvider.shared.generateRequest()).subscribe(onSuccess :{ [weak self] response in
            self?.characters.append(contentsOf: response.results)
            self?.characterCollection.reloadData()
            self?.indicator.stopAnimating()
        }, onError : { [weak self] error in
            self?.indicator.stopAnimating()
            self?.alert(error: error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    
    private func setupCollectionView(){
            characterCollection.delegate = self
            characterCollection.dataSource = self
            characterCollection.prefetchDataSource = self
            characterCollection.collectionViewLayout = setupCollectionViewLayout()
            characterCollection.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: "CharacterCell")
        }
    
    private func setupCollectionViewLayout() -> UICollectionViewFlowLayout{
            let layout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.itemSize = CGSize(width: self.view.frame.width - 20, height: 200)
            layout.minimumInteritemSpacing = 10
            layout.minimumLineSpacing = 10
            return layout
        }
    
    
}

extension MainViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDataSourcePrefetching{
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoaded(indexPath:)){
            getRequest()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath) as? CharacterCollectionViewCell{
            cell.title = String(characters[indexPath.row].name)
            cell.characterImageView.kf.indicatorType = .activity
            cell.characterImageView.kf.setImage(with: characters[indexPath.row].imageDownloadUrl)
            return cell
        }
        
        return CharacterCollectionViewCell()
    }
    
    private func isLoaded(indexPath : IndexPath) -> Bool{
        let count = characters.count
        return indexPath.row >= count - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let VC = storyboard?.instantiateViewController(identifier: "detailVC", creator: {  coder in
            let vc = DetailViewController(coder: coder, character: self.characters[indexPath.row])
            return vc
       })
        navigationController?.pushViewController(VC!, animated: true)
    }
    
}
