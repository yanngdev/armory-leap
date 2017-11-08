package arm.leap;

import arm.leap.LeapHuman;
import arm.leap.LeapData;
import arm.leap.LeapBone;
import arm.leap.LeapFinger;
import arm.leap.LeapHand;
import arm.leap.LeapWrist;
import arm.leap.LeapArm;
import arm.leap.LeapElbow;

class LeapController {
  public static var instance(default, null):LeapController = new LeapController();
  #if (js && kha_webgl)
  private var ws:LeapWS;
  #end
  public var hands:Array<LeapHand> = new Array();
  public var data:LeapData;

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

  public function update(leapData:LeapData = null) {
    #if (js && kha_webgl)
    data = leapData == null ? this.ws.data : leapData;
    #end

    if(data == null) {
      return;
    }

    for(hand in hands) {
      var handData = getDataHand(hand.type);

      if(handData != null) {
        var fingersData:Array<LeapDataPointable> = data.pointables.filter(function(pointableData:LeapDataPointable) return pointableData.handId == handData.id);

        hand.update(handData, fingersData);
      }
    }

    armory.system.Event.send('onLeapUpdate');
  }

  public function getElbow(handType:LeapHumanHand):LeapElbow {
    var arm = getArm(handType);
    return arm != null ? arm.elbow : null;
  }

  public function getArm(handType:LeapHumanHand):LeapArm {
    var hand = getHand(handType);
    return hand != null ? hand.arm : null;
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

  public function getDataHand(handType:LeapHumanHand):LeapDataHand {
    var handData:Array<LeapDataHand> = data.hands.filter(function(handData:LeapDataHand) return handData.type == LeapHuman.getHandString(handType));
    return handData.length > 0 ? handData[0] : null;
  }
}
