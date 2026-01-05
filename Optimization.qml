import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Fusion
import Qt.labs.qmlmodels

ColumnLayout {
    spacing: 12

    Label {
        text: "Optymalizacja"
        font.pixelSize: 30
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        Layout.fillWidth: true
    }

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
            TextField {
                Layout.fillWidth: true
                implicitHeight: 24

                validator: DoubleValidator {
                    bottom: 0.0
                    decimals: 3
                }

                text: opt_params.lambda.toString()
                onEditingFinished: {
                    var normalized = text.replace(",", ".")
                    opt_params.lambda = parseFloat(normalized)
                    text = opt_params.lambda.toString()
                }
            }

            Label {
                text: "Średni czas obsługi:"
                Layout.fillWidth: true
                font.pixelSize: 12
            }
            TextField {
                Layout.fillWidth: true
                implicitHeight: 24

                validator: DoubleValidator {
                    bottom: 0.0
                    decimals: 3
                }

                text: opt_params.mu.toString()
                onEditingFinished: {
                    var normalized = text.replace(",", ".")
                    opt_params.mu = parseFloat(normalized)
                    text = opt_params.mu.toString()
                }
            }

            Label {
                text: "Koszt R:"
                Layout.fillWidth: true
                font.pixelSize: 12
            }
            TextField {
                Layout.fillWidth: true
                implicitHeight: 24

                validator: DoubleValidator {
                    bottom: 0.0
                    decimals: 3
                }

                text: opt_params.r.toString()
                onEditingFinished: {
                    var normalized = text.replace(",", ".")
                    opt_params.r = parseFloat(normalized)
                    text = opt_params.r.toString()
                }
            }

            Label {
                text: "Koszt C:"
                Layout.fillWidth: true
                font.pixelSize: 12
            }
            TextField {
                Layout.fillWidth: true
                implicitHeight: 24

                validator: DoubleValidator {
                    bottom: 0.0
                    decimals: 3
                }

                text: opt_params.c.toString()
                onEditingFinished: {
                    var normalized = text.replace(",", ".")
                    opt_params.c = parseFloat(normalized)
                    text = opt_params.c.toString()
                }
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

                from: 0
                to: 200

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

                from: 0
                to: 200

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

                from: 0
                to: 200

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

    Connections {
        target: gwo
    }
}
