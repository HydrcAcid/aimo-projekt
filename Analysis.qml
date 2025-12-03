import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Fusion
import Qt.labs.qmlmodels

ColumnLayout {
    spacing: 15

    RowLayout {
        id: root

        spacing: 20
        Layout.fillWidth: true
        Layout.fillHeight: false

        GridLayout {
            columns: 2
            Layout.fillWidth: true
            Layout.horizontalStretchFactor: 3
            Layout.alignment: Qt.AlignTop

            Label {
                text: "Intensywność strumienia zgłoszeń:"
                Layout.fillWidth: true
                Layout.horizontalStretchFactor: 3
                font.pixelSize: 12
            }
            SpinBox {
                Layout.fillWidth: true
                Layout.horizontalStretchFactor: 5
                implicitHeight: 24
                editable: true
                value: nls_params.lambda
                onValueChanged: nls_params.lambda = value
            }

            Label {
                text: "Średni czas obsługi:"
                Layout.fillWidth: true
                font.pixelSize: 12
            }
            SpinBox {
                Layout.fillWidth: true
                implicitHeight: 24
                editable: true
                value: nls_params.mu
                onValueChanged: nls_params.mu = value
            }

            Label {
                text: "Koszt R:"
                Layout.fillWidth: true
                font.pixelSize: 12
            }
            SpinBox {
                Layout.fillWidth: true
                implicitHeight: 24
                editable: true
                value: nls_params.r
                onValueChanged: nls_params.r = value
            }

            Label {
                text: "Koszt C:"
                Layout.fillWidth: true
                font.pixelSize: 12
            }
            SpinBox {
                Layout.fillWidth: true
                implicitHeight: 24
                editable: true
                value: nls_params.c
                onValueChanged: nls_params.c = value
            }
        }

        Rectangle {
            Layout.preferredWidth: 1
            Layout.fillHeight: true
            color: palette.dark
        }

        GridLayout {
            columns: 2
            Layout.fillWidth: true
            Layout.horizontalStretchFactor: 2
            Layout.alignment: Qt.AlignTop

            Label {
                text: "Liczba kanałów obsługi:"
                Layout.fillWidth: true
                Layout.horizontalStretchFactor: 3
                font.pixelSize: 12
            }
            SpinBox {
                Layout.fillWidth: true
                Layout.horizontalStretchFactor: 5
                implicitHeight: 24
                editable: true
                value: nls_params.m
                onValueChanged: nls_params.m = value
            }

            CheckBox {
                id: calculateProbability
                text: "Oblicz prawdopodobieństwo"
                font.pixelSize: 12
                Layout.columnSpan: 2
                onCheckedChanged: nls_params.calcProb = checked
            }

            Label {
                visible: calculateProbability.checked
                Layout.fillWidth: true
                text: "Przedział:"
                font.pixelSize: 12
                Layout.columnSpan: 2
            }

            Label {
                visible: calculateProbability.checked
                Layout.fillWidth: true
                text: "Od:"
                font.pixelSize: 12
            }
            SpinBox {
                visible: calculateProbability.checked
                Layout.fillWidth: true
                from: 1
                implicitHeight: 24
                editable: true
                value: nls_params.pLB
                onValueChanged: nls_params.pLB = value
            }

            Label {
                visible: calculateProbability.checked
                Layout.fillWidth: true
                text: "Do:"
                font.pixelSize: 12
            }
            SpinBox {
                visible: calculateProbability.checked
                Layout.fillWidth: true
                from: nls_params.pLB
                implicitHeight: 24
                editable: true
                value: nls_params.pUB
                onValueChanged: nls_params.pUB = value
            }

            Button {
                text: "Analizuj"
                Layout.alignment: Qt.AlignHCenter
                Layout.columnSpan: 2
                implicitHeight: 24
                font.pixelSize: 12
                onClicked: gwo.startAnalysis()
            }
        }
    }

    TableView {
        id: resultsTable

        Layout.fillWidth: true
        Layout.fillHeight: true
        interactive: false
        rowSpacing: -1
        columnSpacing: -1

        columnWidthProvider: function(column) {
            switch (column) {
            case 0: return resultsTable.width * 0.6;
            case 1: return resultsTable.width * 0.1;
            case 2: return resultsTable.width * 0.3;
            }
        }

        model: TableModel {
            id: tableModel

            TableModelColumn { display: "col1" }
            TableModelColumn { display: "col2" }
            TableModelColumn { display: "col3" }

            rows: [
                { col1: "Prawdopodobieństwo", col2: "p0", col3: "0" },
                { col1: "Prawdopodobieństwo", col2: "p1", col3: "0.02" },
                { col1: "Prawdopodobieństwo", col2: "p2", col3: "0.06" }
            ]
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
