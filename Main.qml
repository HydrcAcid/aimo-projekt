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

    color: darkModeCheckbox.checked ? "#0d1117" : "#fff"

    readonly property Palette darkPalette: Palette {
        alternateBase: "#1a1c1e"
        base: "#0d1117"
        button: "#21262d"
        buttonText: "#c9d1d9"
        dark: "#30363d"
        highlight: "#58a6ff"
        highlightedText: "#fff"
        light: "#30363d"
        mid: "#3e4451"
        midlight: "#2d333b"
        placeholderText: "#8b949e"
        shadow: "#6e7681"
        text: "#d3dbe3"
        window: "#666"
        windowText: "#c9d1d9"
    }

    readonly property Palette lightPalette: Palette {
        alternateBase: "#f6f8fa"
        base: "#fff"
        button: "#f3f4f6"
        buttonText: "#24292e"
        dark: "#d0d7de"
        highlight: "#0969da"
        highlightedText: "#fff"
        light: "#fff"
        mid: "#d8dee4"
        midlight: "#eaeef2"
        placeholderText: "#6e7781"
        shadow: "#1b1f2426"
        text: "#24292e"
        window: "#fff"
        windowText: "#24292e"
    }
    palette: darkModeCheckbox.checked ? darkPalette : lightPalette

    menuBar: MenuBar {
        background: Rectangle {
            implicitHeight: 20
            color: root.color
        }

        Menu {
            title: "Wygląd"

            MenuItem {
                id: darkModeCheckbox
                checkable: true
                text: "Ciemny motyw"
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

            color: "#eee"
            background: Rectangle {
                color: darkModeCheckbox.checked ? "#1a1f28" : "#4a5568"
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

        ScrollView {
            id: scrollView
            Layout.preferredWidth: parent.width
            Layout.fillHeight: true
            Layout.topMargin: -8
            Layout.bottomMargin: 4

            TableView {
                id: resultsTable
                clip: true
                anchors.fill: parent

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
                        "m_opt": "Optymalna wartość m",
                        "p0": "Prawdopodobieństwo stanu psutego",
                        "pm": "Prawdopodobieństwo odmowy",
                        "A": "Bezwzględna zdolnośc obsługi",
                        "q": "Względna zdolność obsługi",
                        "n_mean": "Średnia liczba zgłoszeń w systemie",
                        "m0_mean": "Średnia liczba kanałów obsługujących",
                        "mnz_mean": "Średnia liczba kanałów niezajętych",
                        "ts_mean": "Średni czas przebywania w systemie"
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
                                value2: result[varName]?.toString() ?? "-",
                            });
                        }
                        tableModel.rows = newRows;
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                onWheel: (wheel) => {
                    if (wheel.angleDelta.y > 0) {
                        scrollView.ScrollBar.vertical.decrease()
                    } else {
                        scrollView.ScrollBar.vertical.increase()
                    }
                    wheel.accepted = true
                }
            }
        }
    }
}
