// Create WebSocket connection.
//const socket = new WebSocket('ws://192.168.1.10:8080/trigger');
//https://testwebsocketconection.herokuapp.com/
//const socket = new WebSocket('ws://testwebsocketconection.herokuapp.com/trigger');
const socket = new WebSocket("ws://android:password@192.168.1.5:8080/connect");
// living room
var isLed1On = false;
var isLed2On = false;
var isLed3On = false;
var isLed4On = false;
//bed room
var isLed5On = false;
var isLed6On = false;
var isLed7On = false;

//garage
var doorOpend = false;
// Connection opened
socket.addEventListener("open", function (event) {
  //socket.send('Hello Server!');
  console.log("connected");
});
socket.onclose = function (e) {
  console.log("disconnected, error code: " + e.code);
};
socket.onerror = function (e) {
  Console.log("WebSocket error: " + e.code);
  console.log(e);
};

// Listen for messages
//led1:0
//led2:1
socket.addEventListener("message", function (event) {
  console.log("Message from server ", event.data);
  let s = String(event.data);
  let split = s.split(":");
  let index = s.indexOf(":");
  let led = split[0] + split[1];
  let status = split[2];
  console.log(led + "   :  " + status);
  switch (led) {
    case "livingRoomlamp1":
      if (status == "0") {
        document.querySelector("#led1").innerHTML = "led1 is off";
        isLed1On = false;
      } else {
        document.querySelector("#led1").innerHTML = "led1 is on";

        isLed1On = true;
      }
      break;
    case "livingRoomlamp2":
      if (status == "0") {
        document.querySelector("#led2").innerHTML = "led2 is off";
        isLed2On = false;
      } else {
        document.querySelector("#led2").innerHTML = "led2 is on";
        isLed2On = true;
      }
      break;
    case "livingRoomlamp3":
      if (status == "0") {
        document.querySelector("#led3").innerHTML = "led3 is off";
        isLed3On = false;
      } else {
        document.querySelector("#led3").innerHTML = "led3 is on";

        isLed3On = true;
      }
      break;
    case "livingRoomlamp4":
      if (status == "0") {
        document.querySelector("#led4").innerHTML = "led4 is off";
        isLed4On = false;
      } else {
        document.querySelector("#led4").innerHTML = "led4 is on";
        isLed4On = true;
      }
      break;
    case "bedRoomlamp1":
      if (status == "0") {
        document.querySelector("#led5").innerHTML = "led5 is off";
        isLed5On = false;
      } else {
        document.querySelector("#led5").innerHTML = "led5 is on";
        isLed5On = true;
      }
      break;
    case "bedRoomlamp2":
      if (status == "0") {
        document.querySelector("#led6").innerHTML = "led6 is off";
        isLed6On = false;
      } else {
        document.querySelector("#led6").innerHTML = "led6 is on";

        isLed6On = true;
      }
      break;
    case "bedRoomlamp3":
      if (status == "0") {
        document.querySelector("#led7").innerHTML = "led7 is off";
        isLed7On = false;
      } else {
        document.querySelector("#led7").innerHTML = "led7 is on";
        isLed7On = true;
      }
      break;
    case "garagedoor":
      if (status == "0") {
        document.querySelector("#door").innerHTML = "door is closed";
        doorOpend = false;
      } else {
        document.querySelector("#door").innerHTML = "door is opened";
        doorOpend = true;
      }
      break;
  }
});

function triggerLivingRoom(led) {
  switch (led) {
    case 1:
      if (isLed1On) {
        socket.send("livingRoom:lamp1:0");
        // console.log("on");
        isLed1On = false;
        document.querySelector("#led1").innerHTML = "led1 is off";
      } else {
        socket.send("livingRoom:lamp1:1");
        //console.log("off");
        isLed1On = true;
        document.querySelector("#led1").innerHTML = "led1 is on";
      }
      break;
    case 2:
      if (isLed2On) {
        socket.send("livingRoom:lamp2:0");
        // console.log("on");
        isLed2On = false;
        document.querySelector("#led2").innerHTML = "led2 is off";
      } else {
        socket.send("livingRoom:lamp2:1");
        //console.log("off");
        isLed2On = true;
        document.querySelector("#led2").innerHTML = "led2 is on";
      }
      break;
    case 3:
      if (isLed3On) {
        socket.send("livingRoom:lamp3:0");
        // console.log("on");
        isLed3On = false;
        document.querySelector("#led3").innerHTML = "led3 is off";
      } else {
        socket.send("livingRoom:lamp3:1");
        //console.log("off");
        isLed3On = true;
        document.querySelector("#led3").innerHTML = "led3 is on";
      }
      break;
    case 4:
      if (isLed4On) {
        socket.send("livingRoom:lamp4:0");
        // console.log("on");
        isLed4On = false;
        document.querySelector("#led4").innerHTML = "led4 is off";
      } else {
        socket.send("livingRoom:lamp4:1");
        //console.log("off");
        isLed4On = true;
        document.querySelector("#led4").innerHTML = "led4 is on";
      }
      break;
  }
}
function triggerBedRoom(led) {
  switch (led) {
    case 1:
      if (isLed5On) {
        socket.send("bedRoom:lamp1:0");
        // console.log("on");
        isLed5On = false;
        document.querySelector("#led5").innerHTML = "led5 is off";
      } else {
        socket.send("bedRoom:lamp1:1");
        //console.log("off");
        isLed5On = true;
        document.querySelector("#led5").innerHTML = "led5 is on";
      }
      break;
    case 2:
      if (isLed6On) {
        socket.send("bedRoom:lamp2:0");
        // console.log("on");
        isLed6On = false;
        document.querySelector("#led6").innerHTML = "led6 is off";
      } else {
        socket.send("bedRoom:lamp2:1");
        //console.log("off");
        isLed6On = true;
        document.querySelector("#led6").innerHTML = "led6 is on";
      }
      break;
    case 3:
      if (isLed7On) {
        socket.send("bedRoom:lamp3:0");
        // console.log("on");
        isLed7On = false;
        document.querySelector("#led7").innerHTML = "led7 is off";
      } else {
        socket.send("bedRoom:lamp3:1");
        //console.log("off");
        isLed7On = true;
        document.querySelector("#led7").innerHTML = "led7 is on";
      }
      break;
  }
}

function triggerGarageDoor() {
  if (doorOpend) {
    socket.send("garage:door:0");
    // console.log("on");
    doorOpend = false;
    document.querySelector("#door").innerHTML = "door is closed";
  } else {
    socket.send("garage:door:1");
    //console.log("off");
    doorOpend = true;
    document.querySelector("#door").innerHTML = "door is opened";
  }
}
