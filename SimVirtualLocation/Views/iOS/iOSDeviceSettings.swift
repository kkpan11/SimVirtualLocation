//
//  iOSDeviceSettings.swift
//  SimVirtualLocation
//
//  Created by Sergey Shirnin on 18.04.2022.
//

import SwiftUI

struct iOSDeviceSettings: View {
    @EnvironmentObject var locationController: LocationController
    
    var body: some View {
        GroupBox {
            Picker("Device mode", selection: $locationController.deviceMode) {
                Text("Simulator").tag(LocationController.DeviceMode.simulator)
                Text("Device").tag(LocationController.DeviceMode.device)
            }.labelsHidden().pickerStyle(.segmented)

            if locationController.deviceMode == .simulator {
                Picker("Simulator:", selection: $locationController.selectedSimulator) {
                    ForEach(locationController.bootedSimulators, id: \.id) { simulator in
                        Text(simulator.name)
                    }
                }

                Button(action: {
                    locationController.refreshDevices()
                }, label: {
                    Text("Refresh").frame(maxWidth: .infinity)
                })
            }

            if locationController.deviceMode == .device {
                Toggle(isOn: $locationController.isNewEra) {
                    Text("iOS 17+")
                }
                if locationController.isNewEra {
                    TextField("RSD Address", text: $locationController.rsdID)
                    TextField("RSD Port", text: $locationController.rsdPort)
                } else {
                    Picker("Device:", selection: $locationController.selectedDevice) {
                        ForEach(locationController.connectedDevices, id: \.id) { device in
                            Text(device.name)
                        }
                    }

                    Button(action: {
                        locationController.refreshDevices()
                    }, label: {
                        Text("Refresh").frame(maxWidth: .infinity)
                    })
                }
            }
        }
    }
}

struct iOSDeviceSettings_Previews: PreviewProvider {
    static var previews: some View {
        iOSDeviceSettings()
    }
}
