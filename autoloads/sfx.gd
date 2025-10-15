extends AudioStreamPlayer

const tracks := {
	"big_splash": preload("res://other/SFX/BigSplash.wav"),
	"complete": preload("res://other/SFX/CompleteSound.wav"),
	"small_splash": preload("res://other/SFX/SmallSplash.wav"),
	"water_splash": preload("res://other/SFX/WaterSplash.wav"),
	"win": preload("res://other/SFX/WinSound.wav"),
	"loose": preload("res://other/SFX/LoosingSound.wav")
}

func play_sfx(track: String) -> void:
	if tracks.has(track):
		self.stream = tracks[track]
		self.play()
	else:
		push_warning("Track %s not found" % track)
