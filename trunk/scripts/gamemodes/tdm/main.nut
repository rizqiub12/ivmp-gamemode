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

// Load Map
SERVER.getworld ( ).maphandler.loadmap ( "tdm.map", true );

local roundtimer = false;
local displaytimer = false;
local timeremain = [ 600, 10 ];
local restarttimer = 5000;
teams <- [ ];

function initGamemode ( )
{	
	teams.push ( createUsergroup ( "Red" ) );
	teams.push ( createUsergroup ( "Blue" ) );
	setElementData ( teams[0], "score", 0 );
	setElementData ( teams[1], "score", 0 );
	//SERVER.getscoreboard ( ).additem ( teams[0] );
	//SERVER.getscoreboard ( ).additem ( teams[1] );
	timer ( onRoundStart, 1000, 1 );
}

function onRoundStart ( )
{

	foreach ( id, team in teams )
		setElementData ( team, "score", 0 );
		
	roundtimer = Timer (
		function ( )
		{
			timeremain[0] = timeremain[0] - 1;
			
			local seconds = timeremain[0] % 60;
			if ( seconds == 0 )
				timeremain[1] - 1;
			
			if ( timeremain[1] == 1 )
				displayInfoTextForAll ( "Time Remaining: ~r~0:" + seconds.tostring ( ), 1000 );
			else
				displayInfoTextForAll ( "Time Remaining: ~g~" + ( timeremain[0] - 1 ).tostring ( ) + ":" + seconds.tostring ( ), 1000 );
		
			if ( timeremain[0] == 0 )
				onRoundFinish ( );
		},
		1000,
		-1
	);
	
	SERVER.getworld ( ).messageall ( "A new round has started!" );
	
	foreach ( player in SERVER.getworld ( ).getplayers ( ) )
	{
		if ( player )
		{
			player.message ( "Use /join " + teams[0].getname ( ) + " to join Team " + teams[0].getname ( ) + ", or use /join " + teams[1].getname ( ) + " to join Team " + teams[1].getname ( ) );
		}
	}
	
	return true;
}

function onRoundFinish ( )
{
	roundtimer.gettimer ( ).kill ( );
	roundtimer = false;
	
	local order = sortScore ( );
	if  ( getElementData ( teams[0], "score" ) == getElementData ( teams[1], "score" ) )
	{	
		SERVER.getworld ( ).messageall ( "This round was a tie!" );
		log ( "This round was a tie!" );	
	}
	else
	{
		SERVER.getworld ( ).messageall ( "Team " + getTeamName ( order[0] ) + " has won the round! " );
		log ( "Team " + getTeamName ( order[0] ) + " has won the round! " );
	}
	foreach ( player in SERVER.getworld ( ).getplayers ( ) )
	{
		if ( player )
		{
			setElementData ( player, "initspawn", true );
			player.setposition ( -200.000, 300.000, 16.000 );
			player.setfrozen ( true );
			player.message ( "Next round will start in " + ( restarttime / 1000 ).tostring ( ) + " seconds." );
		}
	}
	
	timeremain[0] = 600;
	timeremain[1] = 10;
	
	timer (
		onRoundStart,
		5000,
		1
	);
	
}

function sortScore ( )
{
	local score1 = getElementData ( teams[0], "score" );
	local score2 = getElementData ( teams[1], "score" );
	return score1 > score2 ? [ teams[0], teams[1] ] : [ teams[1], teams[0] ];
}

function onPlayerDeath ( playerid, killerid, weaponid, vehicleid )
{
	
	local player = SERVER.getworld ( ).getplayer ( playerid );
	local killer = SERVER.getworld ( ).getplayer ( killerid );
	
	if ( playerid && killerid )
	{
		if ( playerid != killerid )
		{
			if ( player.getusergroup ( ) != killer.getusergroup ( ) )
			{
				local score = killer.getusergroup.getdata ( "score" );
				killer.getusergroup ( ).setdata ( "score", score + 1 );
			}
		}
		else
		{
			local score = player.getusergroup.getdata ( "score" );
			player.getusergroup ( ).setdata ( "score", score - 1 );
		}
	}
	else
	{
		local score = player.getusergroup.getdata ( "score" );
		player.getusergroup ( ).setdata ( "score", score - 1 );
	}
}

function onPlayerJoin ( playerid )
{
	timer ( playerJoinDelay, 750, 1, playerid );
}

function playerJoinDelay ( playerid )
{
	local player = SERVER.getworld ( ).getplayer ( playerid );
	setElementData ( player, "initspawn", true );
}

function onPlayerSpawn ( playerid )
{
	local player = SERVER.getworld ( ).getplayer ( playerid );
	if ( getElementData ( player, "initspawn" ) == true )
	{
		player.message ( "Use /join " + teams[0].getname ( ) + " to join Team " + teams[0].getname ( ) + ", or use /join " + teams[1].getname ( ) + " to join Team " + teams[1].getname ( ), Red );
		setElementData ( player, "initspawn", false );
		SERVER.getworld ( ).spawnplayer ( player, -200.000, 300.000, 16.000 );
		player.setfrozen ( true );
	}
	else
	{
		player.giveweapon ( 15, 1000 );
		player.message ( "You have respawned! Good luck." );
	}
    return true;
}

registerCommand ( "join",
	function ( player, params )
	{
		if ( params.len ( ) < 1 )
			return false;
		
		if ( player.getusergroup ( ) == teams[0] || player.getusergroup ( ) == teams[1] )
			return player.message ( "You have already joined a team for this round. Ask a staff member if you have a reason to be moved." );
			
		if ( params[0] == teams[0].getname ( ) )
		{
			setPlayerUsergroup ( player, teams[0] );
			player.message ( "You have joined Team " + teams[0].getname ( ) + "!" );
			local spawnpoint = SERVER.getworld ( ).maphandler.getrandomspawn ( );
			if ( spawnpoint != false )
			{
				local pos = spawnpoint.getposition ( );
				player.setposition ( pos[0], pos[1], pos[2] );
			}
			else
				player.setposition ( -200.000, 300.000, 16.000 );
			
			player.setfrozen ( false );
		}
		else if ( params[0] == teams[1].getname ( ) )
		{
			setPlayerUsergroup ( player, teams[1] );
			player.message ( "You have joined Team " + teams[1].getname ( ) + "!" );
			local spawnpoint = SERVER.getworld ( ).maphandler.getrandomspawn ( );
			if ( spawnpoint != false )
			{
				local pos = spawnpoint.getposition ( );
				player.setposition ( pos[0], pos[1], pos[2] );
			}
			else
				player.setposition ( -200.000, 300.000, 16.000 );
			
			player.setfrozen ( false );
		}
		else
			player.message ( "Use /join " + teams[0].getname ( ) + " to join Team " + teams[0].getname ( ) + ", or use /join " + teams[1].getname ( ) + " to join Team " + teams[1].getname ( ) );
	},
	1
);

registerCommand ( "startrounds",
	function ( player, params )
	{
		onRoundStart ( );
		return true;
	},
	3
);

registerCommand ( "score",
	function ( player, params )
	{
		foreach ( id, team in teams )
		{
			local color = ( team.getname ( ) == "Red" ) ? 0xFF0000AA : 0x6495EDAA;
			player.message ( color + "" + team.getname ( ) +": " + 0xAFAFAFAA + getElementData ( team, "score" ) );
		}
		return true;
	},
	1
);

addEvent ( "playerDeath", onPlayerDeath );
addEvent ( "roundStart", onRoundStart );
addEvent ( "playerJoin", onPlayerJoin );

timer ( initGamemode, 500, 1 );