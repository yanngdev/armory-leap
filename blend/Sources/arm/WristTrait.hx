package arm;

import arm.leap.LeapController;
import arm.leap.LeapWrist;
import arm.leap.LeapHuman;

import arm.Config;

class WristTrait extends armory.Trait {
	var ctrl:LeapController;
  var wrist:LeapWrist;

  @prop
  var handType:String;

	public function new() {
		super();

    notifyOnInit(function() {
      ctrl = LeapController.instance;

      wrist = ctrl.getWrist(LeapHuman.getHandHuman(handType));

      armory.system.Event.add('onLeapUpdate', function() {
        updateLeap();
      });
    });
	}

  function updateLeap() {
    if(wrist == null) {
      return;
    }

    if(wrist.position != null) {
      object.transform.loc.setFrom(wrist.position.mult(Config.globalScale));
    }

    object.transform.buildMatrix();
  }
}