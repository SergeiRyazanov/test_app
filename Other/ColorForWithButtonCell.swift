import UIKit

enum ColorForCellWithButton: CaseIterable {
    
    case red
    case blue
    case yellow
    case green
    case purple
    case brown
    case cyan
    case magenta
    case lightGray
    
    var uiColor: UIColor {
        
        switch self {
            
        case .red: .red
        case .blue: .blue
        case .yellow: .yellow
        case .green: .green
        case .purple: .purple
        case .brown: .brown
        case .cyan: .cyan
        case .magenta: .magenta
        case .lightGray: .lightGray
        }
    }
}


