import Foundation

extension LibKrbn {
  final class ConnectedDeviceSetting: Identifiable, Equatable, ObservableObject {
    private var didSetEnabled = false

    var id = UUID()
    var connectedDevice: ConnectedDevice

    init(_ connectedDevice: ConnectedDevice) {
      self.connectedDevice = connectedDevice

      let ignore = libkrbn_core_configuration_get_selected_profile_device_ignore(
        Settings.shared.libkrbnCoreConfiguration,
        connectedDevice.libkrbnDeviceIdentifiers)
      modifyEvents = !ignore

      self.manipulateCapsLockLed =
        libkrbn_core_configuration_get_selected_profile_device_manipulate_caps_lock_led(
          Settings.shared.libkrbnCoreConfiguration,
          connectedDevice.libkrbnDeviceIdentifiers)

      self.treatAsBuiltInKeyboard =
        libkrbn_core_configuration_get_selected_profile_device_treat_as_built_in_keyboard(
          Settings.shared.libkrbnCoreConfiguration,
          connectedDevice.libkrbnDeviceIdentifiers)

      self.disableBuiltInKeyboardIfExists =
        libkrbn_core_configuration_get_selected_profile_device_disable_built_in_keyboard_if_exists(
          Settings.shared.libkrbnCoreConfiguration,
          connectedDevice.libkrbnDeviceIdentifiers)

      self.mouseFlipX =
        libkrbn_core_configuration_get_selected_profile_device_mouse_flip_x(
          Settings.shared.libkrbnCoreConfiguration,
          connectedDevice.libkrbnDeviceIdentifiers)

      self.mouseFlipY =
        libkrbn_core_configuration_get_selected_profile_device_mouse_flip_y(
          Settings.shared.libkrbnCoreConfiguration,
          connectedDevice.libkrbnDeviceIdentifiers)

      self.mouseFlipVerticalWheel =
        libkrbn_core_configuration_get_selected_profile_device_mouse_flip_vertical_wheel(
          Settings.shared.libkrbnCoreConfiguration,
          connectedDevice.libkrbnDeviceIdentifiers)

      self.mouseFlipHorizontalWheel =
        libkrbn_core_configuration_get_selected_profile_device_mouse_flip_horizontal_wheel(
          Settings.shared.libkrbnCoreConfiguration,
          connectedDevice.libkrbnDeviceIdentifiers)

      self.mouseSwapXY =
        libkrbn_core_configuration_get_selected_profile_device_mouse_swap_xy(
          Settings.shared.libkrbnCoreConfiguration,
          connectedDevice.libkrbnDeviceIdentifiers)

      self.mouseSwapWheels =
        libkrbn_core_configuration_get_selected_profile_device_mouse_swap_wheels(
          Settings.shared.libkrbnCoreConfiguration,
          connectedDevice.libkrbnDeviceIdentifiers)

      self.gamePadSwapSticks =
        libkrbn_core_configuration_get_selected_profile_device_game_pad_swap_sticks(
          Settings.shared.libkrbnCoreConfiguration,
          connectedDevice.libkrbnDeviceIdentifiers)

      self.gamePadOverwriteXYStickDeadzone =
        libkrbn_core_configuration_has_selected_profile_device_game_pad_xy_stick_deadzone(
          Settings.shared.libkrbnCoreConfiguration,
          connectedDevice.libkrbnDeviceIdentifiers
        )

      self.gamePadXYStickDeadzone =
        libkrbn_core_configuration_get_selected_profile_device_game_pad_xy_stick_deadzone(
          Settings.shared.libkrbnCoreConfiguration,
          connectedDevice.libkrbnDeviceIdentifiers)

      self.gamePadOverwriteWheelsStickDeadzone =
        libkrbn_core_configuration_has_selected_profile_device_game_pad_wheels_stick_deadzone(
          Settings.shared.libkrbnCoreConfiguration,
          connectedDevice.libkrbnDeviceIdentifiers
        )

      self.gamePadWheelsStickDeadzone =
        libkrbn_core_configuration_get_selected_profile_device_game_pad_wheels_stick_deadzone(
          Settings.shared.libkrbnCoreConfiguration,
          connectedDevice.libkrbnDeviceIdentifiers)

      self.gamePadOverwriteStickStrokeAccelerationTransitionDurationMilliseconds =
        libkrbn_core_configuration_has_selected_profile_device_game_pad_stick_stroke_acceleration_transition_duration_milliseconds(
          Settings.shared.libkrbnCoreConfiguration,
          connectedDevice.libkrbnDeviceIdentifiers)

      self.gamePadStickStrokeAccelerationTransitionDurationMilliseconds =
        Int(
          libkrbn_core_configuration_get_selected_profile_device_game_pad_stick_stroke_acceleration_transition_duration_milliseconds(
            Settings.shared.libkrbnCoreConfiguration,
            connectedDevice.libkrbnDeviceIdentifiers))

      simpleModifications = LibKrbn.Settings.shared.makeSimpleModifications(connectedDevice)
      fnFunctionKeys = LibKrbn.Settings.shared.makeFnFunctionKeys(connectedDevice)

      didSetEnabled = true
    }

    @Published var modifyEvents: Bool = false {
      didSet {
        if didSetEnabled {
          libkrbn_core_configuration_set_selected_profile_device_ignore(
            Settings.shared.libkrbnCoreConfiguration,
            connectedDevice.libkrbnDeviceIdentifiers,
            !modifyEvents)
          Settings.shared.save()
        }
      }
    }

    @Published var manipulateCapsLockLed: Bool = false {
      didSet {
        if didSetEnabled {
          libkrbn_core_configuration_set_selected_profile_device_manipulate_caps_lock_led(
            Settings.shared.libkrbnCoreConfiguration,
            connectedDevice.libkrbnDeviceIdentifiers,
            manipulateCapsLockLed)
          Settings.shared.save()
        }
      }
    }

    @Published var treatAsBuiltInKeyboard: Bool = false {
      didSet {
        if didSetEnabled {
          libkrbn_core_configuration_set_selected_profile_device_treat_as_built_in_keyboard(
            Settings.shared.libkrbnCoreConfiguration,
            connectedDevice.libkrbnDeviceIdentifiers,
            treatAsBuiltInKeyboard)
          Settings.shared.save()
        }
      }
    }

    @Published var disableBuiltInKeyboardIfExists: Bool = false {
      didSet {
        if didSetEnabled {
          libkrbn_core_configuration_set_selected_profile_device_disable_built_in_keyboard_if_exists(
            Settings.shared.libkrbnCoreConfiguration,
            connectedDevice.libkrbnDeviceIdentifiers,
            disableBuiltInKeyboardIfExists)
          Settings.shared.save()
        }
      }
    }

    @Published var mouseFlipX: Bool = false {
      didSet {
        if didSetEnabled {
          libkrbn_core_configuration_set_selected_profile_device_mouse_flip_x(
            Settings.shared.libkrbnCoreConfiguration,
            connectedDevice.libkrbnDeviceIdentifiers,
            mouseFlipX)
          Settings.shared.save()
        }
      }
    }

    @Published var mouseFlipY: Bool = false {
      didSet {
        if didSetEnabled {
          libkrbn_core_configuration_set_selected_profile_device_mouse_flip_y(
            Settings.shared.libkrbnCoreConfiguration,
            connectedDevice.libkrbnDeviceIdentifiers,
            mouseFlipY)
          Settings.shared.save()
        }
      }
    }

    @Published var mouseFlipVerticalWheel: Bool = false {
      didSet {
        if didSetEnabled {
          libkrbn_core_configuration_set_selected_profile_device_mouse_flip_vertical_wheel(
            Settings.shared.libkrbnCoreConfiguration,
            connectedDevice.libkrbnDeviceIdentifiers,
            mouseFlipVerticalWheel)
          Settings.shared.save()
        }
      }
    }
    @Published var mouseFlipHorizontalWheel: Bool = false {
      didSet {
        if didSetEnabled {
          libkrbn_core_configuration_set_selected_profile_device_mouse_flip_horizontal_wheel(
            Settings.shared.libkrbnCoreConfiguration,
            connectedDevice.libkrbnDeviceIdentifiers,
            mouseFlipHorizontalWheel)
          Settings.shared.save()
        }
      }
    }

    @Published var mouseSwapXY: Bool = false {
      didSet {
        if didSetEnabled {
          libkrbn_core_configuration_set_selected_profile_device_mouse_swap_xy(
            Settings.shared.libkrbnCoreConfiguration,
            connectedDevice.libkrbnDeviceIdentifiers,
            mouseSwapXY)
          Settings.shared.save()
        }
      }
    }

    @Published var mouseSwapWheels: Bool = false {
      didSet {
        if didSetEnabled {
          libkrbn_core_configuration_set_selected_profile_device_mouse_swap_wheels(
            Settings.shared.libkrbnCoreConfiguration,
            connectedDevice.libkrbnDeviceIdentifiers,
            mouseSwapWheels)
          Settings.shared.save()
        }
      }
    }

    @Published var gamePadSwapSticks: Bool = false {
      didSet {
        if didSetEnabled {
          libkrbn_core_configuration_set_selected_profile_device_game_pad_swap_sticks(
            Settings.shared.libkrbnCoreConfiguration,
            connectedDevice.libkrbnDeviceIdentifiers,
            gamePadSwapSticks)
          Settings.shared.save()
        }
      }
    }

    //
    // gamePadXYStickDeadzone
    //

    @Published var gamePadOverwriteXYStickDeadzone: Bool = false {
      didSet {
        if didSetEnabled {
          saveGamePadXYStickDeadzone()
        }
      }
    }

    @Published var gamePadXYStickDeadzone: Double = 0.0 {
      didSet {
        if didSetEnabled {
          saveGamePadXYStickDeadzone()
        }
      }
    }

    private func saveGamePadXYStickDeadzone() {
      if gamePadOverwriteXYStickDeadzone {
        libkrbn_core_configuration_set_selected_profile_device_game_pad_xy_stick_deadzone(
          Settings.shared.libkrbnCoreConfiguration,
          connectedDevice.libkrbnDeviceIdentifiers,
          gamePadXYStickDeadzone)
      } else {
        libkrbn_core_configuration_unset_selected_profile_device_game_pad_xy_stick_deadzone(
          Settings.shared.libkrbnCoreConfiguration,
          connectedDevice.libkrbnDeviceIdentifiers)
      }

      Settings.shared.save()
    }

    //
    // gamePadWheelsStickDeadzone
    //

    @Published var gamePadOverwriteWheelsStickDeadzone: Bool = false {
      didSet {
        if didSetEnabled {
          saveGamePadWheelsStickDeadzone()
        }
      }
    }

    @Published var gamePadWheelsStickDeadzone: Double = 0.0 {
      didSet {
        if didSetEnabled {
          saveGamePadWheelsStickDeadzone()
        }
      }
    }

    private func saveGamePadWheelsStickDeadzone() {
      if gamePadOverwriteWheelsStickDeadzone {
        libkrbn_core_configuration_set_selected_profile_device_game_pad_wheels_stick_deadzone(
          Settings.shared.libkrbnCoreConfiguration,
          connectedDevice.libkrbnDeviceIdentifiers,
          gamePadWheelsStickDeadzone)
      } else {
        libkrbn_core_configuration_unset_selected_profile_device_game_pad_wheels_stick_deadzone(
          Settings.shared.libkrbnCoreConfiguration,
          connectedDevice.libkrbnDeviceIdentifiers)
      }

      Settings.shared.save()
    }

    //
    // gamePadStickStrokeAccelerationTransitionDurationMilliseconds
    //

    @Published var gamePadOverwriteStickStrokeAccelerationTransitionDurationMilliseconds: Bool =
      false
    {
      didSet {
        if didSetEnabled {
          saveGamePadStickStrokeAccelerationTransitionDurationMilliseconds()
        }
      }
    }

    @Published var gamePadStickStrokeAccelerationTransitionDurationMilliseconds: Int = 0 {
      didSet {
        if didSetEnabled {
          saveGamePadStickStrokeAccelerationTransitionDurationMilliseconds()
        }
      }
    }

    private func saveGamePadStickStrokeAccelerationTransitionDurationMilliseconds() {
      if gamePadOverwriteStickStrokeAccelerationTransitionDurationMilliseconds {
        libkrbn_core_configuration_set_selected_profile_device_game_pad_stick_stroke_acceleration_transition_duration_milliseconds(
          Settings.shared.libkrbnCoreConfiguration,
          connectedDevice.libkrbnDeviceIdentifiers,
          Int32(gamePadStickStrokeAccelerationTransitionDurationMilliseconds))
      } else {
        libkrbn_core_configuration_unset_selected_profile_device_game_pad_stick_stroke_acceleration_transition_duration_milliseconds(
          Settings.shared.libkrbnCoreConfiguration,
          connectedDevice.libkrbnDeviceIdentifiers)
      }

      Settings.shared.save()
    }

    @Published var simpleModifications: [SimpleModification] = []
    @Published var fnFunctionKeys: [SimpleModification] = []

    public static func == (lhs: ConnectedDeviceSetting, rhs: ConnectedDeviceSetting) -> Bool {
      lhs.id == rhs.id
    }
  }
}
