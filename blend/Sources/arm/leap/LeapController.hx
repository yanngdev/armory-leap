package arm.leap;

import arm.leap.LeapHuman;
import arm.leap.LeapData;
import arm.leap.LeapBone;
import arm.leap.LeapFinger;
import arm.leap.LeapPalm;
import arm.leap.LeapHand;
import arm.leap.LeapWrist;

class LeapController {
  public static var instance(default, null):LeapController = new LeapController();
  private var ws:LeapWS;
  public var hands:Array<LeapHand> = new Array();

  private function new() {
    ws = LeapWS.instance;

    armory.system.Event.add('onLeapMessage', function() {
      update();
    });

    for(type in Type.allEnums(LeapHumanHand)) {
      hands.push(new LeapHand(type));
    }
  }

  function update() {
    var data:LeapData = this.ws.data;

    if(data == null) {
      return;
    }

    for(hand in hands) {
      var handData = data.hands.filter(function(handData:LeapDataHand) return handData.type == LeapHuman.getHandString(hand.type));

      if(handData.length > 0) {
        var fingersData = data.pointables.filter(function(pointableData:LeapDataPointable) return pointableData.handId == hand.id);

        hand.update(handData[0], fingersData);
      }
    }

    armory.system.Event.send('onLeapUpdate');
  }

  public function getWrist(handType:LeapHumanHand):LeapWrist {
    var hand = getHand(handType);
    return hand != null ? hand.wrist : null;
  }

  public function getHand(handType:LeapHumanHand):LeapHand {  //
    var hand = hands.filter(function(hand:LeapHand) return hand.type == handType);
    return hand.length > 0 ? hand[0] : null;
  }

  public function getPalm(handType:LeapHumanHand):LeapPalm {
    var hand = getHand(handType);
    return hand != null ? hand.palm : null;
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