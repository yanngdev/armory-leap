package arm;

import iron.math.Vec4;
import iron.object.Transform;

import arm.leap.LeapController;
import arm.leap.LeapBone;
import arm.leap.LeapHuman;

import arm.Config;

class TipTrait extends armory.Trait {
	var ctrl:LeapController = LeapController.instance;
  var bone:LeapBone;

  @prop
  var handType:String;
  @prop
  var fingerType:String;
  @prop
  var boneType:String;

  var transform:Transform;

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

      transform = object.transform;
    });
  }

  function updateLeap() {
    if(bone != null && bone.tip != null) {
      object.transform.loc.setFrom(bone.tip.mult(Config.globalScale));
      object.transform.buildMatrix();
    }
  }
}
