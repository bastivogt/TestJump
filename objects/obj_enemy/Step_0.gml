/// @description Hier Beschreibung einfügen
// Sie können Ihren Code in diesem Editor schreiben


vspeed += 1;





if(place_meeting(x, y, obj_enemy_border)) {

	//hspeed = -hspeed;
	hspeed = -hspeed;
}



if(hspeed > 0) {
	face_direction = 1;
}else{
	face_direction = -1;	
}
image_xscale = face_direction;




// Kolision Horizontal
if(!place_free(x + hspeed, y)) {
	if(hspeed > 0) {
		move_contact_solid(0, -1);
	}else {
		move_contact_solid(180, -1);	
	}
	hspeed = -hspeed;
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