/// @description Hier Beschreibung einfügen
//show_debug_message(speed);

hspeed = 0;
vspeed += 1;

platform_buffer -= 1;
jump_buffer -= 1;

// Keyboard Steuerung
var key_left = keyboard_check(vk_left);
var key_right = keyboard_check(vk_right);
var key_up_pressed = keyboard_check_pressed(vk_up);
var key_ctrl = keyboard_check(vk_control);

// Pad Steuerung
var pad_left = gamepad_button_check(obj_game_manager.pad_num, gp_padl);
var pad_right = gamepad_button_check(obj_game_manager.pad_num, gp_padr);
var pad_jump_pressed = gamepad_button_check_pressed(obj_game_manager.pad_num, gp_face4);
var pad_fire = gamepad_button_check(obj_game_manager.pad_num, gp_face1);
//var pad_fire_pressed = gamepad_button_check_pressed(obj_game_manager.pad_num, gp_face1);

var fast_run_pad = (pad_left || pad_right) && pad_fire;
var fast_run = (key_left || key_right) && key_ctrl;
var fast_jump_pad = (pad_left || pad_right) && (pad_fire && pad_jump_pressed);
var fast_jump = (key_left || key_right) && (key_ctrl && key_up_pressed);




if(platform_buffer < 0) {
	platform_buffer = 0;	
}
if(jump_buffer < 0) {
	jump_buffer = 0;
}

if(key_up_pressed || pad_jump_pressed) {
	jump_buffer = obj_settings._jump_buffer_size;
}

if(!place_free(x, y + 1)) {
	platform_buffer = obj_settings._platform_buffer_size;
}




if(key_right || pad_right) {

	hspeed = obj_settings._player_speed;
}

if(key_left || pad_left) {

	hspeed = -obj_settings._player_speed;
}

// fast speed run
if((key_right || pad_right) && (key_ctrl || pad_fire)) {
	hspeed = obj_settings._player_fast_speed;


}

if((key_left || pad_left) && (key_ctrl || pad_fire)) {
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
	image_index = 1;

}else {
	if(fast_run_pad || fast_run) {
		sprite_set_speed(spr_boy, sprite_speed_ * 2, sprite_get_speed_type(spr_boy));
	}else {
		sprite_set_speed(spr_boy, sprite_speed_, sprite_get_speed_type(spr_boy));	
	}
}

// sprite image für jump
if(vspeed < 1 || place_free(x + hspeed, y + vspeed)) {
	sprite_set_speed(spr_boy, 0, sprite_get_speed_type(spr_boy));
	image_index = 4;
}else {
	if(fast_run_pad || fast_run) {
		sprite_set_speed(spr_boy, sprite_speed_ * 2, sprite_get_speed_type(spr_boy));
	}else {
		sprite_set_speed(spr_boy, sprite_speed_, sprite_get_speed_type(spr_boy));	
	}
}


// Blickrichtung gleich laufrichtung
image_xscale = face_direction;

// Jump
if(jump_buffer > 0) {
	if(platform_buffer > 0) {
		audio_play_sound(snd_player_jump, 10, 0);
		if(fast_jump || fast_jump_pad) {
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