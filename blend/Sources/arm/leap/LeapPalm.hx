package arm.leap;

class LeapPalm {
  public var position:Array<Float>;
  public var direction:Array<Float>;
  public var normal:Array<Float>;
  public var scale:Float;

  public function new() {

  }

  public function update(position:Array<Float>, direction:Array<Float>, normal:Array<Float>, scale:Float) {
    this.position = position;
    this.direction = direction;
    this.normal = normal;
    this.scale = scale;
  }
}