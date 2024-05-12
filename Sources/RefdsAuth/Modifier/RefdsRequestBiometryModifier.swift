import SwiftUI
import RefdsShared

public struct RefdsRequestBiometryViewModifier: ViewModifier {
    @Binding private var isAuthenticated: Bool
    private var isAutomaticRequest: Bool
    private let applicationIcon: Image
    
    public init(
        isAuthenticated: Binding<Bool>,
        applicationIcon: Image,
        isAutomaticRequest: Bool
    ) {
        self._isAuthenticated = isAuthenticated
        self.applicationIcon = applicationIcon
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
                    applicationIcon: applicationIcon,
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
