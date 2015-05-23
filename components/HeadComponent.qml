import QtQuick 2.0
import Ubuntu.Components 1.1
import "../backend/scripts.js" as Cthulhu




Item{

    Item { // container for the custom header include settings, title and add
        id:diyHeader
        anchors.centerIn: parent
        height:diyTitle.height // set in main.qml
        width:parent.width
        Label { //calorie title for app
            id:diyTitle
            fontSize:"x-large"
            font.weight: Font.Light;
            anchors.centerIn: parent;
            text: "Dicenomicon"
            //color:"#5f5f5f"
            color:"#8e8e8e"
        }
    }

}
