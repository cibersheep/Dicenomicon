import QtQuick 2.4
import Ubuntu.Components 1.3
import U1db 1.0 as U1db
import Ubuntu.Components.Popups 1.0
import "../backend/scripts.js" as Cthulhu

//add dice page

Item{
    height:parent.height
    UbuntuListView {
        id:list
        model: dice.contents.type
        width:parent.width
        height:parent.height
        delegate: ListItem {
            divider.colorFrom : "transparent"
            Label {
                text:"D"+modelData.sides;
                //fontSize:"large";
                font.weight: Font.Light;
                color:"#8e8e8e"
                anchors {
                    left:parent.left
                    margins: units.gu(2)
                    verticalCenter: parent.verticalCenter
                }
            }
            Label {
                text:modelData.roll === 0 ? "" : modelData.roll;
                font.weight: Font.Light;
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }
            }
            Label {
                text:Cthulhu.diceName(modelData.sides);
                font.weight: Font.Light;
                color:"#8e8e8e"
                anchors {
                    right:parent.right
                    margins: units.gu(2)
                    verticalCenter: parent.verticalCenter
                }
            }
            leadingActions: ListItemActions {
                actions: [
                    Action {
                        iconName: "delete"
                        onTriggered:{
                            add.total = 0;
                            jumbo.visible = false;
                            add.dismissRoll(model.index);
                        }
                    }
                ]
            }
            onClicked: add.list(model.index);
        }
    }// end of listview
}
