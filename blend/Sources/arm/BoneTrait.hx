package arm;

import kha.FastFloat;

import iron.math.Vec4;
import iron.math.Mat4;
import iron.math.Quat;

import arm.leap.LeapController;
import arm.leap.LeapBone;
import arm.leap.LeapHuman;

import arm.Config;

class BoneTrait extends armory.Trait {
	var ctrl:LeapController = LeapController.instance;
  var bone:LeapBone;

  @prop
  var handType:String;
  @prop
  var fingerType:String;
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
      object.transform.loc.setFrom(bone.position.mult(Config.globalScale));
    }

    if(bone.rotation != null) {
      object.transform.rot.setFrom(bone.rotation);
    }

    if(bone.length != null) {
      object.transform.scale.set(
        object.transform.size.x,
        bone.length * Config.globalScale,
        object.transform.size.z
      );
    }

    object.transform.buildMatrix();
  }
}
