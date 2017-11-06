package arm.leap;

import iron.math.Quat;
import iron.math.Vec4;
import iron.math.Mat4;

import arm.leap.LeapHuman;
import arm.leap.LeapData;
import arm.leap.LeapElbow;
import arm.leap.LeapWrist;

class LeapArm {
  var handType:LeapHumanHand;
  public var elbow:LeapElbow = new LeapElbow();

  public var rotation:Quat = new Quat();
  public var width:Float;
  public var length:Float;
  public var center:Vec4;

  public function new(handType:LeapHumanHand) {
	  this.handType = handType;
  }

  public function update(armBasis:Array<Array<Float>>, armWidth:Float, elbow:Array<Float>, wrist:LeapWrist) {
    this.elbow.update(elbow);

	rotation.fromRotationMat(new Mat4(
      armBasis[0][0] * (handType == LeapHumanHand.Left ? -1 : 1), -armBasis[2][0], armBasis[1][0], 0,
      -armBasis[0][2] * (handType == LeapHumanHand.Left ? -1 : 1), armBasis[2][2], -armBasis[1][2], 0,
      armBasis[0][1] * (handType == LeapHumanHand.Left ? -1 : 1), -armBasis[2][1], armBasis[1][1], 0,
      0, 0, 0, 0
    ));

	width = armWidth;

	length = wrist.position.distanceTo(this.elbow.position);

	center = Vec4.lerp(wrist.position, this.elbow.position, 0.5);
  }
}