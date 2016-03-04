## Squirrel Syntax ##
**Returns the playerid integer of the specified player, false otherwise.**

```
  integer getPlayerId ( element player )
```

## Example ##
> The following example demonstrates how to get a playerid within a command handler and output it into the console log.

```
registerCommand ( "playerid",
	function ( player, params )
	{
		local playerid = getPlayerId ( player );
		log ( playerid.tostring ( ) );
	}

```