import SwiftUI
import RefdsUI
import RefdsShared

public struct RefdsRequestBiometryView: View {
    @Environment(\.scenePhase) private var scenePhase
    @StateObject private var authenticator = RefdsAuth()
    @Binding private var isAuthenticated: Bool
    @State private var isAutomaticRequestState: Bool = false
    
    private let applicationIcon: Image
    private let isAutomaticRequest: Bool
    
    public init(
        isAuthenticated: Binding<Bool>,
        applicationIcon: Image,
        isAutomaticRequest: Bool = true
    ) {
        self._isAuthenticated = isAuthenticated
        self.applicationIcon = applicationIcon
        self.isAutomaticRequest = isAutomaticRequest
    }
    
    public var body: some View {
        VStack(alignment: .center, spacing: 50) {
            Spacer()
            
            authIcon.padding()
            
            VStack(spacing: .small) {
                RefdsText(.refdsLocalizable(by: .lockScreenTitle), style: .title, weight: .bold)
                
                RefdsText(.refdsLocalizable(by: .lockScreenDescription), color: .secondary, alignment: .center)
            }
            .padding(.horizontal, .extraLarge)
            
            Spacer()
            
            RefdsButton(
                .refdsLocalizable(by: .lockScreenButtonTitle),
                color: .accentColor,
                style: .primary,
                hasLargeSize: true,
                isDisable: false
            ) {
                authenticate()
            }
            .padding()
        }
        .padding(.horizontal, .extraLarge)
        .onAppear { setupData() }
        .onChange(of: scenePhase) { requestAuthentication() }
        .onChange(of: isAutomaticRequestState) { requestAuthentication() }
        .refdsToast(item: $authenticator.error)
    }
    
    private func setupData() {
        withAnimation {
            isAutomaticRequestState = isAutomaticRequest
        }
    }
    
    private func requestAuthentication() {
        switch scenePhase {
        case .active:
            if isAutomaticRequestState {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    authenticate()
                    isAutomaticRequestState = false
                }
            }
        default: break
        }
    }
    
    private var authIcon: some View {
        ZStack(alignment: .bottom) {
            applicationIcon
                .resizable()
                .scaledToFit()
                .frame(width: 80)
                .clipShape(.rect(cornerRadius: 80 * 0.216))
            
            RefdsIcon(
                .lockFill,
                size: 20
            )
            .padding(5)
            .background()
            .clipShape(.circle)
            .padding(.bottom, -15)
        }
    }
    
    private func authenticate() {
        authenticator.requestAuthentication {
            withAnimation {
                self.isAuthenticated = true
            }
        }
    }
}

#Preview {
    struct ContainerView: View {
        @State var isAuthenticated = false
        var body: some View {
            RefdsRequestBiometryView(
                isAuthenticated: $isAuthenticated,
                applicationIcon: RefdsAsset.applicationIcon.image
            )
        }
    }
    return ContainerView()
}
