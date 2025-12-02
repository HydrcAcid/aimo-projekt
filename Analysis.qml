import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Fusion

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
            id: analysisLambda
            value: 1
            Layout.fillWidth: true
            Layout.horizontalStretchFactor: 5
            implicitHeight: 24
            editable: true
        }

        Label {
            text: "Średni czas obsługi:"
            Layout.fillWidth: true
            font.pixelSize: 12
        }
        SpinBox {
            id: analysisServiceTime
            Layout.fillWidth: true
            value: 1
            implicitHeight: 24
            editable: true
        }

        CheckBox {
            id: calculateProbability
            text: "Oblicz prawdopodobieństwo"
            font.pixelSize: 12
            Layout.columnSpan: 2
        }

        Label {
            visible: calculateProbability.checked
            Layout.fillWidth: true
            text: "Przedział:"
            font.pixelSize: 12
        }
        SpinBox {
            id: calculationRange
            visible: calculateProbability.checked
            Layout.fillWidth: true
            from: 1
            value: 1
            implicitHeight: 24
            editable: true
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
            text: "Koszt R:"
            Layout.fillWidth: true
            font.pixelSize: 12
        }
        SpinBox {
            id: analysisCostR
            value: 1
            Layout.fillWidth: true
            implicitHeight: 24
            editable: true
        }

        Label {
            text: "Koszt C:"
            Layout.fillWidth: true
            font.pixelSize: 12
        }
        SpinBox {
            id: analysisCostC
            value: 1
            Layout.fillWidth: true
            implicitHeight: 24
            editable: true
        }

        Button {
            text: "Analizuj"
            Layout.alignment: Qt.AlignHCenter
            Layout.columnSpan: 2
            implicitHeight: 24
            font.pixelSize: 12
        }
    }
}
