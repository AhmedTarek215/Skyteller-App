import SwiftUI
struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        NavigationStack {
            WeatherLayoutView(viewModel: viewModel)
        }
        .alert("Location Access Denied", isPresented: $viewModel.showLocationAlert) {
            Button("Settings", role: .none) {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Please allow location access in Settings to see your local weather.")
        }
    }
}
#Preview {
    HomeView()
        .environmentObject(ThemeManager())
}
