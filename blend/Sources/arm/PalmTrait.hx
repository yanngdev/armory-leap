package arm;

import kha.FastFloat;

import iron.math.Vec4;
import iron.math.Mat4;
import iron.math.Quat;

import arm.leap.LeapController;
import arm.leap.LeapHand;
import arm.leap.LeapHuman;

import arm.Config;

class PalmTrait extends armory.Trait {
	var ctrl:LeapController;
  var hand:LeapHand;

  @prop
  var handType:String;

	public function new() {
		super();

    notifyOnInit(function() {
      ctrl = LeapController.instance;

      hand = ctrl.getHand(LeapHuman.getHandHuman(handType));

      armory.system.Event.add('onLeapUpdate', function() {
        updateLeap();
      });
    });
	}

  function updateLeap() {
    if(hand == null) {
      return;
    }

    if(hand.position != null) {
      object.transform.loc.setFrom(hand.position.mult(Config.globalScale));
    }

    if(hand.direction != null && hand.normal != null) {
      object.transform.rot.setFrom(hand.rotation);
    }

    object.transform.buildMatrix();
  }
}