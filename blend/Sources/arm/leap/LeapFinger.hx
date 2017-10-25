package arm.leap;

import iron.math.Vec4;

import arm.leap.LeapHuman;
import arm.leap.LeapData;
import arm.leap.LeapBone;

class LeapFinger {
  private var data:LeapDataPointable;
  public var handType:LeapHumanHand;
  public var type:LeapHumanFinger;
  public var bones:Array<LeapBone> = new Array();
  public var tip:Vec4 = new Vec4();

  public function new(handType:LeapHumanHand, type:LeapHumanFinger) {
    this.handType = handType;
    this.type = type;

    for(type in Type.allEnums(LeapHumanBone)) {
      bones.push(new LeapBone(handType, type));
    }
  }

  public function update(pointableData:LeapDataPointable) {
    data = pointableData;

    tip.set(data.tipPosition[0], -data.tipPosition[2], data.tipPosition[1]);

    var bonesPositions = [
      data.carpPosition,
      data.mcpPosition,
      data.pipPosition,
      data.dipPosition,
      data.btipPosition
    ];
    var bonesRotations = data.bases;

    var i = 0;
    for(bone in bones) {
      bone.update(bonesPositions[i], bonesPositions[i+1], bonesRotations[i]);
      i++;
    }
  }

  public function getBone(boneType:LeapHumanBone):LeapBone {
    var bone = bones.filter(function(bone:LeapBone) return bone.type == boneType);
    return bone.length > 0 ? bone[0] : null;
  }
}