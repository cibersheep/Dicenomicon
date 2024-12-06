import QtQuick 2.4
import Lomiri.Components 1.3

//this is for dice total number...The big number in the center

Item{
    height: units.gu(30)
    width: parent.width
    
    Item {
        id: back
        height: units.gu(26)
        width: height
        anchors.centerIn: parent
    
        Label {
            font.pixelSize: units.gu(14)
            text: add.total
            font.weight: Font.Light
            wrapMode: Text.WordWrap
            color: theme.palette.normal.baseText //"#e8e8e8"
            anchors.centerIn: parent
        }
    }
    
    MouseArea {
        anchors.fill: parent
        onClicked: add.roll();
    }
}



