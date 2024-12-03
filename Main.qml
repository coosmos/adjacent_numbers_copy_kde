import QtQuick 2.15

Rectangle {
    width: 400
    height: 400
    color: "#f0f0f0"
    focus: true

    property int selectedTileIndex: -1 // Track the selected tile

    Repeater {
        model: 3
        delegate: Rectangle {
            width: 100
            height: 100


            x: (index * 120)+20
            y: 150
            color: index === selectedTileIndex ? "orange" : "green"
            border.color: "black"
            border.width: 2

            Text {
                anchors.centerIn: parent
                text: "Tile " + (index + 1)
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    selectedTileIndex = index; // Set selected tile when clicked
                    console.log("Tile " + (index + 1) + " selected");
                }
            }

        }
    }
    Keys.onPressed: {
        if (event.key === Qt.Key_Left) {
            selectedTileIndex = (selectedTileIndex - 1 + 3) % 3;
            console.log("Selected Tile Index:", selectedTileIndex);
        } else if (event.key === Qt.Key_Right) {
            selectedTileIndex = (selectedTileIndex + 1) % 3;
            console.log("Selected Tile Index:", selectedTileIndex);
        }
    }


}
