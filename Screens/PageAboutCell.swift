import UIKit

class PageAboutCell: UIViewController {
    
    var image: UIImage?
    var titleText: String?

    private var imageView: UIImageView = {
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    override func viewDidLoad() {
         super.viewDidLoad()

         view.backgroundColor = .white
         title = titleText

         view.addSubview(imageView)
         imageView.image = image

         setupConstraints()
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
