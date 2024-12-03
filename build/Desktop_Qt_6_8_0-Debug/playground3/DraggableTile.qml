// DraggableTile.qml
import QtQuick 2.15

Rectangle {
    property int index
    property string label
    property real originalX
    property real originalY
    property bool droppedOnTarget: false // Tracks if the tile is on the drop area
    property int selectTileIndex

    width: 100
    height: 100
    color:index===selectTileIndex? "orange":"green"
    border.color: "#aa5500"
    border.width: 2
    radius: 10

    Text {
        anchors.centerIn: parent
        text: label
        color: "black"
        font.pixelSize: 20
    }

    Drag.active: dragArea.drag.active
    Drag.hotSpot.x: dragArea.width / 2
    Drag.hotSpot.y: dragArea.height / 2

    MouseArea {
        id: dragArea
        anchors.fill: parent
        drag.target: parent

        onReleased: {
            if (!parent.droppedOnTarget) {
                // If not dropped on target, reset to original position
                parent.x = parent.originalX;
                parent.y = parent.originalY;
            }
        }
    }

}
