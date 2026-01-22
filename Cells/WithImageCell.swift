import UIKit

class WithImageCell: UICollectionViewCell {
        
    static var reuseID = "WithImageCell"
    
    //кнопка для открытия нового экрана
    var openNewScreenButton: UIButton = {
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    
    var openNewScreenHandler: ((UIImage) -> Void)?
    
    //фон ячейки
    var cellColor: UIView = {
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 30
        $0.backgroundColor = .lightGray
        return $0
    }(UIView())
    
    //изображение
    var cellImage: UIImageView = {
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 240).isActive = true
        $0.layer.cornerRadius = 30
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    //название текста
    var cellName: UILabel = {
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 20)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    //спиннер загрузки
    var spinner: UIActivityIndicatorView = {
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.color = .black
        $0.style = .large
        return $0
    }(UIActivityIndicatorView())
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        openNewScreenButton.addTarget(self, action: #selector(openNewScreen), for: .touchUpInside)
        
        contentView.addSubview(cellColor)
        contentView.addSubview(spinner)
        contentView.addSubview(openNewScreenButton)
        cellColor.addSubview(cellImage)
        cellColor.addSubview(cellName)

        setupConstraints()
        spinner.startAnimating()
    }
    
    private var downloadedImage: UIImage?
    private func downloadImage(from urlString: String) {
        
        if let url = URL(string: urlString) {
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
            
            var image: UIImage?
            if let data = data, let img = UIImage(data: data) {
                
                image = UIImage(data: data)!
                self?.downloadedImage = image
                DispatchQueue.main.async {
                    
                    self?.cellImage.image = image
                    self?.spinner.stopAnimating()
                }
            } else {
                
                image = UIImage(named: "reserveImage")
                self?.downloadedImage = image
                
                DispatchQueue.main.async {
                    
                    self?.cellImage.image = image
                    self?.spinner.stopAnimating()
                }
            }
        }.resume()
    }
}
    
    func setupCell(post: DataSourceForWithImageCell) {
        
        cellImage.image = nil
        downloadImage(from: post.image)
        cellName.text = post.name
        openNewScreenHandler = post.openNewScreenHadler
   }
   
   @objc private func openNewScreen() {
       
       openNewScreenHandler?(downloadedImage!)
   }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            //фон
            cellColor.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            cellColor.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            cellColor.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            cellColor.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            //кнопка
            openNewScreenButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            openNewScreenButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            openNewScreenButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            openNewScreenButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            //картинка
            cellImage.topAnchor.constraint(equalTo: cellColor.topAnchor, constant: 20),
            cellImage.trailingAnchor.constraint(equalTo: cellColor.trailingAnchor, constant: -20),
            cellImage.leadingAnchor.constraint(equalTo: cellColor.leadingAnchor, constant: 20),
            
            //название
            cellName.topAnchor.constraint(equalTo: cellImage.bottomAnchor, constant: 20),
            cellName.leadingAnchor.constraint(equalTo: cellImage.leadingAnchor, constant: 10),
            cellName.trailingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: -10),
            cellName.bottomAnchor.constraint(equalTo: cellColor.bottomAnchor, constant: -20),
            
            //спинер
            spinner.centerXAnchor.constraint(equalTo: openNewScreenButton.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: openNewScreenButton.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
