## Squirrel Syntax ##
**Returns an account instance if the account with the username or accountid exists, false otherwise.**

```
  account getAccount ( string username or int accountid )
```

## Example ##
> The following example demonstrates a command that returns a player's account data when the account equals the player's name.

```
registerCommand ( "myaccount",
	function ( player, params )
	{
                local account = getAccount ( player.getname ( ) );
		if ( account )
			return getAccountData ( account );
		else
			return false;
	}
);
```