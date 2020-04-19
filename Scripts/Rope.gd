extends StaticBody2D


func detach():
	var joint = $CollisionShape2D/PinJoint2D/ChainPiece/CollisionShape2D/PinJoint2D/ChainPiece2/CollisionShape2D/PinJoint2D/ChainPiece3/CollisionShape2D/PinJoint2D
	joint.node_b = NodePath("")
