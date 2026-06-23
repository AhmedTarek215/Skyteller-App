import SwiftUI

class ThemeManager: ObservableObject {
    @Published var isMorning: Bool = true
    
    init() {
        updateTheme()
    }
    
    func updateTheme() {
        let hour = Calendar.current.component(.hour, from: Date())
        // Between 5:00 AM and 6:00 PM (18:00)
        isMorning = hour >= 5 && hour < 18
    }
    
    var textColor: Color {
        isMorning ? .black : .white
    }
    
    var backgroundImage: String {
        isMorning ? "morning" : "evening"
    }
}
