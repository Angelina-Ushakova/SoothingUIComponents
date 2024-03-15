//
//  ViewModel для меню, которая будет содержать список элементов
//

import SwiftUI

struct MenuView: View {
    @StateObject var viewModel = MenuViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.menuItems) { item in
                NavigationLink(destination: item.destination) {
                    HStack {
                        Image(item.image)
                            .resizable() // Делает изображение масштабируемым
                            .scaledToFit() // Масштабирует изображение, чтобы оно поместилось в отведённое пространство, сохраняя пропорции
                            .frame(width: 50, height: 50) // Задаёт размеры для изображения
                        Text(item.name)
                            .font(.title3)
                    }
                }
            }
            .navigationTitle("UI Elements")
        }
    }
}

