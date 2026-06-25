import SwiftUI

struct WeatherLayoutView: View {
    @ObservedObject var viewModel: HomeViewModel
    var showBackButton: Bool = false
    
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                Image(themeManager.backgroundImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .clipped()
            }
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                if showBackButton {
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            HStack(spacing: 8) {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 16, weight: .bold))
                                Text("BACK")
                                    .font(.system(size: 12, weight: .bold))
                                    .tracking(1.5)
                            }
                            .foregroundColor(themeManager.textColor.opacity(0.8))
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                }
                
                if viewModel.forecastResponse != nil {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 20) {
                            HomeTopView(viewModel: viewModel)
                            
                            HomeMiddleView(viewModel: viewModel)
                            
                            HomeBottomView(viewModel: viewModel)
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 100)
                    }
                } else {
                    Spacer()
                    VStack {
                        ProgressView()
                            .tint(themeManager.textColor)
                            .scaleEffect(1.5)
                        
                        if let errorMessage = viewModel.errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .padding(50)
                        }
                    }
                    Spacer()
                }
            }
        }
        .navigationBarHidden(showBackButton)
    }
}
