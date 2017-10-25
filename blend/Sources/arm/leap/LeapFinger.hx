package arm.leap;

import arm.leap.LeapHuman;
import arm.leap.LeapData;
import arm.leap.LeapBone;

class LeapFinger {
  private var data:LeapDataPointable;
  public var type:LeapHumanFinger;
  public var bones:Array<LeapBone> = new Array();

  public function new(type:LeapHumanFinger) {
    this.type = type;

    for(type in Type.allEnums(LeapHumanBone)) {
      bones.push(new LeapBone(type));
    }
  }

  public function update(fingerData:LeapDataPointable) {
    data = fingerData;

    var bonesPositions = [
      data.carpPosition,
      data.mcpPosition,
      data.pipPosition,
      data.dipPosition
    ];
    var bonesRotations = data.bases;

    var i = 0;
    for(bone in bones) {
      bone.update(bonesPositions[i], bonesRotations[i]);
      i++;
    }
  }

  public function getBone(boneType:LeapHumanBone):LeapBone {
    var bone = bones.filter(function(bone:LeapBone) return bone.type == boneType);
    return bone.length > 0 ? bone[0] : null;
  }
}