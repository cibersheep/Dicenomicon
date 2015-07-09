import QtQuick 2.4
import Ubuntu.Components 1.2
import "../backend/scripts.js" as Cthulhu

//custom header


Item{
    Item {
        id:diyHeader
        anchors.centerIn: parent
        height:diyTitle.height // set in main.qml
        width:parent.width
        Label { //title for app
            id:diyTitle
            fontSize:"x-large"
            font.weight: Font.Light;
            anchors.centerIn: parent;
            text: "Dicenomicon"
            color:"#8e8e8e"
        }
    }
}
