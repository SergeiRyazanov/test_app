import UIKit

struct DataSourceForWithImageCell {
    
    var name: String
    var image: String
    var openNewScreenHadler: ((UIImage) -> Void)?
}
