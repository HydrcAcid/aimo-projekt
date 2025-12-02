import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Fusion

ApplicationWindow {
    id: root
    visible: true
    title: "Program do optymizacji systemów kolejkowych"

    width: 1024
    height: 720
    minimumWidth: 550
    minimumHeight: 600

    readonly property Palette darkPalette: Palette {
        alternateBase: "#222"
        base: "#000"
        button: "#111"
        buttonText: "#fff"
        dark: "#666"
        highlight: "#d73"
        highlightedText: "#000"
        light: "#000"
        mid: "#444"
        midlight: "#333"
        placeholderText: "#80000000"
        shadow: "#888"
        text: "#fff"
        window: "#222"
        windowText: "#fff"
    }
    readonly property Palette lightPalette: Palette {
        alternateBase: "#ddd"
        base: "#fff"
        button: "#eee"
        buttonText: "#000"
        dark: "#999"
        highlight: "#38c"
        highlightedText: "#fff"
        light: "#fff"
        mid: "#bbb"
        midlight: "#ccc"
        placeholderText: "#80000000"
        shadow: "#777"
        text: "#000"
        window: "#eee"
        windowText: "#000"
    }
    palette: lightPalette

    menuBar: MenuBar {
        Menu {
            title: "Wybór systemu"

            MenuItem {
                text: "M/M/m/-/m"
            }
        }
        Menu {
            title: "Informacje"

            MenuItem {
                checkable: true
                text: "Ciemny motyw"
                onTriggered: this.checked ? root.palette = root.darkPalette : root.palette = root.lightPalette
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 7

        Label {
            Layout.fillWidth: true

            text: "M/M/m/-/m"

            font.pixelSize: 30
            font.bold: true

            topPadding: 15
            bottomPadding: 15
            horizontalAlignment: Text.AlignHCenter

            color: "#ddd"
            background: Rectangle {
                color: "#005"
            }
        }

        TabBar {
            id: tabBar

            TabButton {
                text: "Analiza"
                width: implicitWidth + 10
            }
            TabButton {
                text: "Optymalizacja"
                width: implicitWidth + 10
            }
        }

        StackLayout {
            currentIndex: tabBar.currentIndex
            Layout.fillWidth: true
            Layout.fillHeight: true

            Analysis {}
            Optimization {}
        }
    }
}
