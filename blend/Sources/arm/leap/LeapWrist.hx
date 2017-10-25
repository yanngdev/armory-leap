package arm.leap;

class LeapWrist {
  public var position(default, null):Array<Float>;

  public function new() {

  }

  public function update(position:Array<Float>) {
    this.position = position;
  }
}