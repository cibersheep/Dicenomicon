import QtQuick 2.0
import U1db 1.0 as U1db
import Ubuntu.Components 1.1
import Ubuntu.Components.ListItems 1.0 as ListItem
import Ubuntu.Components.Popups 1.0
import "../backend/scripts.js" as Cthulhu

//dice page

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
                delegate: ListItem.SingleValue {
                    removable: true
                    confirmRemoval: true
                    onItemRemoved: {
                        add.total = 0;
                        jumbo.visible = false;
                        add.dismissRoll(model.index);
                        //jumbo.visible = false;
                        console.log(add.total)
                    }
                    showDivider: false
                    text: Cthulhu.diceName(modelData.sides);
                    value:"D"+modelData.sides;

                }
            }// end of listview

        }
    }
}
