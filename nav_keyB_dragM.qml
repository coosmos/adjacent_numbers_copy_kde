import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    width: 400
    height: 400
    focus: true

    property int selectedTileIndex: 0 // Track the selected tile
    property var originalPositions: [] // Store original positions of tiles

    // Save original positions when the component is completed
    Component.onCompleted: {
        for (let i = 0; i < tileModel.count; i++) {
            let tile = tileRepeater.itemAt(i);
            originalPositions.push({ x: tile.x, y: tile.y });
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "#f0f0f0"
    }

    // Drop Area
    Rectangle {
        id: dropArea
        width: 100
        height: 100
        color: "#a0ffa0"
        border.color: "#00aa00"
        border.width: 2
        radius: 10
        anchors.centerIn: parent
    }

    // Model for tiles
    ListModel {
        id: tileModel
        ListElement { label: "Tile 1" }
        ListElement { label: "Tile 2" }
        ListElement { label: "Tile 3" }
    }

    // Tile Repeater
    Repeater {
        id: tileRepeater
        model: tileModel

        Rectangle {
            id: draggableTile
            property int index: model.index
            property string label: modelData.label
            property bool droppedOnTarget: false // Track if dropped correctly


            width: 100
            height: 100
            color: selectedTileIndex === index ? "#88cc88" : "#cccccc"
            border.color: "black"
            border.width: 2
            radius: 5

            // Initial positions
            x: 20+(index * 120)
            y: 300

            Text {
                anchors.centerIn: parent
                text: label
            }

            // Drag logic
            Drag.active: dragArea.drag.active
            // Drag.hotSpot.x: dragArea.width / 2
            // Drag.hotSpot.y: dragArea.height / 2

            MouseArea {
                id: dragArea
                anchors.fill: parent
                drag.target: parent

                onReleased: {
                    if (dropArea.containsMouse) {
                        // Snap to drop area
                        draggableTile.droppedOnTarget = true;
                        draggableTile.x = dropArea.x + (dropArea.width - draggableTile.width) / 2;
                        draggableTile.y = dropArea.y + (dropArea.height - draggableTile.height) / 2;
                    } else {
                        // Snap back to original position
                        draggableTile.droppedOnTarget = false;
                        draggableTile.x = originalPositions[index].x;
                        draggableTile.y = originalPositions[index].y;
                    }
                }
            }
        }
    }

    // Keyboard Navigation Logic
    Keys.onPressed: {
        if (event.key === Qt.Key_Left || event.key === Qt.Key_Right) {
            if (event.key === Qt.Key_Left) {
                selectedTileIndex = (selectedTileIndex - 1 + tileModel.count) % tileModel.count;
            } else if (event.key === Qt.Key_Right) {
                selectedTileIndex = (selectedTileIndex + 1) % tileModel.count;
            }
        }
    }
}
