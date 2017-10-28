package arm.leap;

import kha.FastFloat;

import iron.math.Vec4;
import iron.math.Quat;
import iron.math.Mat4;

import arm.leap.LeapHuman;

class LeapBone {
  public var type:LeapHumanBone;
  public var handType:LeapHumanHand;
  public var prevJoint:Vec4 = new Vec4();
  public var nextJoint:Vec4 = new Vec4();
  public var rotation:Quat = new Quat();

  public var position(get, never):Vec4;
  public var tip(get, never):Vec4;
  public var length:Float;
  public var center:Vec4;

  public function new(handType:LeapHumanHand, type:LeapHumanBone) {
    this.handType = handType;
    this.type = type;
  }

  function get_position() {
    return prevJoint;
  }

  function get_tip() {
    return nextJoint;
  }

  public function update(prevJoint:Array<Float>, nextJoint:Array<Float>, rotation:Array<Array<Float>>) {
    this.prevJoint.set(prevJoint[0], -prevJoint[2], prevJoint[1]);
    this.nextJoint.set(nextJoint[0], -nextJoint[2], nextJoint[1]);
    this.rotation.fromRotationMat(new Mat4(
          rotation[0][0] * ((handType == LeapHumanHand.Left) ? -1 : 1), -rotation[2][0], rotation[1][0], 0.0,
          -rotation[0][2] * ((handType == LeapHumanHand.Left) ? -1 : 1), rotation[2][2], -rotation[1][2], 0.0,
          rotation[0][1] * ((handType == LeapHumanHand.Left) ? -1 : 1), -rotation[2][1], rotation[1][1], 0.0,
          0.0, 0.0, 0.0, 0.0
    ));

    length = this.prevJoint.distanceTo(this.nextJoint);

    center = Vec4.lerp(this.prevJoint, this.nextJoint, 0.5);
  }
}