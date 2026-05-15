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
        height: barColumn.implicitHeight + Theme.spacingL * 2
        radius: Theme.cornerRadius
        color: Theme.surfaceContainerHigh

        Column {
            id: barColumn
            anchors.fill: parent
            anchors.margins: Theme.spacingL
            spacing: Theme.spacingM

            StyledText {
                text: "Bar Display"
                font.pixelSize: Theme.fontSizeMedium
                font.weight: Font.Medium
                color: Theme.surfaceText
            }

            SelectionSetting {
                settingKey: "displayMode"
                label: "Display"
                description: "What to show on the bar."
                options: [
                    { label: "Country", value: "country" },
                    { label: "Country + IP", value: "country_ip" },
                    { label: "IP Address", value: "ip" },
                    { label: "Icon Only", value: "icon" }
                ]
                defaultValue: "country"
            }
        }
    }

    StyledRect {
        width: parent.width
        height: popoutColumn.implicitHeight + Theme.spacingL * 2
        radius: Theme.cornerRadius
        color: Theme.surfaceContainerHigh

        Column {
            id: popoutColumn
            anchors.fill: parent
            anchors.margins: Theme.spacingL
            spacing: Theme.spacingM

            StyledText {
                text: "Popout"
                font.pixelSize: Theme.fontSizeMedium
                font.weight: Font.Medium
                color: Theme.surfaceText
            }

            ToggleSetting {
                settingKey: "showIP"
                label: "Show IP"
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
                settingKey: "privacyDefault"
                label: "Privacy Mode by Default"
                description: "Start with IP hidden."
                defaultValue: false
            }

            ToggleSetting {
                settingKey: "autoRefresh"
                label: "Auto Refresh on Start"
                description: "Fetch IP when plugin loads."
                defaultValue: true
            }

            ToggleSetting {
                settingKey: "showHints"
                label: "Show Hints"
                description: "Display helpful usage tips in the plugin popout."
                defaultValue: true
            }
        }
    }
}