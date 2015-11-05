import QtQuick 2.4
import Ubuntu.Components 1.2


Item{
    width:emptyCol.width
    height:units.gu(5)
    anchors.horizontalCenter: parent.horizontalCenter

    Column{
        id:emptyCol
        width:units.gu(20)
        height:parent.height//emptyImg.height + emptyText.height;
        anchors{
            horizontalCenter: parent.horizontalCenter
        }
        spacing:units.gu(1)

        Image{
            id:emptyImg
            width:units.gu(24)
            height:width
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter;
            source: Qt.resolvedUrl("../graphics/mad-squid.png")
        }

        Label{
            id:emptyText
            fontSize:"x-large"
            font.weight: Font.Light;
            color:"#8e8e8e"
            text: dice.contents.type.length === 0 ? "OMG NO DICE" : "GO ON HUMAN";
            anchors.horizontalCenter: parent.horizontalCenter;
        }
        Item{
            width:parent.width
            height:units.gu(5)
            Column{
                anchors.fill: parent
                spacing:units.gu(.5)

                Label{
                    id:emptyInstruction2
                    fontSize: "small"
                    color:"#8e8e8e"
                    text:dice.contents.type.length === 0 ?"Press the + Button to add dice" : "Click me or shake phone to roll dice"
                    anchors.horizontalCenter: parent.horizontalCenter;
                    horizontalAlignment: Text.AlignHCenter;
                }
            }
        }//end of text item
    }
}
