package arm.leap;

import iron.math.Vec4;

class LeapWrist {
  public var position:Vec4 = new Vec4();

  public function new() {

  }

  public function update(position:Array<Float>) {
    this.position.set(position[0], -position[2], position[1]);
  }
}