import QtQuick 2.4
import Ubuntu.Components 1.2
import U1db 1.0 as U1db
import Ubuntu.Components.Popups 1.0
import "../backend/scripts.js" as Cthulhu

//add dice page

Item{
    Column{
        height:parent.height
        width:parent.width
        spacing:units.gu(3)
        clip:true
        Flickable{
            height:parent.height
            width:parent.width
            contentHeight: parent.height + units.gu(5)
            //contents
            ListView {
                id:list
                model: dice.contents.type
                width:parent.width
                height:units.gu(40)
                delegate: ListItem {
                    divider.colorFrom : "transparent"
                    Label {
                        text:Cthulhu.diceName(modelData.sides);
                        fontSize: "large";
                        font.weight: Font.Light;
                        anchors {
                            left:parent.left
                            margins: units.gu(4)
                            verticalCenter: parent.verticalCenter
                        }
                    }
                    Label {
                        text:"D"+modelData.sides;
                        fontSize:"large";
                        font.weight: Font.Light;
                        anchors {
                            right:parent.right
                            margins: units.gu(4)
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
                    onClicked: console.log("click")
                }
            }// end of listview

        }
    }
}
