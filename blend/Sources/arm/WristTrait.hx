package arm;

import kha.FastFloat;

import iron.math.Vec4;

import arm.leap.LeapController;
import arm.leap.LeapWrist;
import arm.leap.LeapHuman;

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
      object.transform.loc = new Vec4(wrist.position[0], -wrist.position[2], wrist.position[1]).mult(1/10);
    }

    object.transform.buildMatrix();
  }
}