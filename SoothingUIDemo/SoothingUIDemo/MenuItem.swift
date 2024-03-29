//
//  Модель для элементов меню
//

import SwiftUI

struct MenuItem: Identifiable {
    var id = UUID()
    var name: String
    var image: String
    var destination: AnyView
}
