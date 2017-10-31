package arm.leap;

#if (js && kha_webgl)
import js.html.WebSocket;
#end

import arm.leap.LeapData;

class LeapWS {
  #if (js && kha_webgl)
  public static var instance(default, null):LeapWS = new LeapWS();
  public var data:LeapData;
  var leapmotion_ws = 'ws://127.0.0.1:6437/v6.json';
  var websocket:WebSocket;
  
	private function new() {
		this.websocket = new WebSocket(this.leapmotion_ws);
  
		this.websocket.onopen = function() {
			trace('Leap Motion Socket client open');

      this.websocket.send(haxe.Json.stringify({'background': true}));
		}
  
    this.websocket.onmessage = function(event:Dynamic) {
      var leapData = haxe.Json.parse(event.data);
  
      if(leapData.id != null) {
        this.data = leapData;
      } else {
        trace('Leap Motion Socket client message', leapData);
      }
  
      if(leapData.id != null && leapData.hands != null && leapData.hands.length > 0) {
        armory.system.Event.send('onLeapMessage');
      }
    };
  
    this.websocket.onclose = function(event:Dynamic) {
      trace('Leap Motion Socket client closed');
    }
	}
  #end
}
