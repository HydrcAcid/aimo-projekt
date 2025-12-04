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
                value: opt_params.lambda
                onValueChanged: opt_params.lambda = value
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
                value: opt_params.mu
                onValueChanged: opt_params.mu = value
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
                value: opt_params.r
                onValueChanged: opt_params.r = value
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
                value: opt_params.c
                onValueChanged: opt_params.c = value
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
                text: "Liczba iteracji:"
                Layout.fillWidth: true
                font.pixelSize: 12
            }
            SpinBox {
                Layout.fillWidth: true
                implicitHeight: 24
                editable: true
                value: opt_params.iterMax
                onValueChanged: opt_params.iterMax = value
            }

            Label {
                text: "Maksymalna wartość m:"
                Layout.fillWidth: true
                font.pixelSize: 12
            }
            SpinBox {
                Layout.fillWidth: true
                implicitHeight: 24
                editable: true
                value: opt_params.mMax
                onValueChanged: opt_params.mMax = value
            }

            Label {
                text: "Ilość wilków:"
                Layout.fillWidth: true
                font.pixelSize: 12
            }
            SpinBox {
                Layout.fillWidth: true
                implicitHeight: 24
                editable: true
                value: opt_params.wolfCount
                onValueChanged: opt_params.wolfCount = value
            }

            Button {
                text: "Optymalizuj"
                Layout.alignment: Qt.AlignHCenter
                Layout.columnSpan: 2
                implicitHeight: 24
                font.pixelSize: 12
                onClicked: gwo.startOptimization()
            }
        }
    }

    ProgressBar {
        id: progressBar
        Layout.fillWidth: true
        from: 0
        to: 1
        value: 0
    }

    Connections {
        target: gwo

        function onOptimizationProgressChanged(progress) {
            progressBar.value = progress;
        }
    }
}
