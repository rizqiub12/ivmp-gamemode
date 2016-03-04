## Squirrel Syntax ##
**Returns true if the player was logged out of their account, false otherwise.**

```
  bool logoutPlayer ( element player )
```

## Example ##

```
registerCommand ( "logout",
	function ( player, params )
	{
		if ( !isPlayerLoggedIn ( player ) )
			return sendPlayerMesssage ( getPlayerId ( player ), "You are not logged into any account!" );
		
		local account = getPlayerAccount ( player );
		if ( account )
			logoutPlayer ( player, account );
		else
			return;
	}
);
```