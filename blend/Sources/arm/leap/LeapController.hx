package arm.leap;

import arm.leap.LeapHuman;
import arm.leap.LeapData;
import arm.leap.LeapBone;
import arm.leap.LeapFinger;
import arm.leap.LeapHand;
import arm.leap.LeapWrist;

class LeapController {
  public static var instance(default, null):LeapController = new LeapController();
  #if (js && kha_webgl)
  private var ws:LeapWS;
  #end
  var previousData:LeapData;
  public var hands:Array<LeapHand> = new Array();

  private function new() {
    #if (js && kha_webgl)
    ws = LeapWS.instance;
    #end

    armory.system.Event.add('onLeapMessage', function() {
      update();
    });

    for(type in Type.allEnums(LeapHumanHand)) {
      hands.push(new LeapHand(type));
    }
  }

  public function update(data:LeapData = null) {
    #if (js && kha_webgl)
    if(data == null) {
      data = this.ws.data;
    }
    #end

    if(data == null || (previousData != null && data.id == previousData.id)) {
      return;
    }

    for(hand in hands) {
      var handData:Array<LeapDataHand> = data.hands.filter(function(handData:LeapDataHand) return handData.type == LeapHuman.getHandString(hand.type));

      if(handData.length > 0) {
        var fingersData:Array<LeapDataPointable> = data.pointables.filter(function(pointableData:LeapDataPointable) return pointableData.handId == handData[0].id);

        hand.update(handData[0], fingersData);
      }
    }

    previousData = data;

    armory.system.Event.send('onLeapUpdate');
  }

  public function getWrist(handType:LeapHumanHand):LeapWrist {
    var hand = getHand(handType);
    return hand != null ? hand.wrist : null;
  }

  public function getHand(handType:LeapHumanHand):LeapHand {
    var hand = hands.filter(function(hand:LeapHand) return hand.type == handType);
    return hand.length > 0 ? hand[0] : null;
  }

  public function getFinger(handType:LeapHumanHand, fingerType:LeapHumanFinger):LeapFinger {
    var hand = getHand(handType);
    return hand != null ? hand.getFinger(fingerType) : null;
  }

  public function getBone(handType:LeapHumanHand, fingerType:LeapHumanFinger, boneType:LeapHumanBone):LeapBone {
    var finger = getFinger(handType, fingerType);
    return finger != null ? finger.getBone(boneType) : null;
  }
}
