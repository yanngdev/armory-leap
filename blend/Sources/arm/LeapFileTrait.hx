package arm;

#if (js && !kha_webgl) // Krom
import kha.Assets;
#end

import arm.leap.LeapController;
import arm.leap.LeapData;

import arm.Config;

class LeapFileTrait extends armory.Trait {
  #if (js && !kha_webgl) // Krom
  public var data:LeapData;
  var prevData:LeapData;
  var ctrl:LeapController;

  public function new() {
    super();

    ctrl = LeapController.instance;

    notifyOnUpdate(function() {
      if(Config.jsonPath != '') {
        updateFromFile(Config.jsonPath);
      }
    });
  }

  function updateFromFile(filePath:String) {
    Assets.loadBlobFromPath(filePath, function(b) {
      if(b == null) return;

      data = haxe.Json.parse(b.toString());

      if(data != null && prevData != null && data.id != prevData.id) {
        ctrl.update(data);
      }

      prevData = data;
    });
  }
  #end
}