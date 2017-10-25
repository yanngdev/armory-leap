package arm.leap;

import iron.math.Quat;
import iron.math.Vec4;
import iron.math.Mat4;

import arm.leap.LeapHuman;
import arm.leap.LeapData;
import arm.leap.LeapWrist;

class LeapHand {
  private var data:LeapDataHand;
  private var pointablesData:Array<LeapDataPointable>;
  public var id(get, never):Int;
  public var type:LeapHumanHand;
  public var wrist:LeapWrist = new LeapWrist();
  public var fingers:Array<LeapFinger> = new Array();

  public var position:Vec4 = new Vec4();
  public var direction:Vec4 = new Vec4();
  public var normal:Vec4 = new Vec4();
  public var rotation:Quat = new Quat();

  public function new(type:LeapHumanHand) {
    this.type = type;

    for(type in Type.allEnums(LeapHumanFinger)) {
      fingers.push(new LeapFinger(this.type, type));
    }
  }

  function get_id() {
    return (data != null) ? data.id : null;
  }

  public function update(handData:LeapDataHand, pointablesData:Array<LeapDataPointable>) {
    data = handData;
    this.pointablesData = pointablesData;

    position.set(data.palmPosition[0], -  data.palmPosition[2],   data.palmPosition[1]);
    direction.set(data.direction[0], -data.direction[2], data.direction[1]);
    normal.set(data.palmNormal[0], -data.palmNormal[2], data.palmNormal[1]);

    // https://developer.leapmotion.com/documentation/javascript/supplements/Leap_JSON.html?proglang=javascript
    // Hand.basis is computed from the palmNormal and direction vectors. It is not included in the JSON data.
    // https://community.leapmotion.com/t/solved-websocket-json-hand-absolut-rotation-not-absolut-to-world/3037
    // You could also create the basis matrix using the direction, palmNormal, and the cross product between direction and palmNormal. In the native API, we do this with:
    // Vector crossed = handNormal.cross(direction);
    // Matrix(isLeft ? -crossed : crossed, -palmNormal, -direction);
    // BUT Blender.x=Leap.x, Blender.y=-Leap.z, Blender.z=Leap.y

    var crossed = new Vec4().crossvecs(normal, direction);//.mult((type == LeapHumanHand.Left) ? -1 : 1);

    rotation.fromRotationMat(new Mat4(
      crossed.x, direction.x, -normal.x, 0,
      crossed.y, direction.y, -normal.y, 0,
      crossed.z, direction.z, -normal.z, 0,
      0, 0, 0, 0
    ));

    wrist.update(data.wrist);

    for(finger in fingers) {
      var pointableData = this.pointablesData.filter(function(pointableData:LeapDataPointable) return pointableData.type == LeapHuman.getFingerIndex(finger.type));

      if(pointableData.length > 0) {
        finger.update(pointableData[0]);
      }
    }
  }

  public function getFinger(fingerType:LeapHumanFinger):LeapFinger {
    var finger = fingers.filter(function(finger:LeapFinger) return finger.type == fingerType);
    return finger.length > 0 ? finger[0] : null;
  }
}