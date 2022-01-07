//
//  ContentView.swift
//  Vincit-Rising-Star-v1
//
//  Created by Oskari Saarinen on 23.12.2021.
//

import SwiftUI

struct ContentView: View {
    
    /// Persistence Controller
    let pC = PersistenceController.shared
    
    /// Is the settings menu visible
    @State private var showSettingsMenu: Bool = false
    
    var body: some View {
        /// For swipe closing the settings menu
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -100 {
                    toggleSettings()
                }
            }
        
        NavigationView {
            // Container for main view and settings menu
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // Main view
                    MainView(showSettingsMenu: self.$showSettingsMenu)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x: self.showSettingsMenu ? geometry.size.width*0.75 : 0)
                        .disabled(self.showSettingsMenu ? true : false)
                    
                    // Wether to show the settings menu
                    if self.showSettingsMenu {
                        MenuView(height: geometry.size.height)
                            .frame(width: geometry.size.width*0.75)
                            .transition(.move(edge: .leading))
                            .environment(\.managedObjectContext, pC.container.viewContext)
                    }
                }.gesture(drag)
                
            }.background(Color.red.opacity(0.03))
                .navigationTitle("Crypto Time Machine")
                .navigationBarItems(
                    trailing:
                        // Settings button
                        Button(action: toggleSettings) {
                            Label("Settings", systemImage: "gearshape")
                                .foregroundColor(.white)
                                .font(.title3)
                                .labelStyle(IconOnlyLabelStyle())
                        }
                ).navigationBarTitleDisplayMode(.inline)
                .navigationViewStyle(StackNavigationViewStyle())
            
        }
            
    }
    
    /// Toggle settings menu visibility
    func toggleSettings() {
        print("Settings tapped")
        withAnimation {
            self.showSettingsMenu.toggle()
        }
    }
    
    init() {
        // For navigation styling
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(hex: "#F04E30FF")

        let attrs: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.monospacedSystemFont(ofSize: 22, weight: .black)
        ]
        
        appearance.titleTextAttributes = attrs
        
        appearance.buttonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
