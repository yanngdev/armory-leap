package arm.leap;

import arm.leap.LeapHuman;
import arm.leap.LeapData;
import arm.leap.LeapPalm;
import arm.leap.LeapWrist;

class LeapHand {
  private var data:LeapDataHand;
  private var fingersData:Array<LeapDataPointable>;
  public var id(get, never):Int;
  public var type:LeapHumanHand;
  public var palm:LeapPalm = new LeapPalm();
  public var wrist:LeapWrist = new LeapWrist();
  public var fingers:Array<LeapFinger> = new Array();

  public function new(type:LeapHumanHand) {
    this.type = type;

    for(type in Type.allEnums(LeapHumanFinger)) {
      fingers.push(new LeapFinger(type));
    }
  }

  function get_id() {
    return (data != null) ? data.id : null;
  }

  public function update(handData:LeapDataHand, pointablesData:Array<LeapDataPointable>) {
    data = handData;
    fingersData = pointablesData;

    palm.update(data.palmPosition, data.direction, data.palmNormal, data.s);

    wrist.update(data.wrist);

    for(finger in fingers) {
      var fingerData = fingersData.filter(function(fingerData:LeapDataPointable) return fingerData.type == LeapHuman.getFingerIndex(finger.type));

      if(fingerData.length > 0) {
        finger.update(fingerData[0]);
      }
    }
  }

  public function getFinger(fingerType:LeapHumanFinger):LeapFinger {
    var finger = fingers.filter(function(finger:LeapFinger) return finger.type == fingerType);
    return finger.length > 0 ? finger[0] : null;
  }
}