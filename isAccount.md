## Squirrel Syntax ##
**Returns true if the variable is an account, false otherwise.**

```
  bool isAccount ( element account )
```

## Example ##

```
function foo ( variable )
{
	if ( isAccount ( variable ) )
		log ( "It's an account!" );
	else
		log ( "It's not an account!" );
}
```