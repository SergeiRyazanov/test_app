import UIKit

class WithButtonCell: UITableViewCell {
        
    static var reuseID = "WithButtonCell"
        
    var returnBackHandler: (() -> Void)?
    var changeColorHandler: (() -> UIColor)?
    
    //текст в ячейке
    var cellName: UILabel = {
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 18, weight: .regular)
        return $0
    }(UILabel())
    
    //кнопка возврата
    var returnButton: UIButton = {
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(systemName: "arrow.backward.circle"), for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.setTitleColor(.white, for: .highlighted)
        
        return $0
    }(UIButton())
    
    //кнопка смены цвета
    var changeColorCellButton: UIButton = {
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(systemName: "arrow.uturn.backward.circle"), for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.setTitleColor(.white, for: .highlighted)
        return $0
    }(UIButton())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(cellName)
        contentView.addSubview(returnButton)
        contentView.addSubview(changeColorCellButton)
        
        
        returnButton.addTarget(self, action: #selector(returnButtonTap), for: .touchUpInside)
        changeColorCellButton.addTarget(self, action: #selector(changeColorButtonTap), for: .touchUpInside)
                
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            //текст в ячейке
            cellName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            cellName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            cellName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            //кнопка возврата
            returnButton.topAnchor.constraint(equalTo: cellName.topAnchor, constant: 0),
            returnButton.bottomAnchor.constraint(equalTo: cellName.bottomAnchor, constant: 0),
            returnButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            //кнопка смены цветы
            changeColorCellButton.topAnchor.constraint(equalTo: cellName.topAnchor, constant: 0),
            changeColorCellButton.bottomAnchor.constraint(equalTo: cellName.bottomAnchor, constant: 0),
            changeColorCellButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }
    
     func setupCell(post: DataSourceForWithButtonCell) {
        
        cellName.text = post.title
        returnBackHandler = post.returnBackHandler
        changeColorHandler = post.changeColorCellHandler
    }
    
    @objc private func returnButtonTap() {
        
        returnBackHandler?()
    }
    
    @objc private func changeColorButtonTap() {
        
        backgroundColor = changeColorHandler?()
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
