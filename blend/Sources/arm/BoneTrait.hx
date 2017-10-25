package arm;

import kha.FastFloat;

import iron.math.Vec4;
import iron.math.Mat4;
import iron.math.Quat;

import arm.leap.LeapController;
import arm.leap.LeapBone;
import arm.leap.LeapHuman;

class BoneTrait extends armory.Trait {
	var ctrl:LeapController = LeapController.instance;
  var bone:LeapBone;

  @prop
  var handType:String = 'left';
  @prop
  var fingerType : String = "right";
  @prop
  var boneType:String;

	public function new() {
		super();

    notifyOnInit(function() {
      ctrl = LeapController.instance;

      bone = ctrl.getBone(
        LeapHuman.getHandHuman(handType),
        LeapHuman.getFingerHuman(fingerType),
        LeapHuman.getBoneHuman(boneType)
      );

      armory.system.Event.add('onLeapUpdate', function() {
        updateLeap();
      });
    });
	}

  function updateLeap() {
    if(bone == null) {
      return;
    }

    if(bone.position != null) {
      object.transform.loc = new Vec4(bone.position[0], -bone.position[2], bone.position[1]).mult(1/10);
    }

    if(bone.rotation != null) {
      object.transform.rot = new Quat().fromRotationMat(new Mat4(
            cast(bone.rotation[0][0], FastFloat), -cast(bone.rotation[2][0], FastFloat), cast(bone.rotation[1][0], FastFloat), 0.0,
            -cast(bone.rotation[0][2], FastFloat), cast(bone.rotation[2][2], FastFloat), -cast(bone.rotation[1][2], FastFloat), 0.0,
            cast(bone.rotation[0][1], FastFloat), -cast(bone.rotation[2][1], FastFloat), cast(bone.rotation[1][1], FastFloat), 0.0,
            0.0, 0.0, 0.0, 0.0
      ));
    }

    object.transform.buildMatrix();
  }
}
