## Squirrel Syntax ##
**Returns the _hashed_ password string, false otherwise. The password is hashed according to the config's account type. Default is is MD5.**

```
  bool getAccountPassword ( element account )
```

## Example ##
> The following example returns the account's password and checks if it is equal to the hashed version of the command parameter.

```
registerCommand ( "ispass",
	function ( player, params )
	{
		if ( !params[0] )
			return false;
			
        local account = getPlayerAccount ( player );
		if ( account )
		{
			local pass = getAccountPassword ( account );
			if ( pass = hashIntoPassword ( params[0] ) )
				sendPlayerMessage ( "You entered the correct password." );
			else
				sendPlayerMessage ( "You entered an incorrect password." );
		}
		else
			return false;
	}
);
```