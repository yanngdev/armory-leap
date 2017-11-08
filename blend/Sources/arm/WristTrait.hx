package arm;

import arm.leap.LeapWrist;
import arm.leap.LeapHuman;

import arm.LeapTrait;
import arm.Config;

class WristTrait extends LeapTrait {
  var wrist:LeapWrist;

  @prop
  var handType:String;

	public function new() {
		super();

    notifyOnInit(function() {
      initLeapTrait(this.handType);
      
      wrist = ctrl.getWrist(LeapHuman.getHandHuman(handType));
    });
	}

  override function updateLeap() {
    if(wrist != null && wrist.position != null) {
      object.transform.loc.setFrom(wrist.position.mult(Config.globalScale));
    }

    object.transform.buildMatrix();
  }
}