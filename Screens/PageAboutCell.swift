import UIKit

class PageAboutCell: UIViewController {
    
    var imageName: String?
    var titleText: String?

    private let imageView: UIImageView = {
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.addSubview(imageView)
        view.backgroundColor = .white
        title = titleText
        
        setupImageView()
        setupConstraints()
    }
    
    private func setupImageView() {
        
        guard let imageURL = imageName else { return }
        
        URLSession.shared.dataTask(with: URL(string: imageURL)!) { [weak self] (data, _, _) in
            
            if let data = data {
                
                DispatchQueue.main.async {
                    
                    self?.imageView.image = UIImage(data: data)
                }
            }
        }.resume()
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate ([
            
            //изображение ячейки
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 350),
            imageView.widthAnchor.constraint(equalToConstant: 350)
        ])
    }
}
