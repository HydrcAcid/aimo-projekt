import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Fusion
import Qt.labs.qmlmodels

ApplicationWindow {
    id: root
    visible: true
    title: "Program do optymizacji systemów kolejkowych"

    width: 1225
    height: 720
    minimumWidth: 1225
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
        spacing: 15
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

        RowLayout {
            spacing: 12
            Layout.fillWidth: true

            Analysis {
                Layout.fillWidth: true
                Layout.preferredWidth: 1
                Layout.alignment: Qt.AlignTop
            }
            Rectangle {
                Layout.preferredWidth: 3
                Layout.fillHeight: true
                Layout.maximumHeight: parent.implicitHeight
                Layout.alignment: Qt.AlignTop
                color: palette.dark
            }
            Optimization {
                Layout.fillWidth: true
                Layout.preferredWidth: 1
                Layout.alignment: Qt.AlignTop
            }
        }

        TableView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            interactive: false
            rowSpacing: -1
            columnSpacing: -1

            columnWidthProvider: function(column) {
                switch (column) {
                case 0: return parent.width * 0.5;
                case 1: return parent.width * 0.1;
                case 2: return parent.width * 0.2;
                case 3: return parent.width * 0.2;
                }
            }

            model: TableModel {
                id: tableModel
                rows: [
                    { fullName: "Prawdopodopieństwo", varName: "p0", value1: 1.2, value2: 1.1 },
                    { fullName: "Prawdopodopieństwo", varName: "p1", value1: 2.2, value2: 2.1 },
                    { fullName: "Prawdopodopieństwo", varName: "p2", value1: 3.2, value2: 3.1 },
                ]

                TableModelColumn { display: "fullName" }
                TableModelColumn { display: "varName" }
                TableModelColumn { display: "value1" }
                TableModelColumn { display: "value2" }
            }

            delegate: Rectangle {
                implicitHeight: 30
                border.width: 1
                border.color: palette.shadow
                color: row % 2 ? palette.base : palette.alternateBase

                Text {
                    text: display
                    color: palette.text
                    anchors.fill: parent
                    anchors.margins: 6
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 12
                }
            }
        }
    }
}
