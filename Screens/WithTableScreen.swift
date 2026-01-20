import UIKit

class WithTableScreen: UIViewController {
    
    var forReturnButton = UIButton()
    lazy var returnButton = UIBarButtonItem(customView: forReturnButton)
    
    //тут начинается таблица
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(WithImageCell.self, forCellReuseIdentifier: WithImageCell.reuseID)
        tableView.register(WithButtonCell.self, forCellReuseIdentifier: WithButtonCell.reuseID)
        tableView.dataSource = self
        return tableView
    }()
    
    var colorFirstCell: UIColor = .lightGray
        
    lazy var dataSourceWithImageCell =
    [DataSourceForWithImageCell(name: "Змея", image: "https://avatars.mds.yandex.net/get-yapic/36689/56jx33h1WxaVJpEoT2TOaAfI-1569754704/orig"),
    DataSourceForWithImageCell(name: "Обезьяна", image: "https://distribution.faceit-cdn.net/images/3ce0f058-1e4e-4862-9bc7-8d0c70e000e9.jpeg"),
    DataSourceForWithImageCell(name: "Тигр", image: "https://avatars.yandex.net/get-music-content/10099790/152eeed5.a.32071697-2/m1000x1000"),
    DataSourceForWithImageCell(name: "Рыба", image:
        "https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AA1BhyN0.img?w=1000&h=1000&m=4&q=99"),
     DataSourceForWithImageCell(name: "Змея", image: "https://avatars.mds.yandex.net/get-yapic/36689/56jx33h1WxaVJpEoT2TOaAfI-1569754704/orig"),
     DataSourceForWithImageCell(name: "Обезьяна", image: "https://distribution.faceit-cdn.net/images/3ce0f058-1e4e-4862-9bc7-8d0c70e000e9.jpeg"),
     DataSourceForWithImageCell(name: "Тигр", image: "https://avatars.yandex.net/get-music-content/10099790/152eeed5.a.32071697-2/m1000x1000"),DataSourceForWithImageCell(name: "Змея", image: "https://avatars.mds.yandex.net/get-yapic/36689/56jx33h1WxaVJpEoT2TOaAfI-1569754704/orig"),
     DataSourceForWithImageCell(name: "Обезьяна", image: "https://distribution.faceit-cdn.net/images/3ce0f058-1e4e-4862-9bc7-8d0c70e000e9.jpeg"),
     DataSourceForWithImageCell(name: "Тигр", image: "https://avatars.yandex.net/get-music-content/10099790/152eeed5.a.32071697-2/m1000x1000"),DataSourceForWithImageCell(name: "Змея", image: "https://avatars.mds.yandex.net/get-yapic/36689/56jx33h1WxaVJpEoT2TOaAfI-1569754704/orig"),
     DataSourceForWithImageCell(name: "Обезьяна", image: "https://distribution.faceit-cdn.net/images/3ce0f058-1e4e-4862-9bc7-8d0c70e000e9.jpeg"),
     DataSourceForWithImageCell(name: "Тигр", image: "https://avatars.yandex.net/get-music-content/10099790/152eeed5.a.32071697-2/m1000x1000"),]
    
    lazy var dataSourceWithButtonCell = [DataSourceForWithButtonCell(title: "Я могу менять цвет",
                                                       
                                            returnBackHandler: { [weak self] in
        
        self?.navigationController?.popViewController(animated: true)
    },
                                                       
        changeColorCellHandler: {[weak self] in
        
        let indexPath = IndexPath(row: 0, section: 0)
        self?.tableView.reloadRows(at: [indexPath], with: .none)
        
        return ColorForCellWithButton.allCases.randomElement()?.uiColor ?? .lightGray
    })]
    //тут закончилась
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //кнопка возврата на первый экран
        forReturnButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        forReturnButton.tintColor = .systemBlue
        forReturnButton.addTarget(self, action: #selector(returnToFirstPage), for: .touchUpInside)
        navigationItem.leftBarButtonItem = returnButton
        
        //таблица
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        //таблица
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func returnToFirstPage() {
        
        navigationController?.popViewController(animated: true)
    }
}

extension WithTableScreen: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        dataSourceWithImageCell.count + dataSourceWithButtonCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: WithButtonCell.reuseID, for: indexPath) as! WithButtonCell
            let withButtonCell = dataSourceWithButtonCell[indexPath.row]
            cell.setupCell(post: withButtonCell)
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: WithImageCell.reuseID, for: indexPath) as! WithImageCell
            let withImageCell = dataSourceWithImageCell[indexPath.row - 1]
            cell.setupCell(post: withImageCell)
            cell.openNewScreenHandler = { [weak self] in
                let page = PageAboutCell()
                page.titleText = withImageCell.name
                page.imageName = withImageCell.image
                self?.navigationController?.pushViewController(page, animated: true)
            }
            
            return cell
        }
    }
}
