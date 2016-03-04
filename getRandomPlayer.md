## Squirrel Syntax ##
**Returns an player instance.**

```
  element getRandomPlayer ( )
```

## Example ##
```
registerCommand ( "randomkill",
	function ( player, params )
	{
		local _p = getRandomPlayer ( );
		killPlayer ( _p );
	}
);
```