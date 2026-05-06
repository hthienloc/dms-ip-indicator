import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import qs.Common
import qs.Services
import qs.Widgets
import qs.Modules.Plugins

PluginComponent {
    id: root

    property string publicIP: ""
    property string ispName: ""
    property string countryCode: ""
    property string countryName: ""
    property string regionName: ""
    property string cityName: ""
    property string statusMessage: "..."
    property bool privacyMode: (pluginData.privacyDefault || false)
    property bool autoRefresh: (pluginData.autoRefresh ?? true)
    readonly property bool showHint: (pluginData.showHint ?? true)
    readonly property bool showIP: (pluginData.showIP ?? true)
    readonly property bool showISP: (pluginData.showISP ?? true)
    readonly property bool showLocation: (pluginData.showLocation ?? true)

    Component.onCompleted: {
        if (autoRefresh) {
            statusMessage = "Loading..."
            fetchIPInfo()
        } else {
            statusMessage = "Click to fetch"
        }
    }

    function fetchIPInfo() {
        statusMessage = "Fetching..."
        
        Proc.runCommand(
            "fetch-ip",
            ["curl", "-s", "http://ip-api.com/json"],
            function(output, exitCode) {
                if (exitCode !== 0) {
                    statusMessage = "Error"
                    return
                }
                if (!output) {
                    statusMessage = "No data"
                    return
                }
                try {
                    var data = JSON.parse(output)
                    publicIP = data.query || data.ip || ""
                    ispName = data.isp || data.org || ""
                    countryCode = (data.countryCode || "").toLowerCase()
                    countryName = data.country || ""
                    regionName = data.regionName || data.region || ""
                    cityName = data.city || ""
                    statusMessage = "OK"
                } catch(e) {
                    statusMessage = "Error"
                }
            },
            30000
        )
    }

    function togglePrivacy() {
        privacyMode = !privacyMode
    }

    function getDisplayText() {
        if (privacyMode) return "Hidden"
        if (root.publicIP) {
            if (countryCode) {
                return countryCode.toUpperCase() + " " + root.publicIP
            }
            return root.publicIP
        }
        return root.statusMessage
    }

    readonly property color pillColor: {
        if (privacyMode) return Theme.warning
        if (root.publicIP) return Theme.primary
        return Theme.surfaceText
    }

    pillRightClickAction: () => { togglePrivacy() }

    horizontalBarPill: Component {
        Row {
            spacing: Theme.spacingS

            DankIcon {
                name: privacyMode ? "visibility_off" : "public"
                size: Theme.iconSizeSmall
                color: root.pillColor
                anchors.verticalCenter: parent.verticalCenter
            }

            StyledText {
                text: root.getDisplayText()
                color: root.pillColor
                font.pixelSize: Theme.fontSizeMedium
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    verticalBarPill: Component {
        Column {
            spacing: Theme.spacingXS

            DankIcon {
                name: privacyMode ? "visibility_off" : "public"
                size: Theme.iconSizeSmall
                color: root.pillColor
                anchors.horizontalCenter: parent.horizontalCenter
            }

            StyledText {
                text: root.getDisplayText()
                color: root.pillColor
                font.pixelSize: Theme.fontSizeSmall
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

    popoutContent: Component {
        FocusScope {
            width: parent ? parent.width : 0
            implicitHeight: mainContent.implicitHeight

            PopoutComponent {
                id: mainContent
                width: parent.width
                headerText: "IP Indicator"
                detailsText: privacyMode ? "Hidden" : root.statusMessage
                showCloseButton: false

                Column {
                    width: parent.width
                    spacing: Theme.spacingM

                    Row {
                        spacing: Theme.spacingS
                        anchors.horizontalCenter: parent.horizontalCenter

                        DankButton {
                            text: privacyMode ? "Show" : "Hide"
                            iconName: privacyMode ? "visibility" : "visibility_off"
                            backgroundColor: Theme.warning
                            textColor: Theme.onSurface
                            onClicked: togglePrivacy()
                        }

                        DankButton {
                            text: "Refresh"
                            iconName: "refresh"
                            backgroundColor: Theme.primary
                            textColor: Theme.onPrimary
                            onClicked: fetchIPInfo()
                        }
                    }

                    Column {
                        spacing: Theme.spacingS
                        visible: root.showIP

                        StyledText {
                            text: "IP"
                            font.pixelSize: Theme.fontSizeSmall
                            color: Theme.surfaceVariantText
                        }

                        StyledText {
                            text: (privacyMode || !publicIP) ? "----" : publicIP
                            font.pixelSize: Theme.fontSizeMedium
                            color: Theme.surfaceText
                        }
                    }

                    Column {
                        spacing: Theme.spacingS
                        visible: root.showISP

                        StyledText {
                            text: "ISP"
                            font.pixelSize: Theme.fontSizeSmall
                            color: Theme.surfaceVariantText
                        }

                        StyledText {
                            text: privacyMode ? "----" : (ispName || "N/A")
                            font.pixelSize: Theme.fontSizeMedium
                            color: Theme.surfaceText
                        }
                    }

                    Column {
                        spacing: Theme.spacingS
                        visible: root.showLocation

                        StyledText {
                            text: "Location"
                            font.pixelSize: Theme.fontSizeSmall
                            color: Theme.surfaceVariantText
                        }

                        StyledText {
                            text: privacyMode ? "----" : (countryName ? countryName + (cityName || regionName ? " - " + (cityName || regionName) : "") : "N/A")
                            font.pixelSize: Theme.fontSizeMedium
                            color: Theme.surfaceText
                        }
                    }

                    Column {
                        spacing: Theme.spacingXS
                        visible: root.showHint

                        StyledText {
                            text: "Hint: Right-click icon"
                            font.pixelSize: Theme.fontSizeSmall
                            color: Theme.surfaceVariantText
                            horizontalAlignment: Text.AlignHCenter
                        }

                        StyledText {
                            text: "to hide/show IP"
                            font.pixelSize: Theme.fontSizeSmall
                            color: Theme.surfaceVariantText
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                }
            }
        }
    }

    popoutWidth: 260
    popoutHeight: 360
}