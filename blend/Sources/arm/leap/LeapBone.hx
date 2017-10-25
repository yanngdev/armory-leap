package arm.leap;

import arm.leap.LeapHuman;

class LeapBone {
  public var type:LeapHumanBone;
  public var position:Array<Float>;
  public var rotation:Array<Array<Float>>;

  public function new(type:LeapHumanBone) {
    this.type = type;
  }

  public function update(position:Array<Float>, rotation:Array<Array<Float>>) {
    this.position = position;
    this.rotation = rotation;
  }
}