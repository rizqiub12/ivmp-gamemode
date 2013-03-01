function onVehicleCreate ( vehicleid )
{
	return true;
}

function onVehicleEntryComplete ( playerid, vehicleid, seatid )
{
    local player = getPlayer ( playerid );
	local vehicle = getVehicle ( vehicleid );
	if ( !player || !vehicle )
		return;
	
	player.entervehicle ( vehicle );
    return true;
}

function onVehicleExitComplete ( playerid, vehicleid, seatid )
{
	local player = SERVER.getworld ( ).getplayer ( playerid );
	local vehicle = player.getvehicle ( );
	if ( !vehicle )
		return;
	if ( vehicle.getid ( ) == vehicleid )
		player.exitvehicle ( );
	else
		return false;
    return true;
}

addEvent ( "vehicleExitComplete", onVehicleExitComplete );
addEvent ( "vehicleCreate", onVehicleCreate );
addEvent ( "vehicleEntryComplete", onVehicleEntryComplete );