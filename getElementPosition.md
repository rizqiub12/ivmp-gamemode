## Squirrel Syntax ##
**Returns an array of floats representing x, y, z of the specified element's coordinates, false otherwise.**

```
  array getElementPosition ( element element )
```

## Example ##

```
function sendMessageToNearPlayers ( player )
{
	local pos = getElementPosition ( player );
	local players = getNearbyPlayers ( pos );
	foreach ( _p in players )
		sendPlayerMessage ( getPlayerId ( _p ), "You are near " + getPlayerName ( getPlayerId ( player ) ) );
}
```
local objective = createElement ( "pickup", { model = 3, x = 0.0, y = 0.0, z = 0.0 } );

function isNearObjective ( player )
{
	local o_pos = getElementPosition ( objective );
	if ( areElementsNearby ( player, o_pos, 20 ) )
		return sendPlayerMessage ( getPlayerId ( player ), "You are near the objective." );
	else
		return sendPlayerMessage ( getPlayerId ( player ), "You are more than 20 units away from the objective." );
}
}}]```