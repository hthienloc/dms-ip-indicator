import QtQuick
import QtQuick.Controls
import qs.Common
import qs.Services
import qs.Widgets
import qs.Modules.Plugins

PluginSettings {
    id: root
    pluginId: "ipIndicator"

    StyledText {
        width: parent.width
        text: "IP Indicator Settings"
        font.pixelSize: Theme.fontSizeLarge
        font.weight: Font.Bold
        color: Theme.surfaceText
    }

    StyledRect {
        width: parent.width
        height: displayColumn.implicitHeight + Theme.spacingL * 2
        radius: Theme.cornerRadius
        color: Theme.surfaceContainerHigh

        Column {
            id: displayColumn
            anchors.fill: parent
            anchors.margins: Theme.spacingL
            spacing: Theme.spacingM

            StyledText {
                text: "Display"
                font.pixelSize: Theme.fontSizeMedium
                font.weight: Font.Medium
                color: Theme.surfaceText
            }

            ToggleSetting {
                settingKey: "showIP"
                label: "Show IP Address"
                defaultValue: true
            }

            ToggleSetting {
                settingKey: "showISP"
                label: "Show ISP"
                defaultValue: true
            }

            ToggleSetting {
                settingKey: "showLocation"
                label: "Show Location"
                defaultValue: true
            }

            ToggleSetting {
                settingKey: "privacyDefault"
                label: "Privacy Mode by Default"
                description: "Start with IP hidden. Right-click to toggle."
                defaultValue: false
            }
        }
    }

    StyledRect {
        width: parent.width
        height: behaviorColumn.implicitHeight + Theme.spacingL * 2
        radius: Theme.cornerRadius
        color: Theme.surfaceContainerHigh

        Column {
            id: behaviorColumn
            anchors.fill: parent
            anchors.margins: Theme.spacingL
            spacing: Theme.spacingM

            StyledText {
                text: "Behavior"
                font.pixelSize: Theme.fontSizeMedium
                font.weight: Font.Medium
                color: Theme.surfaceText
            }

            ToggleSetting {
                settingKey: "autoRefresh"
                label: "Auto Refresh on Start"
                description: "Fetch IP information when plugin loads."
                defaultValue: true
            }

            ToggleSetting {
                settingKey: "showHint"
                label: "Show Hint"
                description: "Display hint about right-click functionality."
                defaultValue: true
            }
        }
    }
}