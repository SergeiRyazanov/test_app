import UIKit

class WithCollectionScreen: UIViewController {
    
    var collectionView: UICollectionView!
    var layout = UICollectionViewFlowLayout()
    
    lazy var dataSourceWithImageCell =
    [DataSourceForWithImageCell(name: "Змея", image: "https://avatars.mds.yandex.net/get-yapic/36689/56jx33h1WxaVJpEoT2TOaAfI-1569754704/orig"),
    DataSourceForWithImageCell(name: "Обезьяна", image: "https://distribution.faceit-cdn.net/images/3ce0f058-1e4e-4862-9bc7-8d0c70e000e9.jpeg"),
    DataSourceForWithImageCell(name: "Тигр", image: "https://avatars.yandex.net/get-music-content/10099790/152eeed5.a.32071697-2/m1000x1000"),
    DataSourceForWithImageCell(name: "Рыба", image:
        "https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AA1BhyN0.img?w=1000&h=1000&m=4&q=99")]

    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
        
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension WithCollectionScreen: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        dataSourceWithImageCell.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WithImageCell.reuseID,
                                                      for: indexPath) as! WithImageCell
        
        let withImageCell = dataSourceWithImageCell[indexPath.row]
        cell.setupCell(post: withImageCell)
        cell.openNewScreenHandler = { [weak self] image in
            
            let page = PageAboutCell()
            page.titleText = withImageCell.name
            page.image = image
            self?.navigationController?.pushViewController(page, animated: true)
        }
        
        return cell
    }
}
