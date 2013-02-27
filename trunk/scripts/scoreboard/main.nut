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

class Scoreboard
{
	columns = [ ];
	items = { teams = [ ], players = [ ] };
	
	function addcolumn ( name )
	{
		if ( !columns.find ( name ) )
			columns.push ( name );
	}
	
	function removecolumn ( name )
	{
		local id = columns.find ( name );
		if ( id )
			columns.remove ( id );
	}
	
	function additem ( element )
	{
		if ( element.gettype ( ) == "player" )
		{
			local item = { id = element.getid ( ), name = element.getname ( ) };
			if ( getGamemodeName ( ) == "tdm" || getGamemodeName ( ) == "freeroam" )
			{
				item.kills <- element.stats.kills;
				deaths <- element.stats.deaths; 
			}
			
			items.players.push ( item );
		}
		else if ( element.gettype ( ) == "usergroup" )
		{
			local item = { name = element.getname ( ) };
			if ( getGamemodeName ( ) == "tdm" ) 
				item.score <- element.getdata ( "score" );
			
			items.teams.push ( item );
		}
	}
	
	function senddata ( )
	{
		foreach ( id, player in SERVER.getworld ( ).getplayers ( ) )
		{
			if ( player )
			{
				triggerClientEvent ( player.getid ( ), "onServerSendData", columns, items );
			}
		}
	}
	
};