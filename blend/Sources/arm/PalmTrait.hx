package arm;

import arm.leap.LeapHand;
import arm.leap.LeapHuman;

import arm.LeapTrait;
import arm.Config;

class PalmTrait extends LeapTrait {
  var hand:LeapHand;

  @prop
  var handType:String;

	public function new() {
		super();

    notifyOnInit(function() {
      initLeapTrait(this.handType);
      
      hand = ctrl.getHand(LeapHuman.getHandHuman(handType));
    });
	}

  override function updateLeap() {
    if(hand != null && hand.position != null) {
      object.transform.loc.setFrom(hand.position.mult(Config.globalScale));
    }

    if(hand != null && hand.direction != null && hand.normal != null) {
      object.transform.rot.setFrom(hand.rotation);
    }

    object.transform.buildMatrix();
  }
}