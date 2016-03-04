## Squirrel Syntax ##
**Returns true if the player is logged in, false otherwise.**

```
  bool isPlayerLoggedIn ( element player )
```

## Example ##

```
function foo ( playerid )
{
	local player = getPlayer ( playerid );
	if ( isPlayerLoggedIn ( player ) )
	{
		local account = getPlayerAccount ( player );
		return sendPlayerMessage ( playerid, "Your account username: " + getAccountUsername ( account ) );
	}
	else
		return sendPlayerMessage ( playerid, "You are not logged in." );
}
```