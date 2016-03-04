## Squirrel Syntax ##
**Returns true if the account password was changed, false otherwise.**

```
  bool setAccountPassword ( element account, string password )
```

## Example ##
> The following example sets the account's password to the specified string.

```
registerCommand ( "setpass",
	function ( player, params )
	{
		if ( !params[0] )
			return false;
			
        local account = getPlayerAccount ( player );
		if ( account )
		{
			setAccountPassword ( account, params[0] );
			sendPlayerMessage ( getPlayerId ( player ), "Account password set." );
		}
		else
			return false;
	}
);
```