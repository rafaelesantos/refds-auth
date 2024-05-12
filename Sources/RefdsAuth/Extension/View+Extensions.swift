import SwiftUI

public extension View {
    func refdsAuth(
        autheticated: Binding<Bool>,
        isAutomaticRequest: Bool = true
    ) -> some View {
        self.modifier(
            RefdsRequestBiometryViewModifier(
                authenticated: autheticated,
                isAutomaticRequest: isAutomaticRequest
            )
        )
    }
}
