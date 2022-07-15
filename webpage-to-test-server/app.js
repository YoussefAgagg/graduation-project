// Create WebSocket connection.
//const socket = new WebSocket('ws://192.168.1.10:8080/trigger');
//https://testwebsocketconection.herokuapp.com/
//const socket = new WebSocket('ws://testwebsocketconection.herokuapp.com/trigger');
const socket = new WebSocket('ws://android:password@192.168.1.5:8080/connect');

var isLed1On=false;
var isLed2On=false;
var isLed3On=false;
var isLed4On=false;

// Connection opened
socket.addEventListener('open', function (event) {
    //socket.send('Hello Server!');
});

// Listen for messages
//led1:0
//led2:1
socket.addEventListener('message', function (event) {
    console.log('Message from server ', event.data);
    let s=String(event.data);
    let split=s.split(":");
    let index=s.indexOf(":");
    let led=split[0]+"L"+split[1].substring(1);
    let status=split[2];
    console.log(led+"   :  "+status);
    switch(led){
        case "livingRoomLamp1":
            if(status=="0"){
                document.querySelector('#led1').innerHTML = 'led1 is off';
                isLed1On=false;
            }else {
                document.querySelector('#led1').innerHTML = 'led1 is on';

                isLed1On=true;
            }
        break;
        case "livingRoomLamp2": 
        if(status=="0"){
            document.querySelector('#led2').innerHTML = 'led2 is off';
            isLed2On=false;
        }else {
            document.querySelector('#led2').innerHTML = 'led2 is on';
            isLed2On=true;
        }
        break;
        case "livingRoomLamp3":
            if(status=="0"){
                document.querySelector('#led3').innerHTML = 'led3 is off';
                isLed3On=false;
            }else {
                document.querySelector('#led3').innerHTML = 'led3 is on';

                isLed3On=true;
            }
        break;
        case "livingRoomLamp4": 
        if(status=="0"){
            document.querySelector('#led4').innerHTML = 'led4 is off';
            isLed4On=false;
        }else {
            document.querySelector('#led4').innerHTML = 'led4 is on';
            isLed4On=true;
        }
        break;
    }
    
    // if(String(event.data)=="on"){
    //     console.log("on");
    //     document.querySelector('#button').innerHTML = 'off'
    // }else {
    //     console.log("off");
    //     document.querySelector('#button').innerHTML = 'on'
    // }
});

function trigger(led){
    switch(led){
        case 1:
            if(isLed1On){
                socket.send("livingRoom:lamp1:0");
               // console.log("on");
               isLed1On=false;
               document.querySelector('#led1').innerHTML = 'led1 is off';
            }else {
                socket.send("livingRoom:lamp1:1");
                //console.log("off");
                isLed1On=true;
                document.querySelector('#led1').innerHTML = 'led1 is on';
            }
        break;
        case 2: 
        if(isLed2On){
            socket.send("livingRoom:lamp2:0");
           // console.log("on");
           isLed2On=false;
           document.querySelector('#led2').innerHTML = 'led2 is off';
        }else {
            socket.send("livingRoom:lamp2:1");
            //console.log("off");
            isLed2On=true;
            document.querySelector('#led2').innerHTML = 'led2 is on';
        }
        break;
        case 3:
            if(isLed3On){
                socket.send("livingRoom:lamp3:0");
               // console.log("on");
               isLed3On=false;
               document.querySelector('#led3').innerHTML = 'led3 is off';
            }else {
                socket.send("livingRoom:lamp3:1");
                //console.log("off");
                isLed3On=true;
                document.querySelector('#led3').innerHTML = 'led3 is on';
            }
        break;
        case 4: 
        if(isLed4On){
            socket.send("livingRoom:lamp4:0");
           // console.log("on");
           isLed4On=false;
           document.querySelector('#led4').innerHTML = 'led4 is off';
        }else {
            socket.send("livingRoom:lamp4:1");
            //console.log("off");
            isLed4On=true;
            document.querySelector('#led4').innerHTML = 'led4 is on';
        }
        break;
    }

    
}