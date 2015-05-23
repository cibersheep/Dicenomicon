import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.Popups 1.0
import Ubuntu.Components.Pickers 0.1
import U1db 1.0 as U1db
import "../components"

Component {
    id: dialogComponent
    Dialog {
        id: dialog
        title: "Add Dice"
            //content
            Picker {
                id:pick
                width:parent.width
                model: ["4", "6", "8", "10", "12", "20"]
                circular:false
                delegate: PickerDelegate {
                    Label {
                        anchors.centerIn: parent
                        text: modelData
                        color:"#8e8e8e"
                    }
                }
                selectedIndex: 0
                onSelectedIndexChanged: {
                    print(pick.model[pick.selectedIndex])
                }
            }
        Button {
            text: i18n.tr("Add")
            color: UbuntuColors.blue
            onClicked:{
                add.addRoll({"sides":parseInt(pick.model[pick.selectedIndex]),"roll":0});
                PopupUtils.close(dialog)
            }
        }
        Button {
            text: i18n.tr("Close")
            onClicked:{ PopupUtils.close(dialog) }
        }
    }
}
