import QtQuick
import QtQuick.Controls

ApplicationWindow {
    visible: true
    title: "Program do optymizacji systemów kolejkowych"
    width: 1024
    height: 720

    Column {
        anchors.centerIn: parent
        spacing: 12

        // UI Tylko do testów
        Row {
            spacing: 8
            Text { text: "max iter:"; width: 100 }
            SpinBox {
                from: 0; to: 1000
                value: opt_params.iterMax
                onValueChanged: opt_params.iterMax = value
            }
        }

        Row {
            spacing: 8
            Text { text: "wolf count:"; width: 100 }
            SpinBox {
                from: 0; to: 200
                value: opt_params.wolfCount
                onValueChanged: opt_params.wolfCount = value
            }
        }

        Row {
            spacing: 8
            Text { text: "lambda:"; width: 100 }
            SpinBox {
                from: 0; to: 200
                value: opt_params.lambda
                onValueChanged: opt_params.lambda = value
            }
        }

        Row {
            spacing: 8
            Text { text: "mu:"; width: 100 }
            SpinBox {
                from: 0; to: 200
                value: opt_params.mu
                onValueChanged: opt_params.mu = value
            }
        }

        Row {
            spacing: 8
            Text { text: "m max:"; width: 100 }
            SpinBox {
                from: 0; to: 100
                value: opt_params.mMax
                onValueChanged: opt_params.mMax = value
            }
        }

        Row {
            spacing: 8
            Text { text: "r:"; width: 100 }
            SpinBox {
                from: 0; to: 10
                value: opt_params.r
                onValueChanged: opt_params.r = value
            }
        }

        Row {
            spacing: 8
            Text { text: "c:"; width: 100 }
            SpinBox {
                from: 0; to: 10
                value: opt_params.c
                onValueChanged: opt_params.c = value
            }
        }

        Button {
            text: "Run Optimization"
            onClicked: {
                gwo.startOptimization();
            }
        }

        ProgressBar {
            id: progressBar
            from: 0
            to: 1
            width: 250
            value: 0
        }

        Text { id: objectiveValue; text: "Obj value: " }
    }

    Connections {
        target: gwo
        function onOptimizationFinished(result) {
            // Test
            objectiveValue.text = "Obj value: " + result.f_obj;
        }
        function onOptimizationProgressChanged(v) {
            progressBar.value = v;
        }
    }


}
