/// @description Hier Beschreibung einfügen
// Sie können Ihren Code in diesem Editor schreiben
if(obj_player.vspeed > 0) {
	obj_player.vspeed = -16;
	instance_destroy();
	audio_play_sound(snd_player_jump_off_enemy, 10, 0);
}else {
	//room_restart();	
	room_goto(room_first);

}