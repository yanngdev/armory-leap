package arm.leap;

// https://developer.leapmotion.com/documentation/python/devguide/Leap_Overview.html

@:enum
abstract LeapHumanString(String) from String to String {
  var Left = 'left';
  var Right = 'right';

  var Thumb = 'thumb';
  var Index = 'index';
  var Middle = 'middle';
  var Ring = 'ring';
  var Pinky = 'pinky';

  var Metacarpal = 'metacarpal';
  var Proximal = 'proximal';
  var Intermediate = 'intermediate';
  var Distal = 'distal';
}

// Hands
enum LeapHumanHand {
  Left;
  Right;
}

// Fingers, from thumb
enum LeapHumanFinger {
  Thumb;
  Index;
  Middle;
  Ring;
  Pinky;
}

// Bones, from wrist
enum LeapHumanBone {
  Metacarpal;
  Proximal;
  Intermediate;
  Distal;
}

class LeapHuman {
  // Hands
  static public function getHandHuman(value:String):LeapHumanHand {
    if(value == null) return null;

    return switch(Std.string(value)) {
      case LeapHumanString.Left: LeapHumanHand.Left;
      case LeapHumanString.Right:  LeapHumanHand.Right;
      default: null;
    }
  }

  static public function getHandString(value:LeapHumanHand):String {
    if(value == null) return null;

    return switch(value) {
      case Left: LeapHumanString.Left;
      case Right: LeapHumanString.Right;
      default: null;
    }
  }

  static public function getHandIndex(hand:LeapHumanHand):Int {
    return Type.enumIndex(hand);
  }

  // Fingers
  static public function getFingerHuman(value:String):LeapHumanFinger {
    if(value == null) return null;

    return switch(Std.string(value)) {
      case LeapHumanString.Thumb: LeapHumanFinger.Thumb;
      case LeapHumanString.Index: LeapHumanFinger.Index;
      case LeapHumanString.Middle: LeapHumanFinger.Middle;
      case LeapHumanString.Ring: LeapHumanFinger.Ring;
      case LeapHumanString.Pinky: LeapHumanFinger.Pinky;
      default: null;
    }
  }

  static public function getFingerIndex(finger:LeapHumanFinger):Int {
    return Type.enumIndex(finger);
  }

  // Bones
  static public function getBoneHuman(value:String):LeapHumanBone {
    if(value == null) return null;
    
    return switch(Std.string(value)) {
      case LeapHumanString.Metacarpal: LeapHumanBone.Metacarpal;
      case LeapHumanString.Proximal: LeapHumanBone.Proximal;
      case LeapHumanString.Intermediate: LeapHumanBone.Intermediate;
      case LeapHumanString.Distal: LeapHumanBone.Distal;
      default: null;
    }
  }

  static public function getBoneIndex(bone:LeapHumanBone):Int {
    return Type.enumIndex(bone);
  }
}