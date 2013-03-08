/*
 * Copyright (c) 2013, TheGhost
 *
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 *     * Redistributions of source code must retain the above copyright notice, this
 *       list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright notice, this
 *       list of conditions and the following disclaimer in the documentation and/or other
 *       materials provided with the distribution.
 *     * Neither the name of the product nor the names of its contributors may be used
 *       to endorse or promote products derived from this software without specific prior
 *       written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

function getGamemodeName ( )
{
	local name = "";
	local _g = SERVER.getconfig ( ).gamemode.tointeger ( );
	
	if ( _g == 0 )
		name = "freeroam";
	else if ( _g == 1 )
		name = "race";
	else if ( _g == 2 )
		name = "roleplay";
	else if ( _g == 3 )
		name = "tdm";
	else if ( _g == 4 )
		name = "assult";
	
	return name;
}
 
function registerEvent ( eventname, handler, source )
{
	
}

function registerCommand ( commandname, handler )
{
	if ( !SERVER.getcmdhandler ( ).rawin ( commandname ) )
		SERVER.addcommand ( commandname, handler );
	else
		return false;
		
	return true;
}

function isElement ( element )
{
	if ( !element.type )
		return false;
	
	switch ( element.gettype ( ) )
	{
		case "player":
			return true;
			break;
		case "vehicle":
			return true;
			break;
		case "blip":
			return true;
			break;
		case "checkpoint":
			return true;
			break;
		case "ped":
			return true;
			break;
		case "house":
			return true;
			break;
		case "usergroup":
			return true;
			break;
		case "pickup":
			return true;
			break;
		case "spawnpoint":
			return true;
			break;
		case "object":
			return true;
			break;
		case "account":
			return true;
			break;
		case "timer":
			return true;
			break;
		default:
			return false;
	}
	return false;
}

/*function isElement ( element )
{
	if ( element.instanceof ( ) == Element );
		return true;
	return false;
}*/

function createElement ( element_type, a = false, b = false, c = false, d = false, e = false, f = false, g = false, h = false )
{
	if ( !element_type )
		return false;
		
	if ( typeof ( element_type ) == "string" )
	{
		local data = false;
		switch ( element_type )
		{
			case "vehicle":
				if ( a != false && b != false && c != false && d != false )
					data = { 
						model = a.tointeger ( ), 
						x = b[0].tofloat ( ), y = b[1].tofloat ( ), z = b[2].tofloat ( ), 
						rx = c[0].tofloat ( ), ry = c[0].tofloat ( ), rz = c[0].tofloat ( ), 
						color = [ d[0].tointeger ( ), d[1].tointeger ( ), d[2].tointeger ( ), d[3].tointeger( ) ] 
					};
				break;
			case "ped":
				if ( a != false && b != false && c != false )
					data = { model = a.tointeger ( ), x = b[0].tofloat ( ), y = b[1].tofloat ( ), z = b[2].tofloat ( ), rot = c.tofloat ( ) };
				break;
			case "pickup":
				if ( a != false && b != false )
					data = { model = a.tointeger ( ), x = b[0].tofloat ( ), y = b[1].tofloat ( ), z = b[2].tofloat ( ) };
				break;
			case "house":
				if ( a != false && b != false && c != false && d != false && e != false && f != false )
					return;
				break;
			case "blip":
				if ( a != false && b != false )
					data = { model = a.tointeger ( ), x = b[0].tofloat ( ), y = b[1].tofloat ( ), z = b[2].tofloat ( ) };
				break;
			case "checkpoint":
				if ( a != false && b != false && c != false )
					data = { 
						model = a.tointeger ( ), 
						x = b[0].tofloat ( ), y = b[1].tofloat ( ), z = b[2].tofloat ( ) 
						tx = c[0].tofloat ( ), ty = c[1].tofloat ( ), tz = c[2].tofloat ( )
					};
				break;
			case "spawnpoint":
				if ( a != false && b != false && c != false && d != false )
					return SERVER.getworld ( ).getmaphandler ( ).getdefault ( ).addspawnpoint ( element_type, data );
				break;
			case "object":
				if ( a != false && b != false && c != false )
					data = { 
						model = a.tointeger ( ), 
						x = b[0].tofloat ( ), y = b[1].tofloat ( ), z = b[2].tofloat ( ) 
						rx = c[0].tofloat ( ), ry = c[1].tofloat ( ), rz = c[2].tofloat ( )
					};
				break;
			default:
				return false;
		}
		return SERVER.getworld ( ).getmaphandler ( ).getdefault ( ).addelement ( element_type, data );
	}
	else
		return false;
}

function getElementRotation ( element )
{
	if ( !isElement ( element ) )
		return false;
	
	local pos;
	switch ( element.gettype ( ) )
	{
		case "player":
			pos = element.getrotation ( );
			break;
		default:
			return false;
	}
	return pos;
}

function getElementPosition ( element )
{
	if ( !isElement ( element ) )
		return false;
	
	local pos;
	switch ( element.gettype ( ) )
	{
		case "player":
			pos = element.getposition ( );
			break;
		case "vehicle":
			pos = element.getposition ( );
			break;
		case "object":
			pos = getObjectCoordinates ( element.id );
			break;
		case "checkpoint":
			pos = element.getposition ( );
			break;
		case "blip":
			pos = getBlipCoordinates ( element.id );
			break;
		case "pickup":
			pos = getPickupCoordinates ( element.id );
			break;
		case "house":
			return;
			break;
		case "spawnpoint":
			return element.getposition ( );
			break;
		default:
			return false;
	}
	return pos;
}

function isAccount ( account )
{
	if ( !account.getname ( ) )
		return false;

	return SERVER.getaccounthandler ( ).getaccount ( account.getname ( ) );
}

function isPlayerLoggedIn ( player )
{
	if ( player.getaccount ( ) )
		return true;
	return false;
}

function getAccounts ( )
{
	return SERVER.getaccounthandler ( ).getaccounts( );
}

function getAccount ( var )
{
	local account = SERVER.getaccounthandler ( ).getaccount ( var );
	if ( account )
		return account;
	return false;
}

// Creates a new account
function addAccount ( username, password, serial = "", ip = "" )
{
	local account = SERVER.getaccounthandler ( ).insertaccount ( username, password, serial, ip );
	if ( account )
		return account;
	return false;
}


// Returns hashed password
function getAccountPassword ( account )
{
	if ( !account.getname ( ) )
		return false;
		
	if ( !SERVER.getaccounthandler ( ).getaccount ( account.getname ( ) ) )
		return false;
		
	return account.getpassword ( );
	
}

function setAccountPassword ( account, password )
{
	if ( !SERVER.getaccounthandler ( ).getaccount ( account.getname ( ) ) )
		return false;
		
	return account.setpassword ( password );
}

function getUsergroup ( var )
{
	local usergroup = SERVER.getusergroup ( var );
	if ( usergroup )
		return usergroup;
	return false;
}

function getRandomNumber ( min = 0, max = RAND_MAX )
{
	return SERVER.math.random ( min, max );
}

function spawnPlayer ( player, x = false, y = false, z = false, rot = false )
{
	return SERVER.getworld ( ).spawnplayer ( player, x, y, z, rot );
}

function loginPlayer ( player, account, auto = false )
{
	if ( !player || !account )
		return false;
		
	player.login ( account );
	account.assignplayer ( player );
	player.message ( "You have logged in! Username: " + account.getusername ( ), Gray );
	return true;
}

function logoutPlayer ( player, account )
{
	player.logout ( );
	account.unassignplayer ( );
	player.setusergroup ( SERVER.getusergroup ( 1 ) );
	player.message ( "You have logged out of your account.", Gray );
	return true;
}

function joinChatChannel ( player, channel )
{
	if ( !player.getchatchannel ( ) )
	{

	}	
	else
		player.getchatchannel ( ).removemember ( player );
		
	channel.addmember ( player );
	player.joinchatchannel ( channel );
		
	return true;
}

function getPlayer ( var )
{
	return SERVER.getworld ( ).getplayer ( var );
}

function getVehicle ( id )
{
	if ( typeof ( id ) != "integer" )
		return false;
	
	foreach ( k, map in SERVER.getworld ( ).getmaphandler ( ).maps )
	{
		foreach ( i, vehicle in map.vehicles )
		{
			if ( vehicle.getid ( ) == id )
				return vehicle;
		}
	}
	
	return false;
}

function getUsergroup ( var )
{
	return SERVER.getusergroup ( var );
}

function getAccountUsername ( account )
{
	if ( isAccount ( account ) )
	{
		return account.getname ( );
	}
	return false;
}

function getPlayerAccount ( player )
{
	return player.getaccount ( );
}

function getNearbyPlayers ( pos, range = 20 )
{
	local t = [ ];
	
	foreach ( player in SERVER.getworld ( ).getplayers ( ) )
	{
		local distance = SERVER.math.distance ( pos, player.getposition ( ) );
		if ( typeof ( distance ) == "integer" )
		{
			if ( distance <= range )
				t.push ( player );
		}
	}
}

function areElementsNearby ( _e1, _e2, dist = 20 )
{
	local d = SERVER.math.distance ( getElementPosition ( _e1 ), getElementPosition ( _e2 ) );
	if ( d <= dist )
		return true;
	return false;
}