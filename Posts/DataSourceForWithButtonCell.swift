import Foundation
import UIKit

struct DataSourceForWithButtonCell {
    
    var title: String
    
    var returnBackHandler: () -> Void
    var changeColorCellHandler: () -> UIColor
}
