## Squirrel Syntax ##
**Returns true if the player was logged into the account, false otherwise.**

```
  bool loginPlayer ( element player, element account )
```

## Example ##

```
registerCommand ( "login",
	function ( player, params )
	{
		local username = false;
		local password = false;
		
		if ( isPlayerLoggedIn ( player ) )
			sendPlayerMessage ( getPlayerId ( player ), "You are already logged in!" );
		
		if ( params.len ( ) < 2 )
			return sendPlayerMessage ( getPlayerId ( player ), "/login <username> <password>" );
		else
		{		
			username = params[0];
			password = hashIntoPassword ( params[1] );
		}
		
		local account = getAccount ( username );
		if ( !account )
			return sendPlayerMessage ( getPlayerId ( player ), "An account with the username, " + username + ", does not exist!" );
		
		if ( password == getAccountPassword ( account ) )
			loginPlayer ( player, account );	
		else
			return sendPlayerMessage ( getPlayerId ( player ), "Invalid password!" );
			
	}
);
```