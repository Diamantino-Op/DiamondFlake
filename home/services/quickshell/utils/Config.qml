pragma Singleton

import Quickshell
import Quickshell.Hyprland

Singleton {
    property list<string> preferredMonitorOrder: ["eDP-1"]
    property var preferredMonitor: () => {
        for (let mon in preferredMonitorOrder) {
            if (Hyprland.monitors.find(m => m.name == mon))
                return mon;
        }
    }

    readonly property var notificationExpireTimeout: 10
}