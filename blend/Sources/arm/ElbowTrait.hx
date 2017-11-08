package arm;

import arm.leap.LeapElbow;
import arm.leap.LeapHuman;

import arm.LeapTrait;
import arm.Config;

class ElbowTrait extends LeapTrait {
  var elbow:LeapElbow;

  @prop
  var handType:String;

  public function new() {
    super();

    notifyOnInit(function() {
      initLeapTrait(this.handType);
      
      elbow = ctrl.getElbow(LeapHuman.getHandHuman(handType));
    });
  }

  override function updateLeap() {
    if(elbow != null && elbow.position != null) {
      object.transform.loc.setFrom(elbow.position.mult(Config.globalScale));
    }

    object.transform.buildMatrix();
  }
}