## Squirrel Syntax ##
**Returns the element if created, false otherwise.**

```
  bool createElement ( string type, table data )
```

### Element Types ###
This function can be used to create the following types of elements.

| **Type** | **Data** |
|:---------|:---------|
| vehicle  | model, x, y, z, rx, ry, rz, color |
| object   | model, x, y, z |
| blip     | model, x, y, z |
| checkpoint | model, x, y, z, tx, ty, tz |
| pickup   | model, x, y, z |
| ped      | model, x, y, z, rot |
| spawnpoint | x, y, z  |
| house    | // not yet implemented |

You must send a table with the correct keys as the data parameter.

## Example ##

```
function createVehicleCommand ( player, params )
{
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
		color = [ getRandomNumber ( 1, 137 ) - 1, getRandomNumber ( 1, 137 ) - 1, getRandomNumber ( 1, 137 ) - 1, getRandomNumber ( 1, 137 ) - 1 ],
		pos = [ ]
	};
	
	if ( isPlayerDriving ( player ) )
		data.pos = getElementPosition ( getPlayerVehicle ( player ) );
	else
		data.pos = getElementPosition ( player );
		
	local vehicle = createElement ( "vehicle", data );
	sendMessageToAll ( getPlayerName ( getPlayerId ( player ) ) + " has spawned a " + getVehicleName ( data.model ) );
}

registerCommand ( "createvehicle", createVehicleCommand ); 
```