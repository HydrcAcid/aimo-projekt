import QtQuick
import QtQuick.Controls.Fusion

Item {
    id: root

    property real value
    property int decimals: 3
    property real from: spinBox.defaultIntValidator.bottom * Math.pow(10, -decimals)
    property real to: spinBox.defaultIntValidator.top * Math.pow(10, -decimals)

    implicitWidth: spinBox.implicitWidth
    implicitHeight: spinBox.implicitHeight

    SpinBox {
        id: spinBox

        readonly property IntValidator defaultIntValidator: IntValidator {}
        readonly property real factor: Math.pow(10, root.decimals)

        editable: true
        anchors.fill: parent
        from: root.from * factor
        to: root.to * factor
        value: Math.round(root.value * factor)
        onValueChanged: root.value = value / factor

        validator: DoubleValidator {
            bottom: root.from
            top: root.to
            decimals: root.decimals
            notation: DoubleValidator.StandardNotation
        }

        textFromValue: function(value, locale) {
            // Note: toLocaleString cannot be used here because qml alters its default behavior
            return (value / factor).toString().replace('.', locale.decimalPoint);
        }

        valueFromText: function(text, locale) {
            return Math.round(Number.fromLocaleString(locale, text) * factor);
        }
    }
}
