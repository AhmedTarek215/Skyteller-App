import SwiftUI

struct ExploreView: View {
    @StateObject private var viewModel = ExploreViewModel()
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background
                (themeManager.isMorning ? Color(red: 0.85, green: 0.92, blue: 1.0) : Color(red: 0.1, green: 0.1, blue: 0.2))
                    .ignoresSafeArea()
                
                VStack(spacing: 16) {
                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search for a city or airport", text: $viewModel.searchText)
                            .foregroundColor(themeManager.isMorning ? .black : .white)
                    }
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(themeManager.isMorning ? Color.white.opacity(0.8) : Color.white.opacity(0.15))
                    )
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    
                    // Cities List
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 12) {
                            ForEach(viewModel.filteredCities, id: \.name) { city in
                                NavigationLink(destination: CityWeatherView(cityName: city.name)) {
                                    HStack {
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(city.name)
                                                .font(.system(size: 18, weight: .semibold))
                                                .foregroundColor(themeManager.isMorning ? .black : .white)
                                            Text(city.country)
                                                .font(.system(size: 14))
                                                .foregroundColor(.gray)
                                        }
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            viewModel.toggleFavorite(name: city.name, country: city.country)
                                        }) {
                                            Image(systemName: viewModel.isFavorite(name: city.name) ? "heart.fill" : "heart")
                                                .font(.system(size: 20))
                                                .foregroundColor(viewModel.isFavorite(name: city.name) ? .blue : .gray)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                    .padding(16)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(themeManager.isMorning ? Color.gray.opacity(0.3) : Color.white.opacity(0.2), lineWidth: 1)
                                            .background(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .fill(themeManager.isMorning ? Color.white.opacity(0.5) : Color.white.opacity(0.05))
                                            )
                                    )
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 100)
                    }
                }
            }
            .navigationBarHidden(true)
            .alert("Remove from Favorites", isPresented: $viewModel.showRemoveAlert) {
                Button("Yes", role: .destructive) {
                    viewModel.confirmRemove()
                }
                Button("Cancel", role: .cancel) {
                    viewModel.cancelRemove()
                }
            } message: {
                Text("Are you sure you want to remove this city from your favorites?")
            }
        }
    }
}

#Preview {
    ExploreView()
        .environmentObject(ThemeManager())
}
