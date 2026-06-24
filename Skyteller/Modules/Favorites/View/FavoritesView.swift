import SwiftUI

struct FavoritesView: View {
    @StateObject private var viewModel = FavoritesViewModel()
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                (themeManager.isMorning ? Color(red: 0.85, green: 0.92, blue: 1.0) : Color(red: 0.1, green: 0.1, blue: 0.2))
                    .ignoresSafeArea()
                
                VStack(spacing: 16) {
                    // Title
                    Text("Favorites")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(themeManager.isMorning ? .black : .white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                    
                    if viewModel.favoriteCities.isEmpty {
                        Spacer()
                        VStack(spacing: 12) {
                            Image(systemName: "star.slash")
                                .font(.system(size: 50))
                                .foregroundColor(.gray)
                            Text("No favorite cities yet")
                                .font(.system(size: 16))
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    } else {
                        // Cities List
                        ScrollView(showsIndicators: false) {
                            VStack(spacing: 12) {
                                ForEach(viewModel.favoriteCities, id: \.name) { city in
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
                                                viewModel.heartTapped(name: city.name)
                                            }) {
                                                Image(systemName: "heart.fill")
                                                    .font(.system(size: 20))
                                                    .foregroundColor(.blue)
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
            }
            .navigationBarHidden(true)
            .onAppear {
                viewModel.loadFavorites()
            }
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
    FavoritesView()
        .environmentObject(ThemeManager())
}
