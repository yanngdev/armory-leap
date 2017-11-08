package arm;

import arm.leap.LeapBone;
import arm.leap.LeapHuman;

import arm.LeapTrait;
import arm.Config;

class TipTrait extends LeapTrait {
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
      initLeapTrait(this.handType);
      
      bone = ctrl.getBone(
        LeapHuman.getHandHuman(handType),
        LeapHuman.getFingerHuman(fingerType),
        LeapHuman.getBoneHuman(boneType)
      );
    });
  }

  override function updateLeap() {
    if(bone != null && bone.tip != null) {
      object.transform.loc.setFrom(bone.tip.mult(Config.globalScale));
      object.transform.buildMatrix();
    }
  }
}
