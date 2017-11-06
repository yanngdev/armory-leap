package arm;

import iron.math.Vec4;
import iron.object.Transform;

import armory.trait.internal.RigidBody;

class CubeTrait extends armory.Trait {
  public function new() {
    super();

    notifyOnInit(function() {
      var rigidBody = object.getTrait(RigidBody);
      
      if(rigidBody != null) {
        rigidBody.setActivationState(4);
        rigidBody.syncTransform();
      }
    });

    notifyOnUpdate(function() {
      
    });
  }
}
