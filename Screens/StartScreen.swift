import UIKit

class StartScreen: UIViewController {
   
    var squareView = UIView()
    
    lazy var buttonChangeColor = UIButton(primaryAction: newColor)
    private var colors: [UIColor] = [.red, .blue, .yellow, .green, .orange]
    lazy var newColor: UIAction = UIAction { _ in
        
    let color = self.colors.randomElement()!
    self.squareView.backgroundColor = color
    }
    
    var buttonNextPage = UIBarButtonItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //цветной квадрат
        view.addSubview(squareView)
        squareView.backgroundColor = .red
        squareView.translatesAutoresizingMaskIntoConstraints = false
        
        //кнопка для изменения цвета
        view.addSubview(buttonChangeColor)
        buttonChangeColor.setTitle("поменять цвет", for: .normal)
        buttonChangeColor.setTitleColor(.gray, for: .normal)
        buttonChangeColor.setTitleColor(.black, for: .highlighted)
        buttonChangeColor.translatesAutoresizingMaskIntoConstraints = false
        
        //кнопка для перехода на SecondPage
        buttonNextPage.title = "Next"
        buttonNextPage.tintColor = .systemBlue
        buttonNextPage.target = self
        buttonNextPage.action = #selector(nextPage)
        navigationItem.rightBarButtonItem = buttonNextPage
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            //цветной квардрат
            squareView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                               constant: -60),
            squareView.leadingAnchor.constraint(equalTo: view.centerXAnchor,
                                               constant: -50),
            squareView.trailingAnchor.constraint(equalTo: view.centerXAnchor,
                                                constant: 50),
            squareView.heightAnchor.constraint(equalToConstant: 100),
            squareView.widthAnchor.constraint(equalToConstant: 100),
            
            //кнопка для изменения цвета
            buttonChangeColor.widthAnchor.constraint(equalToConstant: 160),
            buttonChangeColor.heightAnchor.constraint(equalToConstant: 60),
            buttonChangeColor.bottomAnchor.constraint(equalTo: squareView.bottomAnchor,
                                              constant: -100),
            buttonChangeColor.leadingAnchor.constraint(equalTo: squareView.centerXAnchor,
                                                 constant: 25),
        ])
    }
    
    @objc func nextPage() {

        navigationController?.pushViewController(WithTableScreen(), animated: true)
    }
}
