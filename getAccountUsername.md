## Squirrel Syntax ##
**Returns the username string of the account, false otherwise.**

```
  string getAccountUsername ( element account )
```

## Example ##
> The following example logs the username for the account that playerid is logged into.

```
function logAccountName ( playerid )
{
	local player = getPlayer ( playerid );
    local account = getPlayerAccount ( player );
	log ( "Account: " + getAccountUsername ( account ) );
}
```