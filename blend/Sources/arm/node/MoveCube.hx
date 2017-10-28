package arm.node;

@:keep class MoveCube extends armory.logicnode.LogicTree {

	public function new() { super(); notifyOnAdd(add); }

	function add() {
		var _TranslateObject_001 = new armory.logicnode.TranslateObjectNode(this);
		var _OnKeyboard_001 = new armory.logicnode.OnKeyboardNode(this);
		_OnKeyboard_001.property0 = "Down";
		_OnKeyboard_001.property1 = "left";
		_OnKeyboard_001.addOutputs([_TranslateObject_001]);
		_TranslateObject_001.addInput(_OnKeyboard_001, 0);
		_TranslateObject_001.addInput(new armory.logicnode.ObjectNode(this, ""), 0);
		var _Vector_001 = new armory.logicnode.VectorNode(this);
		_Vector_001.addInput(new armory.logicnode.FloatNode(this, -0.10000000149011612), 0);
		_Vector_001.addInput(new armory.logicnode.FloatNode(this, 0.0), 0);
		_Vector_001.addInput(new armory.logicnode.FloatNode(this, 0.0), 0);
		_Vector_001.addOutputs([_TranslateObject_001]);
		_TranslateObject_001.addInput(_Vector_001, 0);
		_TranslateObject_001.addOutputs([new armory.logicnode.NullNode(this)]);
		var _TranslateObject = new armory.logicnode.TranslateObjectNode(this);
		var _OnKeyboard = new armory.logicnode.OnKeyboardNode(this);
		_OnKeyboard.property0 = "Down";
		_OnKeyboard.property1 = "right";
		_OnKeyboard.addOutputs([_TranslateObject]);
		_TranslateObject.addInput(_OnKeyboard, 0);
		_TranslateObject.addInput(new armory.logicnode.ObjectNode(this, ""), 0);
		var _Vector = new armory.logicnode.VectorNode(this);
		_Vector.addInput(new armory.logicnode.FloatNode(this, 0.10000000149011612), 0);
		_Vector.addInput(new armory.logicnode.FloatNode(this, 0.0), 0);
		_Vector.addInput(new armory.logicnode.FloatNode(this, 0.0), 0);
		_Vector.addOutputs([_TranslateObject]);
		_TranslateObject.addInput(_Vector, 0);
		_TranslateObject.addOutputs([new armory.logicnode.NullNode(this)]);
	}
}
