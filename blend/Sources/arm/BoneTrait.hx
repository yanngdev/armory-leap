package arm;

import arm.leap.LeapBone;
import arm.leap.LeapHuman;

import arm.LeapTrait;
import arm.Config;

class BoneTrait extends LeapTrait {
  var bone:LeapBone;

  @prop
  var handType:String;
  @prop
  var fingerType:String;
  @prop
  var boneType:String;

	public function new() {
    super();

    notifyOnInit(init);
	}

  function init() {
    initLeapTrait(this.handType);

    bone = ctrl.getBone(
      LeapHuman.getHandHuman(handType),
      LeapHuman.getFingerHuman(fingerType),
      LeapHuman.getBoneHuman(boneType)
    );
  }

  override function updateLeap() {
    if(bone != null && bone.center != null) {
      object.transform.loc.setFrom(bone.center.mult(Config.globalScale));
    }

    if(bone != null && bone.rotation != null) {
      object.transform.rot.setFrom(bone.rotation);
    }

    if(bone != null && bone.length != null) {
      object.transform.scale.set(
        object.transform.size.x,
        bone.length * Config.globalScale,
        object.transform.size.z
      );
    }

    object.transform.buildMatrix();
  }
}
