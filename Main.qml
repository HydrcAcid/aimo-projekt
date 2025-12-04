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
            title: "Wygląd"

            MenuItem {
                checkable: true
                text: "Ciemny motyw"
                onTriggered: this.checked ? root.palette = root.darkPalette : root.palette = root.lightPalette
            }
        }
    }

    ColumnLayout {
        spacing: 7
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

        HorizontalHeaderView {
            syncView: resultsTable
            Layout.topMargin: 10

            model: ListModel {
                ListElement { display: "Nazwa wielkości" }
                ListElement { display: "Zmienna" }
                ListElement { display: "System 1" }
                ListElement { display: "System 2" }
            }

            delegate: Rectangle {
                implicitHeight: 30
                border.width: 1
                border.color: palette.shadow
                color: palette.alternateBase

                Text {
                    text: display
                    color: palette.text
                    anchors.fill: parent
                    anchors.margins: 6
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 14
                    font.bold: true
                }
            }
        }

        TableView {
            id: resultsTable
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.topMargin: -8

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

                TableModelColumn { display: "fullName" }
                TableModelColumn { display: "varName" }
                TableModelColumn { display: "value1" }
                TableModelColumn { display: "value2" }
            }

            delegate: Rectangle {
                implicitHeight: 30
                border.width: 1
                border.color: palette.shadow
                color: row % 2 ? palette.alternateBase : palette.base

                Text {
                    text: display
                    color: palette.text
                    anchors.fill: parent
                    anchors.margins: 6
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 12
                }
            }

            Connections {
                target: gwo

                readonly property var keyTranslations: {
                    "f_obj": "Wynik funkcji celu",
                    "p0": "Prawdopodobieństwo",
                    "pm": "Prawdopodobieństwo odmowy",
                    "a": "Względna zdolnośc obsługi",
                    "q": "Względna zdolność obsługi",
                    "n_mean": "Średnia liczba zgłoszeń w systemie",
                    "m_disp": "Średnia liczba kanałów obsługujących",
                    "m_empty": "Średnia liczba kanałów niezajętych",
                    "m_opt": "Optymalna wartość m",
                }

                function onAnalysisFinished(result) {
                    const oldRows = tableModel.rows;

                    const varNames = new Set();
                    for (const row of oldRows) {
                        varNames.add(row.varName);
                    }
                    for (const key in result) {
                        varNames.add(key);
                    }

                    const newRows = [];
                    for (const varName of varNames) {
                        newRows.push({
                             fullName: keyTranslations[varName] ?? varName,
                             varName,
                             value1: result[varName]?.toString() ?? "-",
                             value2: oldRows.find(row => row.varName === varName)?.value2.toString() ?? "-",
                         });
                    }
                    tableModel.rows = newRows;
                }

                function onOptimizationFinished(result) {
                    const oldRows = tableModel.rows;

                    const varNames = new Set();
                    for (const row of oldRows) {
                        varNames.add(row.varName);
                    }
                    for (const key in result) {
                        varNames.add(key);
                    }

                    const newRows = [];
                    for (const varName of varNames) {
                        newRows.push({
                             fullName: keyTranslations[varName] ?? varName,
                             varName,
                             value1: oldRows.find(row => row.varName === varName)?.value1.toString() ?? "-",
                             value2: result[varName].toString(),
                         });
                    }
                    tableModel.rows = newRows;
                }
            }
        }
    }
}
