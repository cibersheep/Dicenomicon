import QtQuick 2.4
import Ubuntu.Components 1.3
import U1db 1.0 as U1db
import "components"
import Ubuntu.Components.Popups 1.0
import "backend/scripts.js" as Cthulhu
import QtSensors 5.0
import Ubuntu.Layouts 0.1
MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "dicenomicon.kevinfeyder"
    //backgroundColor: "#1f1f1f"
    theme.name: "Ubuntu.Components.Themes.SuruDark"
    width: units.gu(45)
    height: units.gu(75)

    //--- database ---//
    U1db.Database {
        id:dicenomicon;
        path: "dicenomicon.u1db"
    }
    U1db.Document {
        id: dice
        //stores todays expenes
        database: dicenomicon
        docId: "dice"
        create: true
        defaults: {"type":[]}
    }

    SensorGesture{
        id:shake
        enabled: dice.contents.type.length === 0 ? false : true;
        gestures : ["QtSensors.shake", "QtSensors.twist"]
        onDetected: {
            add.roll();
            jumbo.visible = true;
        }
    }


    Item{
        id:add
        property int total: 0;

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
            for(x = 0; x < dice.contents.type.length; x++){
                add.replaceDice(x,{"sides":dice.contents.type[0].sides},{"sides":dice.contents.type[x].sides, "roll":Cthulhu.roll(dice.contents.type[x].sides)});
                add.total = add.total + dice.contents.type[x].roll;
            }
        }
        function list(index){
            var sum = 0;
            add.totalClear();
            add.replaceDice(index,{"sides":dice.contents.type[0].sides},{"sides":dice.contents.type[index].sides, "roll":Cthulhu.roll(dice.contents.type[index].sides)});
            for(x = 0; x < dice.contents.type.length; x++){

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

    Page {
        id:home
        title: i18n.tr("Dicenomicon")
        head.actions:[
            Action {
                id:save
                iconName: "add"
                onTriggered:{ PopupUtils.open(dialog) }
            }

        ]
        AddComponent{
            id:dialog
        }

        Layouts {
            objectName: "layouts"
            id: layouts
            anchors.fill: parent
            layouts: [
                ConditionalLayout {
                    //phone layout
                    name: "phone"
                    when: layouts.width < units.gu(50)
                    Row {
                        anchors.fill: parent
                        ItemLayout {
                            item: "water"
                            width: parent.width
                            anchors {
                                top: parent.top
                                bottom: parent.bottom
                            }
                        }
                        ItemLayout {
                            item: "history"
                            width:0
                            anchors {
                                top: parent.top
                                bottom: parent.bottom
                            }
                        }
                    }
                },
                ConditionalLayout {
                    //end of tablet layout
                    name: "tablet"
                    when: layouts.width > units.gu(60)
                    Row {
                        anchors.fill: parent
                        ItemLayout {
                            item: "water"
                            width: parent.width / 2
                            anchors {
                                top: parent.top
                                bottom: parent.bottom
                            }
                        }
                        ItemLayout {
                            item: "history"
                            width: parent.width / 2
                            anchors {
                                top: parent.top
                                bottom: parent.bottom
                            }
                        }
                    }
                }
            ]//end of layouts
            Item {
                id: redButton
                width: parent.width
                Layouts.item: "water"
                anchors {
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                }
                Column {
                    id:col
                    spacing:units.gu(5);
                    width:parent.width
                    height:parent.height
                    opacity:0
                    //start up animation
                    Component.onCompleted: {
                        col.opacity = 1;//begins start animation
                    }
                    Behavior on opacity{ NumberAnimation { easing.type:Easing.InOutBounce; duration: 2000} }
                    anchors {
                        margins: units.gu(2)
                        fill: parent
                    }
                    SetComponent{
                        id:jumbo
                        //big number in the center
                        Behavior on opacity { NumberAnimation { easing.type: Easing.OutBack; duration: 1000} }
                        visible: add.total != 0 ? true : false;
                        opacity: visible
                        height:units.gu(32)
                    }
                    EmptyComponent{
                        //cute cthulhu
                        height:units.gu(32)
                        Behavior on opacity { NumberAnimation { easing.type: Easing.OutBack; duration: 1000} }
                        visible: add.total === 0 ? true : false;
                        opacity: visible;
                    }
                    SettingsComponent {
                        width:parent.width
                        height: parent.height/2
                        visible: greenButton.width > 0? false:true;
                    }

                    Item{
                        width:parent.width
                        height:units.gu(5)
                        Label{
                            text:"ROLL DICE"
                            color:"#8e8e8e"
                            visible:dice.contents.type.length === 0 ? false : true;
                            fontSize:"large"
                            font.weight: Font.Light;
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                add.roll();
                                jumbo.visible = true;
                            }
                        }
                    }

                }

            }
            Item{
                id:greenButton
                Layouts.item: "history"
                anchors {
                    top: parent.top
                    left: redButton.right
                    right: parent.right
                }
                Column {
                    id:col2
                    spacing:units.gu(5);
                    anchors {
                        fill:parent;
                        margins: units.gu(5)
                    }
                    opacity:greenButton.width > 0? 1:0;

                    SettingsComponent {
                        width:parent.width
                        height: parent.height+units.gu(5)
                    }
                }
            }//end of greenButton
        }
    }//page

}

