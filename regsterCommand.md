## Squirrel Syntax ##
bool registerCommand ( string command, function handler ( element player, array parameters )

### Returns ###
**Returns 'true' if the command is added, 'false' otherwise. The handler function parameters are first the player element that used the command, followed by an array of the remaining parameters that the player used in the command.**

## Example ##
These two examples demonstrate adding the command /myteam. There are two ways to designate a command handler. First, the function handle is defined in the second parameter. The second example demonstrates using a function that has already been defined.

```
registerCommand ( "myteam",
	function ( player, params )
	{
        local team = getPlayerUsergroup ( player );
        local teamname = getUsergroupName ( team );
		player.message ( "Your team: " + teamname, Gray );
	}
);
```

```
function outputPlayerTeam ( player, params )
{
    local team = getPlayerUsergroup ( player );
    local teamname = getUsergroupName ( team );
    player.message ( "Your team: " + teamname, Gray );
}

registerCommand ( "myteam", outputPlayerTeam );
```