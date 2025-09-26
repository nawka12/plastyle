import QtQuick 2.5
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0

Rectangle {
    id: root
    color: "#14230b"  // Very dark background

    property int stage

    onStageChanged: {
        if (stage == 1) {
            introAnimation.running = true;
        } else if (stage == 5) {
            introAnimation.target = busyIndicator;
            introAnimation.from = 1;
            introAnimation.to = 0;
            introAnimation.running = true;
        }
    }

    Item {
        id: content
        anchors.fill: parent
        opacity: 0
        TextMetrics {
            id: units
            text: "M"
            property int gridUnit: boundingRect.height
            property int largeSpacing: units.gridUnit
            property int smallSpacing: Math.max(2, gridUnit/4)
        }

        // Background gradient
        Rectangle {
            anchors.fill: parent
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#14230b" }
                GradientStop { position: 0.5; color: "#1e1428" }
                GradientStop { position: 1.0; color: "#0c1423" }
            }
        }

        // Cyberpunk grid overlay
        Repeater {
            model: 20
            Rectangle {
                x: index * parent.width / 20
                width: 1
                height: parent.height
                color: "#BDABE3"
                opacity: 0.1
            }
        }

        Repeater {
            model: 15
            Rectangle {
                y: index * parent.height / 15
                width: parent.width
                height: 1
                color: "#64ffff"
                opacity: 0.08
            }
        }

        // Main logo area
        Rectangle {
            id: logo
            anchors.centerIn: parent
            width: Math.min(parent.width, parent.height) * 0.3
            height: width
            radius: width * 0.1
            color: "transparent"
            border.color: "#BDABE3"
            border.width: 3

            // Neon glow effect
            DropShadow {
                anchors.fill: logo
                horizontalOffset: 0
                verticalOffset: 0
                radius: 20
                samples: 25
                color: "#BDABE3"
                source: logo
                opacity: 0.8
            }

            // Inner content
            Text {
                anchors.centerIn: parent
                text: "KDE"
                font.family: "Noto Sans"
                font.weight: Font.Bold
                font.pixelSize: parent.width * 0.25
                color: "#dcffff"
                
                DropShadow {
                    anchors.fill: parent
                    horizontalOffset: 0
                    verticalOffset: 0
                    radius: 10
                    samples: 17
                    color: "#64ffff"
                    source: parent
                }
            }
        }

        // Theme name
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: logo.bottom
            anchors.topMargin: units.largeSpacing * 2
            text: "KawaiiBreezeDark"
            font.family: "Noto Sans"
            font.weight: Font.Light
            font.pixelSize: units.gridUnit * 1.5
            color: "#dcffff"
            
            DropShadow {
                anchors.fill: parent
                horizontalOffset: 0
                verticalOffset: 0
                radius: 8
                samples: 17
                color: "#BDABE3"
                source: parent
            }
        }

        // Loading indicator
        Rectangle {
            id: busyIndicator
            anchors.centerIn: parent
            anchors.verticalCenterOffset: logo.height
            width: units.gridUnit * 8
            height: 3
            radius: 2
            color: "transparent"
            border.color: "#64ffff"
            border.width: 1

            Rectangle {
                id: loadingBar
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                height: parent.height - 2
                radius: parent.radius
                width: 0
                color: "#BDABE3"

                SequentialAnimation on width {
                    loops: Animation.Infinite
                    running: true
                    
                    NumberAnimation {
                        from: 0
                        to: busyIndicator.width
                        duration: 2000
                        easing.type: Easing.InOutQuad
                    }
                    NumberAnimation {
                        from: busyIndicator.width
                        to: 0
                        duration: 2000
                        easing.type: Easing.InOutQuad
                    }
                }
            }

            // Glow effect for loading bar
            DropShadow {
                anchors.fill: busyIndicator
                horizontalOffset: 0
                verticalOffset: 0
                radius: 12
                samples: 25
                color: "#64ffff"
                source: busyIndicator
                opacity: 0.6
            }
        }

        // Version info
        Text {
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.margins: units.largeSpacing
            text: "Plasma " + kdeVersion
            font.family: "Noto Sans"
            font.pixelSize: units.gridUnit * 0.8
            color: "#BDABE3"
            opacity: 0.7
        }
    }

    OpacityAnimator {
        id: introAnimation
        running: false
        target: content
        from: 0
        to: 1
        duration: 1000
        easing.type: Easing.InOutQuad
    }
} 