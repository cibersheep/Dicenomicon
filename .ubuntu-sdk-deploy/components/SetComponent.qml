import QtQuick 2.4
import Ubuntu.Components 1.3
import U1db 1.0 as U1db
import "../backend/scripts.js" as Logic

//this is for dice total number...The big number in the center

Item{
    height:units.gu(21)
    width: parent.width
    Item{
        id:back
        height:units.gu(30)
        width:height
        anchors.centerIn:parent
        Label {
            font.pixelSize: units.gu(16)
            text:add.total;
            font.weight:Font.Light
            wrapMode: Text.WordWrap
            color:"#e8e8e8"
            anchors.centerIn: parent
        }
    }//end of back
    MouseArea{
        anchors.fill: parent
        onClicked: add.roll();
    }


}



