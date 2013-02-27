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

function onPlayerJoin ( playerid )
{	
	local player = SERVER.getworld ( ).playerjoin ( playerid );
	
	player.clearchat ( );
	switch ( player.getname ( ) )
	{
		case "player":
			player.setname ( "Guest" + SERVER.math.random ( 1000, 9999 ).tostring ( ) );
		default:
			SERVER.getworld ( ).messageall ( player.getname ( ) + " has entered the server.", Gray );
			player.message ( "Welcome to " + getHostname ( ), Gray );
	}
	
	joinChatChannel ( player, SERVER.getchatserver ( ).getchannel ( SERVER.getconfig ( ).defaultchannel ) );
	setPlayerUsergroup ( player, SERVER.getusergroup ( 0 ) );
	
	local account = SERVER.getaccounthandler( ).getaccount ( player.getname ( ) );
	if ( !account )
	{
		player.message ( "Please use /register <username> <password> or /login <username> <password> to continue.", Gray );
	}
	else
	{
		loginPlayer ( player, account, true );
		
		local usergroup = false;
		if ( account.getusergroup ( ) )
			usergroup = SERVER.getusergroup ( account.getusergroup ( ) );
			
		if ( usergroup )
			setPlayerUsergroup ( player, usergroup );
	}
}

function onPlayerText ( playerid, text )
{
	local player = SERVER.getworld ( ).getplayer ( playerid );
	if ( player )
	{
		if ( player.ismuted ( ) )
		{
			player.message ( "You are muted and cannot speak in a chat channel.", Red );
			return 0;
		}
		player.getchatchannel ( ).addchat ( player.getname ( ), text );
	}
	else
		log ( "Could not get player" );
		
	return 0;
}

function onPlayerDisconnect ( playerid, reason )
{
	local player = SERVER.getworld ( ).getplayer ( playerid );
	player.getaccount ( ).updateaccount ( );
	player.getusergroup ( ).removemember ( player );
	SERVER.getworld ( ).messageall ( getPlayerName ( playerid ) + " has left the server.", Gray );
	SERVER.getworld ( ).playerleave ( playerid );	
	player = null;
}

function onPlayerChangeState ( playerid, old, new )
{

}

function onPlayerEnterCheckpoint ( playerid, checkpointid )
{

}

function onPlayerNameCheck(playerid, name)
{
	for(local i = 0; i < name.len(); i++)
	{
		// Allow 'a' to 'z'
		if(name[i] >= 'a' && name[i] <= 'z')
			continue;

		// Allow 'A' to 'Z'
		if(name[i] >= 'A' && name[i] <= 'Z')
			continue;

		// Allow '0' to '9'
		if(name[i] >= '0' && name[i] <= '9')
			continue;

		// Allow '[' and ']'
		if(name[i] == '[' || name[i] == ']')
			continue;

		// Allow '_'
		if(name[i] == '_')
			continue;

		// Disallow all other characters
		return 0;
	}

	return 1;
}

function onPlayerCommand ( playerid, command )
{

	local cmd = split ( command.slice ( 1 ), " " );
	
	local player = SERVER.getworld ( ).getplayer ( playerid );
	command = cmd[0];
	cmd.remove ( 0 );
	
	SERVER.getdatahandler ( ).processcommand ( command, player.getname ( ) );
	if ( SERVER.execute ( command, cmd, player ) )
		return true;
	else
		return false;
	
}

addEvent ( "playerCommand", onPlayerCommand );
addEvent ( "playerNameCheck", onPlayerNameCheck );
addEvent ( "playerDisconnect", onPlayerDisconnect );
addEvent ( "playerText", onPlayerText );
addEvent ( "playerJoin", onPlayerJoin );

/*************************** Exported Events ***************************/
addEvent ( "playerMute", function ( player, state ) { return true; } );
addEvent ( "playerFreeze", function ( player, state ) { return true; } );
addEvent ( "playerSlapped", function ( player ) { return true; } );
addEvent ( "playerKicked", function ( player ) { return true; } );
addEvent ( "playerBanned", function ( player ) { return true; } );