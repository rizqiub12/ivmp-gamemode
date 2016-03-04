## Squirrel Syntax ##
**Returns the account instance of the specified player, false otherwise.**

```
  bool getPlayerAccount ( element player )
```

## Example ##
> The following example returns an account for the player with playerid and adds +1 death to account data.

```
function foo ( playerid )
{
	local player = getPlayer ( playerid );
	local account = getPlayerAccount ( player );
	return account;
}

addEvent ( "playerDeath",
	function ( playerid, killerid, weaponid, vehicleid )
	{
		local account = foo ( playerid );
		setAccountData ( account, "deaths", getAccountData ( account, "deaths" ) + 1 );
	}
);
```