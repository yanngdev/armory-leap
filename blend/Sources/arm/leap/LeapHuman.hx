package arm.leap;

// https://developer.leapmotion.com/documentation/python/devguide/Leap_Overview.html

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
    return switch(Std.string(value)) {
      case 'l': LeapHumanHand.Left;
      case 'left': LeapHumanHand.Left;
      case 'r':  LeapHumanHand.Right;
      case 'right':  LeapHumanHand.Right;
      default: null;
    }
  }

  static public function getHandString(value:LeapHumanHand):String {
    return switch(value) {
      case Left: 'left';
      case Right: 'right';
      default: null;
    }
  }

  static public function getHandIndex(hand:LeapHumanHand):Int {
    return Type.enumIndex(hand);
  }

  // Fingers
  static public function getFingerHuman(value:String):LeapHumanFinger {
    return switch(Std.string(value)) {
      case 'thumb': LeapHumanFinger.Thumb;
      case 'index': LeapHumanFinger.Index;
      case 'middle': LeapHumanFinger.Middle;
      case 'ring': LeapHumanFinger.Ring;
      case 'pinky': LeapHumanFinger.Pinky;
      default: null;
    }
  }

  static public function getFingerString(value:LeapHumanFinger):String {
    return switch(value) {
      case Thumb: 'thumb';
      case Index: 'index';
      case Middle: 'middle';
      case Ring: 'ring';
      case Pinky: 'pinky';
      default: null;
    }
  }

  static public function getFingerHumanFromIndex(value:Int):LeapHumanFinger {
    return switch(value) {
      case 0: LeapHumanFinger.Thumb;
      case 1: LeapHumanFinger.Index;
      case 2: LeapHumanFinger.Middle;
      case 3: LeapHumanFinger.Ring;
      case 4: LeapHumanFinger.Pinky;
      default: null;
    }
  }

  static public function getFingerIndex(finger:LeapHumanFinger):Int {
    return Type.enumIndex(finger);
  }

  // Bones
  static public function getBoneHuman(value:String):LeapHumanBone {
    return switch(Std.string(value)) {
      case 'metacarpal': LeapHumanBone.Metacarpal;
      case 'proximal': LeapHumanBone.Proximal;
      case 'intermediate': LeapHumanBone.Intermediate;
      case 'distal': LeapHumanBone.Distal;
      default: null;
    }
  }

  static public function getBoneString(value:Int):String {
    return switch(value) {
      case 0: 'metacarpal';
      case 1: 'proximal';
      case 2: 'intermediate';
      case 3: 'distal';
      default: null;
    }
  }

  static public function getBoneHumanFromIndex(value:Int):LeapHumanBone {
    return switch(value) {
      case 0: LeapHumanBone.Metacarpal;
      case 1: LeapHumanBone.Proximal;
      case 2: LeapHumanBone.Intermediate;
      case 3: LeapHumanBone.Distal;
      default: null;
    }
  }

  static public function getBoneIndex(bone:LeapHumanBone):Int {
    return Type.enumIndex(bone);
  }
}