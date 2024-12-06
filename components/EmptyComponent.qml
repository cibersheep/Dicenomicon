import QtQuick 2.9
import Lomiri.Components 1.3


Item {
    width: parent.width
    height: emptyCol.height - units.gu(2)
    anchors.horizontalCenter: parent.horizontalCenter

    Column {
        id: emptyCol
        width: parent.width
        height: emptyImg.height + emptyText.height - emptyInstruction2.height - units.gu(2)
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: units.gu(1)

        Image {
            id: emptyImg
            height: units.gu(16)
            width: height
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter;
            source: Qt.resolvedUrl("../graphics/cthulhu.png")
            
            MouseArea {
                anchors.fill: parent
                
                onClicked: {
                    add.roll();
                    jumbo.visible = true;
                }
            }
        }

        Label {
            id: emptyText
            height: units.gu(4)
            fontSize: "x-large"
            font.weight: Font.Light;
            color: "#8e8e8e"
            text: dice.contents.type.length === 0 
            	? i18n.tr("OMG NO DICE") 
            	: i18n.tr("GO ON HUMAN");
            anchors.horizontalCenter: parent.horizontalCenter;
        }

        Label {
            id: emptyInstruction2
            height: units.gu(3)
            fontSize: "small"
            color: "#8e8e8e"
            text: dice.contents.type.length === 0 
            	? i18n.tr("Press the + Button to add dice") 
            	: i18n.tr("Click me or shake phone to roll dice")
            anchors.horizontalCenter: parent.horizontalCenter;
            horizontalAlignment: Text.AlignHCenter;
        }
    }
}
