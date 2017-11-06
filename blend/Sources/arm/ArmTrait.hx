package arm;

import arm.leap.LeapArm;
import arm.leap.LeapHuman;

import arm.LeapTrait;
import arm.Config;

class ArmTrait extends LeapTrait {
    var arm:LeapArm;

    @prop
    var handType:String;

	public function new() {
		super();

		notifyOnInit(function() {
			arm = ctrl.getArm(LeapHuman.getHandHuman(handType));
		});
	}

  override function updateLeap() {
    if(arm != null && arm.center != null) {
      object.transform.loc.setFrom(arm.center.mult(Config.globalScale));
    }

    if(arm != null && arm.rotation != null) {
      object.transform.rot.setFrom(arm.rotation);
    }

	if(arm != null && arm.length != null) {
      object.transform.scale.set(
        object.transform.size.x,
        arm.length * Config.globalScale,
        object.transform.size.z
      );
    }

    object.transform.buildMatrix();
  }
}