## Squirrel Syntax ##
**Returns an account instance if the account with the username or accountid exists, false otherwise.**

```
  array getAccounts ( )
```

## Example ##
> The following example logs all account usernames.

```
function logAccountNames ( )
{
    local accounts = getAccounts ( );
	foreach ( account in accounts )
		log ( "Account: " + getAccountUsername ( account ) );
}
```