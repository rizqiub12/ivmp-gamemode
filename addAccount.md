## Squirrel Syntax ##
**Returns an account instance if the account was created, false otherwise.**

```
  account addAccount ( string username, string password, [ string serial ], [ string ip ] )
```

## Example ##
> The following example demonstrates a command that returns a player's account after an account has been created.

```
registerCommand ( "register",
	function ( player, params )
	{
		local playerid = getPlayerId ( player );
        local account = addAccount ( getPlayerName ( playerid ), hashIntoPassword ( params[0] ), getPlayerSerial ( playerid ), getPlayerIp ( playerid ) );
		if ( account )
			return account;
		else
			return false;
	}
);
```