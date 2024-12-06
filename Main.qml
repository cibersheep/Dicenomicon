import QtQuick 2.9
import Lomiri.Components 1.3
import U1db 1.0 as U1db
import "components"
import Lomiri.Components.Popups 1.3
import "backend/scripts.js" as Cthulhu
import QtSensors 5.0
import Lomiri.Layouts 1.0

MainView {
    objectName: "mainView"
    applicationName: "dicenomicon.kevinfeyder"

    theme.name: "Ubuntu.Components.Themes.SuruDark"
    width: units.gu(45)
    height: units.gu(75)

    property bool portraitMode: width < height

    //--- database ---//
    U1db.Database {
        id: dicenomicon
        path: "dicenomicon.u1db"
    }

    U1db.Document {
        id: dice
        //stores todays expenes
        database: dicenomicon
        docId: "dice"
        create: true
        defaults: { "type":[] }
    }

    SensorGesture {
        id:shake
        enabled: dice.contents.type.length !== 0
        gestures: ["QtSensors.shake", "QtSensors.twist"]

        onDetected: {
            add.roll();
            jumbo.visible = true;
        }
    }

    Page {
        id: home
        anchors.fill: parent

        header: PageHeader {
            id: header
            title: i18n.tr("Dicenomicon")

            trailingActionBar {
                actions:[
                    Action {
                        id: save
                        iconName: "add"
                        onTriggered: PopupUtils.open(dialog)
                    }
                ]
            }
        }

        AddComponent {
            id: dialog
        }

        Flow {
            objectName: "layouts"
            id: layouts
            
            anchors {
                bottom: parent.bottom
                top: header.bottom
                left: parent.left
                right: parent.right
            }

            Item {
                id: redButton
                objectName: "water"
                opacity: 0

                width: portraitMode ? parent.width : parent.width * 0.4
                height: portraitMode ? units.gu(30) : parent.height


                //start up animation
                Component.onCompleted: {
                    opacity = 1 //begins start animation
                }

                Behavior on opacity { NumberAnimation { easing.type:Easing.InOutBounce; duration: 2000} }

                SetComponent {
                    id: jumbo
                    //big number in the center
                    Behavior on opacity { NumberAnimation { easing.type: Easing.OutBack; duration: 1000} }
                    visible: add.total !== 0
                    opacity: visible
                    width: parent.width / 2
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                EmptyComponent {
                    //cute cthulhu
                    width: parent.width / 2
                    Behavior on opacity { NumberAnimation { easing.type: Easing.OutBack; duration: 1000} }
                    visible: !jumbo.visible
                    opacity: visible
                    anchors {
                        top: parent.top
                        topMargin: units.gu(2)
                    }
                }
            }

            SettingsComponent {
                id: greenButton
                objectName: "history"

                width: portraitMode ? parent.width : parent.width - redButton.width
                height: portraitMode ? parent.height - redButton.height : parent.height
            }
        }
    }

    Item {
        id: add
        property int total: 0

        function totalClear(){
            add.total = 0;
        }

        function dismissRoll(index) {
            var tempContents = {};
            tempContents = dice.contents;
            //var index = tempContents.players.indexOf(index);
            tempContents.type.splice((index),1);
            dice.contents = tempContents;
        }

        function addRoll(playerObject) {
            var tempContents = {};
            tempContents = dice.contents;
            if (tempContents.type.indexOf(playerObject) != -1) throw "Already exists";
            tempContents.type.push(playerObject);
            dice.contents = tempContents;
        }

        function deleteRoll() {
            var tempContents = {};
            tempContents = dice.contents;
            var index = tempContents.type.indexOf();
            tempContents.type.splice(0, dice.contents.type.length);
            dice.contents = tempContents;
        }

        function roll(){
            var sum = 0;
            add.totalClear();

            for(x = 0; x < dice.contents.type.length; x++) {
                add.replaceDice(x,{"sides":dice.contents.type[0].sides},{"sides":dice.contents.type[x].sides, "roll":Cthulhu.roll(dice.contents.type[x].sides)});
                add.total = add.total + dice.contents.type[x].roll;
            }
        }

        function list(index){
            var sum = 0;
            add.totalClear();
            add.replaceDice(index,{"sides":dice.contents.type[0].sides},{"sides":dice.contents.type[index].sides, "roll":Cthulhu.roll(dice.contents.type[index].sides)});

            for(x = 0; x < dice.contents.type.length; x++) {
                add.total = add.total + dice.contents.type[x].roll;
                print("total " + add.total);
            }
        }

        function replaceDice(index,oldDice, newDice) {
            var tempContents = {};
            tempContents = dice.contents;
            tempContents.type.splice(index, 1, newDice);
            dice.contents = tempContents;
        }
    }
}

