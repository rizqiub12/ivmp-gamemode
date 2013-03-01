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
 
registerCommand ( "createvehicle", 
	function ( player, params )
	{
		if ( params.len ( ) > 1 )
			params = params[0];
		
		local pos = positionInFront ( getElementPosition ( player ), getElementRotation ( player ), 10, 5 );
		data <- {
			model = params[0].tointeger ( ),
			x = pos[0],
			y = pos[1],
			z = pos[2],
			rz = getElementRotation ( player ),
			ry = 0.0,
			rx = 0.0,
			lock = false,
			color = [ 0, 0, 0, 0 ],
			pos = [ ]
		};
		
		if ( isPlayerDriving ( player ) )
			data.pos = getElementPosition ( getPlayerVehicle ( player ) );
		else
			data.pos = getElementPosition ( player );
			
		local vehicle = createElement ( "vehicle", data );
		sendMessageToAll ( getPlayerName ( getPlayerId ( player ) ) + " has spawned a " + getVehicleName ( data.model ) );
	}
);

registerCommand ( "startengine", 
	function ( player, params )
	{
		
		if ( !isPlayerDriving ( player ) )
		{
			sendPlayerMessage ( getPlayerId ( player ), "You are not in a vehicle!" );
			return;
		}
		
		local vehicle = getPlayerVehicle ( player );
		vehicle.startengine ( );		
	},
	1
);

registerCommand ( "stopengine", 
	function ( player, params )
	{
		
		if ( !isPlayerDriving ( player ) )
		{
			sendPlayerMessage ( getPlayerId ( player ), "You are not in a vehicle!" );
			return;
		}
		
		local vehicle = getPlayerVehicle ( player );
		vehicle.stopengine ( );		
	},
	1
);

registerCommand ( "setcolor",
	function ( player, params )
	{
		local vehicle = getPlayerVehicle ( player );
		if ( !vehicle )
			return sendPlayerMessage ( getPlayerId ( player ), "You are not in a vehicle!" );
			
		if ( params.len ( ) < 4 )
			return player.messge ( "Use /setcolor [c1] [c2] [c3] [c4]" );
		
		return vehicle.setcolor ( params[0].tointeger ( ), params[1].tointeger ( ), params[2].tointeger ( ), params[3].tointeger ( ) );
	},
	1
);