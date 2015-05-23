import QtQuick 2.0
import Ubuntu.Components 1.1
import U1db 1.0 as U1db
import "components"
import Ubuntu.Components.Popups 0.1
import "backend/scripts.js" as Cthulhu
import QtSensors 5.0
/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "dicenomicon.kevinfeyder"
    useDeprecatedToolbar: false
    backgroundColor: "#1f1f1f"
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
                print("total " + add.total);
                //add.totalRoll(dice.contents.type[x].side, add.total);
            }
        }
        function list(index){
            var sum = 0;
            add.totalClear();
            add.replaceDice(index,{"sides":dice.contents.type[0].sides},{"sides":dice.contents.type[index].sides, "roll":Cthulhu.roll(dice.contents.type[index].sides)});
            for(x = 0; x < dice.contents.type.length; x++){

                add.total = add.total + dice.contents.type[x].roll;
                print("total " + add.total);
                //add.totalRoll(dice.contents.type[x].side, add.total);
            }
        }
        function replaceDice(index,oldDice, newDice) {
            var tempContents = {};
            tempContents = dice.contents;
            //var index = tempContents.players.indexOf(oldPlayer);
            tempContents.type.splice(index, 1, newDice);
            dice.contents = tempContents;
            }

    }
    PageStack {
        id:stack
        Component.onCompleted: {
            stack.push(home);
            col.opacity = 1;//begins start animation
        }
    }

    PageWithBottomEdge {
        id:home
        //title: i18n.tr("dicenomicon")
        // bottom edge page code
        bottomEdgeTitle: i18n.tr("Dice")
        bottomEdgePageComponent:Page{
            head.actions:[
                Action {
                id:del
                iconName: "delete"
                onTriggered:{
                    add.deleteRoll();
                    add.total = 0;
                    jumbo.visible = false;
                    }
                },
                Action {
                id:save
                iconName: "add"
                onTriggered:{ PopupUtils.open(dialog) }
                }
            ]
            id:details
            title: i18n.tr("Dice")
            SettingsComponent{
                width:parent.width
                height:parent.height
            }
            AddComponent{
                id:dialog
            }
        } // end of bottomedge

        Column {
            id:col
            spacing:units.gu(3);
            width:parent.width
            height:parent.height
            opacity:0
            //start up animation
            Behavior on opacity{ NumberAnimation { easing.type:Easing.InOutBounce; duration: 2000} }
            anchors {
                margins: units.gu(2)
                fill: parent
            }

            HeadComponent{
                //app logo
                width:parent.width
                height:units.gu(5)
            }
            SetComponent{
                id:jumbo
                //big number in the center
                Behavior on opacity { NumberAnimation { easing.type: Easing.OutBack; duration: 1000} }
                visible: add.total != 0 ? true : false;
                opacity: visible//add.total != 0 ? 1 : 0;
                height:units.gu(32)
            }
            EmptyComponent{
                //cute cthulhu
                height:units.gu(32)
                Behavior on opacity { NumberAnimation { easing.type: Easing.OutBack; duration: 1000} }
                visible: add.total === 0 ? true : false;
                opacity: visible;
            }

            ListComponent{
                //current dice
                height:units.gu(7)
                width:parent.width
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
}

