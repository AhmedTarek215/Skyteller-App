import SwiftUI
struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        NavigationStack {
            WeatherLayoutView(viewModel: viewModel)
        }
    }
}
#Preview {
    HomeView()
        .environmentObject(ThemeManager())
}
