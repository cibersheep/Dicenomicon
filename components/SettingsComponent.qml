import QtQuick 2.9
import Lomiri.Components 1.3
import "../backend/scripts.js" as Cthulhu

Item {
    height: parent.height

    LomiriListView {
        id: list
        model: dice.contents.type
        width: parent.width
        height: parent.height
        clip: true
        delegate: ListItem {
            divider.visible: false
            height: layout.height + (divider.visible ? divider.height : 0)
            
			ListItemLayout {
				id: layout
				title.text: "D%1".arg(modelData.sides)
				subtitle.text: Cthulhu.diceName(modelData.sides)

				Image {
		            id: wrapperimg
		            height: units.gu(2)
		            width: height
		            source: Qt.resolvedUrl("../graphics/%1.svg".arg(Cthulhu.diceImage(modelData.sides)))
		            smooth: true

		            SlotsLayout.position: SlotsLayout.Leading
		            SlotsLayout.overrideVerticalPositioning: true
		            anchors.verticalCenter: parent.verticalCenter
		        }
		        
		        Label {
			        height: units.gu(4)
		            text: modelData.roll === 0 ? "-" : modelData.roll
		            SlotsLayout.position: SlotsLayout.Trailing
		            textSize: Label.XLarge
		        }
			}
			
            leadingActions: ListItemActions {
                actions: [
                    Action {
                        iconName: "delete"
                        onTriggered: {
                            add.total = 0;
                            jumbo.visible = false;
                            add.dismissRoll(model.index);
                        }
                    }
                ]
            }

            onClicked: add.list(model.index);
        }
    }
}
