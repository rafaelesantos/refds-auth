import SwiftUI
import RefdsShared

public struct RefdsRequestBiometryViewModifier: ViewModifier {
    @Binding private var isAuthenticated: Bool
    private var isAutomaticRequest: Bool
    
    public init(
        isAuthenticated: Binding<Bool>,
        isAutomaticRequest: Bool
    ) {
        self._isAuthenticated = isAuthenticated
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
            if !isAuthenticated {
                RefdsRequestBiometryView(
                    isAuthenticated: $isAuthenticated,
                    applicationIcon: RefdsAsset.applicationIcon.image,
                    isAutomaticRequest: isAutomaticRequest
                )
                .background()
            }
        }
        .animation(
            .spring(),
            value: isAuthenticated
        )
    }
}
