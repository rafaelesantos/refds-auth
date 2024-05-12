import SwiftUI
import RefdsShared

public struct RefdsRequestBiometryViewModifier: ViewModifier {
    @AppStorage("allowAuth") private var allowAuth: Bool = false
    @Binding private var authenticated: Bool
    private var isAutomaticRequest: Bool
    
    public init(authenticated: Binding<Bool>, isAutomaticRequest: Bool) {
        self._authenticated = authenticated
        self.isAutomaticRequest = isAutomaticRequest
    }
    
    public func body(content: Content) -> some View {
        content
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
            .overlay { requestBiometryView }
    }
    
    private var requestBiometryView: some View {
        ZStack {
            if !authenticated, allowAuth {
                RefdsRequestBiometryView(
                    isAuthenticated: $authenticated,
                    applicationIcon: RefdsAsset.applicationIcon.image,
                    isAutomaticRequest: isAutomaticRequest
                )
                .background()
            }
        }
        .animation(
            .spring(),
            value: authenticated
        )
    }
}
