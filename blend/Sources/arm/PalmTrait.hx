package arm;

import kha.FastFloat;

import iron.math.Vec4;
import iron.math.Mat4;
import iron.math.Quat;

import arm.leap.LeapController;
import arm.leap.LeapPalm;
import arm.leap.LeapHuman;

class PalmTrait extends armory.Trait {
	var ctrl:LeapController;
  var palm:LeapPalm;

  @prop
  var handType:String;

	public function new() {
		super();

    notifyOnInit(function() {
      ctrl = LeapController.instance;

      palm = ctrl.getPalm(LeapHuman.getHandHuman(handType));

      armory.system.Event.add('onLeapUpdate', function() {
        updateLeap();
      });
    });
	}

  function updateLeap() {
    if(palm == null) {
      return;
    }

    if(palm.position != null) {
      object.transform.loc = new Vec4(palm.position[0], -palm.position[2], palm.position[1]).mult(1/10);
    }

    if(palm.direction != null && palm.normal != null) {
      // https://developer.leapmotion.com/documentation/javascript/supplements/Leap_JSON.html?proglang=javascript
      // Hand.basis is computed from the palmNormal and direction vectors. It is not included in the JSON data.
      // https://community.leapmotion.com/t/solved-websocket-json-hand-absolut-rotation-not-absolut-to-world/3037
      // You could also create the basis matrix using the direction, palmNormal, and the cross product between direction and palmNormal. In the native API, we do this with:
      // Vector crossed = handNormal.cross(direction);
      // Matrix(crossed, -handNormal, -direction);

      var direction = new Vec4(palm.direction[0], palm.direction[1], palm.direction[2]);
      var normal = new Vec4(palm.normal[0], palm.normal[1], palm.normal[2]);
      var crossed = new Vec4().crossvecs(normal, direction);

      object.transform.rot = new Quat().fromRotationMat(new Mat4(
        cast(crossed.x, FastFloat), cast(direction.x, FastFloat), -cast(normal.x, FastFloat), 0,
        -cast(crossed.z, FastFloat), -cast(direction.z, FastFloat), cast(normal.z, FastFloat), 0,
        cast(crossed.y, FastFloat), cast(direction.y, FastFloat), -cast(normal.y, FastFloat), 0,
        0, 0, 0, 0
      ));
    }

    object.transform.buildMatrix();
  }
}