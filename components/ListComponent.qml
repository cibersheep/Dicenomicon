import QtQuick 2.4
import Ubuntu.Components 1.2
import "../backend/scripts.js" as Logic
import "../components"


Item {
    anchors.horizontalCenter: parent.horizontalCenter
    height:list.height

    ListView {
        id:list
        anchors.fill: parent
        contentX: parent.width / 2
        orientation: ListView.Horizontal
        model: dice.contents.type
        spacing:units.gu(8)
        snapMode:ListView.SnapOneItem
        preferredHighlightBegin: units.gu(5)
        preferredHighlightEnd: units.gu(5)
        delegate: Item{
            id:wrapper
            height:units.gu(10)
            width:units.gu(3)
            anchors.verticalCenter: parent.verticalCenter
            Column{
                spacing:units.gu(2)
                anchors.centerIn: parent
                Image{
                    id:wrapperimg
                    height:rollLabel.height*1.2
                    width: height
                    source: Qt.resolvedUrl("../graphics/" + Logic.diceImage(modelData.sides) + ".svg")
                    smooth: true
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Label{
                    id:rollLabel
                    text:modelData.roll === 0 ? "" : modelData.roll;
                    color:"#8e8e8e"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    add.list(model.index);
                }
            }
            Behavior on focus  {
                SequentialAnimation{
                    running:true
                    NumberAnimation { target: col; property: opacity; to: 0; easing.type:Easing.InOutBounce; duration: 2000}
                    NumberAnimation { target: col; property: opacity; to: 1; easing.type:Easing.InOutBounce; duration: 2000}
                }
            }
        }
        highlightRangeMode: ListView.StrictlyEnforceRange
        focus: true;
        Component.onCompleted: {positionViewAtIndex(1, ListView.Center)}
    }

}
