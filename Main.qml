import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

ApplicationWindow {
    visible: true
    title: "Program do optymizacji systemów kolejkowych"

    width: 1024
    height: 720
    minimumWidth: 500
    minimumHeight: 600

    menuBar: MenuBar {
        Menu {
            title: "Wybór systemu"
        }
        Menu {
            title: "Informacje"
        }
    }

    ColumnLayout {
        anchors.fill: parent

        Label {
            Layout.fillWidth: true

            text: "M/M/m/-/m"

            font.pixelSize: 30
            font.bold: true

            topPadding: 15
            bottomPadding: 15
            horizontalAlignment: Text.AlignHCenter

            color: Material.color(Material.Grey, Material.Shade200)
            background: Rectangle {
                color: Material.color(Material.Indigo, Material.Shade900)
            }
        }

        TabBar {
            id: tabBar
            Layout.fillWidth: true

            TabButton {
                text: "Analiza"
            }
            TabButton {
                text: "Porównanie"
            }
            TabButton {
                text: "Optymalizacja"
            }
        }

        StackLayout {
            Layout.fillHeight: true
            currentIndex: tabBar.currentIndex
            Item {
                Label { text: "Analiza" }
            }
            Item {
                Label { text: "Porównanie" }
            }
            Item {
                Label { text: "Optymalizacja" }
            }
        }
    }
}
