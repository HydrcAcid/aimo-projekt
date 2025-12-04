import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Fusion
import Qt.labs.qmlmodels

ColumnLayout {
    spacing: 15

    RowLayout {
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
}
