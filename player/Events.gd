# Autoloaded singleton that holds signals that would be troublesome to wire in a
# local parent or a scene owner.
# 
# This keeps objects passed through setup functions or unsafe accessors at a
# lower count, and can be replaced with simpler `Events.connect` calls.
extends Node

signal damaged(target, damage, shooter)

enum UpgradeChoices { HEALTH, SPEED, CARGO, MINING, WEAPON }

enum UITypes { UPGRADE, QUIT }
