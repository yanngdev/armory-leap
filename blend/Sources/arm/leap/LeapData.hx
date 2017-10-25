package arm.leap;

// https://developer.leapmotion.com/documentation/javascript/supplements/Leap_JSON.html?highlight=json#json-tracking-data-format

typedef LeapDataGesture = {
  var center:Array<Float>;
  var direction:Array<Float>;
  var duration:Int;
  var handsIds:Array<Int>;
  var id:Int;
  var normal:Array<Float>;
  var pointableIds:Array<Int>;
  var position:Array<Float>;
  var progress:Float;
  var radius:Float;
  var speed:Float;
  var startPosition:Array<Float>;
  var state:String;
  var type:String;
}

typedef LeapDataHand = {
  var armBasis:Array<Array<Float>>;
  var armWidth:Float;
  var confidence:Float;
  var direction:Array<Float>;
  var elbow:Array<Float>;
  var grabAngle:Float;
  var grabStength:Float;
  var id:Int;
  var palmNormal:Array<Float>;
  var palmPosition:Array<Float>;
  var palmVelocity:Array<Float>;
  var palmWidth:Float;
  var pinchDistance:Float;
  var pinchStrength:Float;
  var r:Array<Array<Float>>;
  var s:Float;
  var sphereCenter:Array<Float>;
  var sphereRadius:Float;
  var stabilizedPalmPosition:Array<Float>;
  var t:Array<Float>;
  var timeVisible:Float;
  var type:String;
  var wrist:Array<Float>;
}

typedef LeapDataInteractionBox = {
  var center:Array<Float>;
  var size:Array<Float>;
}

typedef LeapDataPointable = {
  var bases:Array<Array<Array<Float>>>;
  var btipPosition:Array<Float>;
  var carpPosition:Array<Float>;
  var dipPosition:Array<Float>;
  var direction:Array<Float>;
  var extended:Bool;
  var handId:Int;
  var id:Int;
  var length:Float;
  var mcpPosition:Array<Float>;
  var pipPosition:Array<Float>;
  var stabilizedTipPosition:Array<Float>;
  var timeVisible:Float;
  var tipPosition:Array<Float>;
  var tipVelocity:Array<Float>;
  var tool:Bool;
  var touchDistance: Float;
  var touchZone:String;
  var type:Int;
  var width:Float;
}

typedef LeapData = {
  var currentFrameRate:Float;
  var id:Float;
  var r:Array<Float>;
  var s:Float;
  var t:Array<Float>;
  var timestamp:Int;
  var devices:Array<Int>;
  var gestures:Array<LeapDataGesture>;
  var hands:Array<LeapDataHand>;
  var interactiveBox:LeapDataInteractionBox;
  var pointables:Array<LeapDataPointable>;
}