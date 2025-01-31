import SwiftUI

struct DevicesGamePadSettingsView: View {
  let connectedDevice: LibKrbn.ConnectedDevice
  @Binding var showing: Bool
  @ObservedObject private var settings = LibKrbn.Settings.shared
  @State var connectedDeviceSetting: LibKrbn.ConnectedDeviceSetting?

  var body: some View {
    ZStack(alignment: .topLeading) {
      VStack(alignment: .leading, spacing: 12.0) {
        if let s = connectedDeviceSetting {
          let binding = Binding {
            s
          } set: {
            connectedDeviceSetting = $0
          }
          Text("\(connectedDevice.productName) (\(connectedDevice.manufacturerName))")
            .padding(.leading, 40)
            .padding(.top, 20)

          HStack {
            VStack(alignment: .leading, spacing: 0.0) {
              Text("Note:")
              Text(
                "These parameters are still under development and may change in the next release."
              )
            }

            Spacer()
          }
          .padding()
          .foregroundColor(Color.warningForeground)
          .background(Color.warningBackground)

          GroupBox(label: Text("Deadzone")) {
            VStack(alignment: .leading) {
              HStack {
                Toggle(isOn: binding.gamePadOverwriteXYStickDeadzone) {
                  Text("Overwrite XY stick deadzone: ")
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .switchToggleStyle(controlSize: .mini, font: .callout)
                .frame(width: 250.0)

                HStack(alignment: .center, spacing: 8.0) {
                  Text("Deadzone:")

                  DoubleTextField(
                    value: binding.gamePadXYStickDeadzone,
                    range: 0.05...1,
                    step: 0.01,
                    maximumFractionDigits: 3,
                    width: 60)

                  Text("(Default: 0.1)")
                }
                .padding(.leading, 20)
                .disabled(!s.gamePadOverwriteXYStickDeadzone)

                Spacer()
              }

              HStack {
                Toggle(isOn: binding.gamePadOverwriteWheelsStickDeadzone) {
                  Text("Overwrite Wheels stick deadzone: ")
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .switchToggleStyle(controlSize: .mini, font: .callout)
                .frame(width: 250.0)

                HStack(alignment: .center, spacing: 8.0) {
                  Text("Deadzone:")

                  DoubleTextField(
                    value: binding.gamePadWheelsStickDeadzone,
                    range: 0.05...1,
                    step: 0.01,
                    maximumFractionDigits: 3,
                    width: 60)

                  Text("(Default: 0.1)")
                }
                .padding(.leading, 20)
                .disabled(!s.gamePadOverwriteWheelsStickDeadzone)
              }
            }.padding()
          }

          GroupBox(label: Text("Stick parameters")) {
            VStack(alignment: .leading) {
              HStack {
                Toggle(
                  isOn: binding
                    .gamePadOverwriteStickStrokeAccelerationTransitionDurationMilliseconds
                ) {
                  Text("Overwrite stick stroke acceleration transition duration: ")
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .switchToggleStyle(controlSize: .mini, font: .callout)
                .frame(width: 250.0)

                HStack(alignment: .center, spacing: 8.0) {
                  Text("Duration:")

                  IntTextField(
                    value: binding.gamePadStickStrokeAccelerationTransitionDurationMilliseconds,
                    range: 0...10000,
                    step: 100,
                    width: 60)

                  Text("milliseconds (Default: 500)")
                }
                .padding(.leading, 20)
                .disabled(
                  !s.gamePadOverwriteStickStrokeAccelerationTransitionDurationMilliseconds)

                Spacer()
              }

              Toggle(isOn: binding.gamePadSwapSticks) {
                Text("Swap gamepad XY and wheels sticks")
              }
              .switchToggleStyle(controlSize: .mini, font: .callout)
            }
          }
        }

        Spacer()
      }

      SheetCloseButton {
        showing = false
      }
    }
    .padding()
    .frame(width: 1000, height: 600)
    .onAppear {
      setConnectedDeviceSetting()
    }
    .onChange(of: settings.connectedDeviceSettings) { _ in
      setConnectedDeviceSetting()
    }
  }

  private func setConnectedDeviceSetting() {
    connectedDeviceSetting = settings.findConnectedDeviceSetting(connectedDevice)
  }
}

struct DevicesGamePadSettingsView_Previews: PreviewProvider {
  @State static var connectedDevice = LibKrbn.ConnectedDevice(
    index: 0,
    manufacturerName: "",
    productName: "",
    transport: "",
    vendorId: 0,
    productId: 0,
    deviceAddress: nil,
    isKeyboard: false,
    isPointingDevice: false,
    isGamePad: true,
    isBuiltInKeyboard: false,
    isBuiltInTrackpad: false,
    isBuiltInTouchBar: false,
    isAppleDevice: false
  )
  @State static var showing = true

  static var previews: some View {
    DevicesGamePadSettingsView(
      connectedDevice: connectedDevice,
      showing: $showing)
  }
}
