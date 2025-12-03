extends PanelContainer

func _ready() -> void:
	self.visible = false


func _on_main_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0,value)


func _on_music_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1,value)


func _on_vfx_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(2,value)




func _on_main_check_box_mute_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0,not toggled_on)


func _on_muisc_check_box_mute_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(1, not toggled_on)


func _on_vfx_check_box_mute_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(2,not toggled_on)






func _on_close_button_pressed() -> void:
	self.visible = false
	Engine.time_scale = 1.0

func _on_settings_button_pressed() -> void:
	self.visible = true
	Engine.time_scale = 0.0
