## Squirrel Syntax ##
**Returns true if the player is muted, false otherwise.**

```
  bool isPlayerMuted ( element player )
```

## Example ##

```
registerCommand ( "listmuted",
	function ( player, params )
	{
		foreach ( id, name in getPlayers ( ) )
		{
			if ( isPlayerConnected ( id ) )
			{
				local _p = getPlayer ( id );
				if ( isPlayerMuted ( _p ) )
					player.message ( getPlayerName ( id ) + " is muted." );
			}
		}
	}
);
```