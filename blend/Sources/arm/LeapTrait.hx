package arm;

import haxe.Timer;

import arm.leap.LeapController;
import arm.leap.LeapData;
import arm.leap.LeapHuman;

class LeapTrait extends armory.Trait {

	var ctrl:LeapController = LeapController.instance;
  	var timer:Timer;
  	var _handType:LeapHumanHand;

	public function new() {
		super();

    	notifyOnInit(function() {
			ctrl = LeapController.instance;
			timer = setTimer();

			armory.system.Event.add('onLeapUpdate', function() {
				updateTimer();
				updateLeap();
			});
		});
	}

	function initLeapTrait(handType:String) {
		_handType = LeapHuman.getHandHuman(handType);
	}

	function setTimer():Timer {
		return Timer.delay(function() { object.visible = false; }, 500);
	}

	function updateTimer() {
		timer.stop();

		var hand = ctrl.getDataHand(_handType);

		if(hand != null) {
    		object.visible = true;
		}

		timer = setTimer();
	}

	function updateLeap() {

	}
}