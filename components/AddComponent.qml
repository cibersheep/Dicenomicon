import QtQuick 2.9
import Lomiri.Components 1.3
import Lomiri.Components.Popups 1.3
import Lomiri.Components.Pickers 1.3
import "../components"

Component {
    id: dialogComponent

    Dialog {
        id: dialog
        title: i18n.tr("Add Dice")

        //content
        Picker {
            id:pick
            width:parent.width
            model: ["2","4", "6", "8", "10", "12", "20","100"]
            //circular:false

            delegate: PickerDelegate {
                Label {
                    anchors.centerIn: parent
                    text: modelData
                    color: theme.palette.normal.baseText //"#8e8e8e"
                }
            }
            
            selectedIndex: 0
            
            onSelectedIndexChanged: {
                print(pick.model[pick.selectedIndex])
            }
        }

        Button {
            text: i18n.tr("Add")
            color: theme.palette.normal.positive //"#CC7691"

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
