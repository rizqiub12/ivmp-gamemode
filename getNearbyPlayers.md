## Squirrel Syntax ##
**Returns an array with players that are within a specified distance. Default distance is 20 units.**

```
  array getNearbyPlayers ( array position )
```

## Example ##
This example demonstrates a command that gets all the players that are within 30 units of the user and outputs their names to the chatbox.

```

registerCommand ( "whoisnear",
	function ( player, params )
	{
		local players = getNearbyPlayers ( getElementPosition ( player ), 30 ); 
		
		if ( players.len ( ) < 1 )
			return sendPlayerMessage ( getPlayerId ( player ), "No nearby players!" );
		else
			sendPlayerMessage ( getPlayerId ( player ), "Nearby players:" );
		
		foreach ( _p in players )
			sendPlayerMessage ( getPlayerId ( player ), getPlayerName ( getPlayerId ( player ) ) );
	}
);
```