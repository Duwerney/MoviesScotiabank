//
//  SplashScreen.swift
//  MovieScotiabank
//
//  Created by user on 19/05/24.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Image("LaunchImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(isActive ? 0 : 1)
            }
//            .edgesIgnoringSafeArea(.all) // Ignora los bordes seguros para que la imagen ocupe toda la pantalla
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
        .fullScreenCover(isPresented: $isActive) {
            ContentView()
        }
    }
}
