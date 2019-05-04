/// @description Hier Beschreibung einfügen
// Sie können Ihren Code in diesem Editor schreiben




//show_debug_message(speed);

hspeed = 0;
vspeed += 1;

platform_buffer -= 1;
jump_buffer -= 1;

var fast_jump_pad = (gamepad_button_check(obj_game_manager.pad_num, gp_padr) || gamepad_button_check(obj_game_manager.pad_num, gp_padl)) && (gamepad_button_check(obj_game_manager.pad_num, gp_face1) && gamepad_button_check_pressed(obj_game_manager.pad_num, gp_face4));
var fast_jump = (keyboard_check(vk_right) || keyboard_check(vk_right)) && (keyboard_check(vk_space) && keyboard_check_pressed(vk_up));

if(platform_buffer < 0) {
	platform_buffer = 0;	
}
if(jump_buffer < 0) {
	jump_buffer = 0;
}

if(keyboard_check_pressed(vk_up) || gamepad_button_check_pressed(obj_game_manager.pad_num, gp_face4)) {
	jump_buffer = obj_settings._jump_buffer_size;
}

if(!place_free(x, y + 1)) {
	platform_buffer = obj_settings._platform_buffer_size;
}




if(keyboard_check(vk_right) || gamepad_button_check(obj_game_manager.pad_num, gp_padr)) {

	hspeed = obj_settings._player_speed;
}

if(keyboard_check(vk_left) || gamepad_button_check(obj_game_manager.pad_num, gp_padl)) {

	hspeed = -obj_settings._player_speed;
}

// fast speed run
if((keyboard_check(vk_right) && keyboard_check(vk_space)) || (gamepad_button_check(obj_game_manager.pad_num, gp_padr) && gamepad_button_check(obj_game_manager.pad_num, gp_face1))) {
	hspeed = obj_settings._player_fast_speed;
}

if((keyboard_check(vk_right) && keyboard_check(vk_space)) || (gamepad_button_check(obj_game_manager.pad_num, gp_padl) && gamepad_button_check(obj_game_manager.pad_num, gp_face1))) {
	hspeed = -obj_settings._player_fast_speed;
}

// face direction
if(hspeed > 0) {
	face_direction = 1;
}else if(hspeed < 0) {
	face_direction = -1;	
}

// sprite animation für run und stehen
if(hspeed == 0) {
	sprite_set_speed(spr_boy, 0, sprite_get_speed_type(spr_boy));

}else {
	sprite_set_speed(spr_boy, sprite_speed_, sprite_get_speed_type(spr_boy));
}




image_xscale = face_direction;


// Jump
/*if(keyboard_check_pressed(vk_up)) {
	if(!place_free(x, y + 1)) {
		vspeed = -20;
	}
	
}*/

if(jump_buffer > 0) {
	if(platform_buffer > 0) {
		audio_play_sound(snd_player_jump, 10, 0);
		if(fast_jump_pad || fast_jump) {
			vspeed = -obj_settings._player_fast_jump_height;
		}else {
			vspeed = -obj_settings._player_jump_height;
		}
		
		jump_buffer = 0;
		platform_buffer = 0;
	}

	
}


// Kolision Horizontal
if(!place_free(x + hspeed, y)) {
	if(hspeed > 0) {
		move_contact_solid(0, -1);
	}else {
		move_contact_solid(180, -1);	
	}
	hspeed = 0;
}



// Kolision Vertikal
if(!place_free(x, y + vspeed)) {
	if(vspeed > 0) {
		move_contact_solid(270, -1);
	}else {
		move_contact_solid(90, -1);
	}
	vspeed = 0;
}
// Ecken Kolision abfangen
if(!place_free(x + hspeed, y + vspeed)) {
	vspeed = 0;
}