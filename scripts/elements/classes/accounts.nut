/*
 * Copyright (c) 2013, TheGhost
 *
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 *     * Redistributions of source code must retain the above copyright notice, this
 *       list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright notice, this
 *       list of conditions and the following disclaimer in the documentation and/or other
 *       materials provided with the distribution.
 *     * Neither the name of the product nor the names of its contributors may be used
 *       to endorse or promote products derived from this software without specific prior
 *       written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

// THE ACCOUNTHANDLER CLASS IS A MEMBER VARIABLE OF THE SERVER INSTANCE. THIS CLASS ONLY HAS A SINGLE INSTANCE AND ACTS AS THE INTERFACE WHICH FOR ALL ACCOUNT INSTANCES.

class AccountHandler
{

	mt_accounts = [ ];
	_sqlite = false;
	
	constructor ( )
	{		
		local _type = SERVER.getconfig ( ).acctype.tointeger ( );
		if ( _type == 0 )
		{
			local usertable = SERVER.getconfig ( ).usertable;
			local grouptable = SERVER.getconfig ( ).grouptable;
			local statstable = SERVER.getconfig ( ).statstable;
			
			if ( SERVER.getconfig ( ).dbtype.tointeger ( ) == 0 )
			{
				sql.create_table( usertable, [
					{ name = "id", type = "int(11) unsigned", primary_key = true, auto_increment = true },
					{ name = "username", type = "varchar(32)" },
					{ name = "password", type = "varchar(32)" },
					{ name = "serial", type = "varchar(32)" },
					{ name = "ip", type = "varchar(32)" },
					{ name = "salt", type = "varchar(32)" },
					{ name = "email", type = "varchar(32)" },
					{ name = "usergroup", type = "tinyint(3) unsigned", defaultv = 1 },
					{ name = "admin", type = "tinyint(3) unsigned", defaultv = 1 },
					{ name = "timeplayed", type = "tinyint(3) unsigned", defaultv = 0 }
				] );
						
				sql.create_table( grouptable, [
					{ name = "id", type = "int(11) unsigned", primary_key = true, auto_increment = true },
					{ name = "groupname", type = "varchar(32)" }
				] );
				
				sql.create_table( statstable, [
					{ name = "id", type = "int(11) unsigned", primary_key = true, auto_increment = true },
					{ name = "kills", type = "tinyint(3) unsigned", defaultv = 0 },
					{ name = "deaths", type = "tinyint(3) unsigned", defaultv = 0 },
					{ name = "killstreak", type = "tinyint(3) unsigned", defaultv = 0 },
					{ name = "money", type = "tinyint(3) unsigned", defaultv = 0 },
					{ name = "racewins", type = "tinyint(3) unsigned", defaultv = 0 },
					{ name = "exp", type = "tinyint(3) unsigned", defaultv = 0 }
				] );
			}
		}
		else if ( _type == 1 )
		{
		
		}
		else if ( _type == 2 )
		{
			
		}
		else if ( _type == 3 )
		{
			_sqlite = sqlite_open ( "files/accounts/accounts.db" );
			//sqlite_query ( _sqlite, "CREATE TABLE users ( id int, username varchar ( 32 ), password varchar ( 32 ), salt varchar ( 12 ), serial varchar ( 32 ), ip varchar ( 32 ), email varchar ( 64 ), timeplayed int, usergroup int, admin int )" );
		}
	}
	
	function initaccounts ( )
	{
		local _type = SERVER.getconfig ( ).acctype.tointeger ( );
		if ( _type == 0 )
		{
			local accounts = sql.query_assoc ( "SELECT * FROM " + SERVER.getconfig ( ).usertable );
			foreach ( account in accounts )
			{
				local stats = sql.query_assoc ( "SELECT * FROM " + SERVER.getconfig ( ).statstable + " WHERE id = " + account.id.tointeger ( ) + "" );
				if ( !stats )
					addaccount ( account, { kills = 0, deaths = 0, killstreak = 0, money = 0, exp = 0, racewins = 0 } );
				else
					addaccount ( account, stats[0] );
			}
		}
		else if ( _type == 1 )
		{	
			local d = Directory ( );
			foreach ( idx, filename in d.getDirectory ( "../files/accounts/" ) ) 
			{
				local xfile = xml ( "accounts/" + filename );
				xfile.nodeFind ( "userdata" );
				local account = { };
				
				account.username <- xfile.nodeAttribute ( "username" );
				account.password <- xfile.nodeAttribute ( "password" );
				account.ivmpserial <- xfile.nodeAttribute ( "serial" );
				account.ip <- xfile.nodeAttribute ( "ip" );
				account.email <- xfile.nodeAttribute ( "email" );
				account.id <- xfile.nodeAttribute ( "id" ).tointeger ( );
				account.admin <- xfile.nodeAttribute ( "admin" ).tointeger ( );
				account.salt <- xfile.nodeAttribute ( "salt" );		
				account.usergroup <- xfile.nodeAttribute ( "usergroup " ).tointeger ( );
				account.timeplayed <- xfile.nodeAttribute ( "timeplayed" ).tointeger ( );
				addaccount ( account );
			}
		}
		else if ( _type == 2 )
		{
			local d = Directory ( );
			foreach ( idx, filename in d.getDirectory ( "../files/accounts/" ) ) 
			{
				local ini = EasyINI ( "/accounts/" + filename );
				local account = { };
				local stats = { };
				
				account.username <- ini.getKey ( "userdata", "username" ),
				account.password <- ini.getKey ( "userdata", "password" );
				account.ivmpserial <- ini.getKey ( "userdata", "serial" );
				account.ip <- ini.getKey ( "userdata", "ip" );
				account.email <- ini.getKey ( "userdata", "email" );
				account.id <- ini.getKey ( "userdata", "id" );
				account.admin <- ini.getKey ( "userdata", "admin" );
				account.salt <- ini.getKey ( "userdata", "salt" );
				account.usergroup <- ini.getKey ( "userdata", "usergroup" );
				account.timeplayed <- ini.getKey ( "userdata", "timeplayed" );
				
				stats.kills <- ini.getKey ( "userstats", "kills" );
				stats.killstreak <- ini.getKey ( "userstats", "killstreak" );
				stats.deaths <- ini.getKey ( "userstats", "deaths" );
				stats.money <- ini.getKey ( "userstats", "money" );
				stats.exp <- ini.getKey ( "userstats", "exp" );
				stats.racewins <- ini.getKey ( "userstats", "racewins" );
				
				addaccount ( account, stats );
			}
		}
		else if ( _type == 3 )
		{
			local result = sqlite_query ( _sqlite, "SELECT * from users" );
			
			local tmp = true;
			while ( tmp == true )
			{
				local account = { };
				account.id <- sqlite_column_data ( result, 0, 0 );
				account.username <- sqlite_column_data ( result, 1, 0 );
				account.password <- sqlite_column_data ( result, 2, 0 );
				account.salt <- sqlite_column_data ( result, 3, 0 );
				account.ivmpserial <- sqlite_column_data ( result, 4, 0 );
				account.ip <- sqlite_column_data ( result, 5, 0 );
				account.email <- sqlite_column_data ( result, 6, 0 );
				account.timeplayed <- sqlite_column_data ( result, 7, 0 );
				account.usergroup <- sqlite_column_data ( result, 8, 0 );
				account.admin <- sqlite_column_data ( result, 9, 0 );
				addaccount ( account );
				tmp = sqlite_next_row ( result );
			}
			sqlite_free ( result );
		}
	}
	
	function getaccounts ( )
	{
		return mt_accounts;
	}
	
	function getaccount ( var )
	{
		if ( typeof ( var ) == "string" )
		{
			foreach ( account in mt_accounts )
			{
				if ( account.getusername ( ) == var )
					return account;
			}
		}
		else if ( typeof ( var ) == "integer" )	
			return mt_accounts [ var ];
	
		return false;
	}
	
	function addaccount ( accountdata, stats = false )
	{
		if ( getaccount ( accountdata.username ) != false )
			return false;
		
		local account = Account ( accountdata, stats );
		mt_accounts.push ( account );
		return account;
	}
	
	function insertaccount ( username, pass, serial, ip )
	{
		local _type = SERVER.getconfig ( ).acctype.tointeger ( );
		local hashed = SERVER.util.hashforpass ( pass );
		local n = mt_accounts.len ( ) + 1;
		local t = {
			username = username.tostring ( ), 
			password = hashed[0].tostring ( ),
			salt = hashed[1],
			ivmpserial = serial.tostring ( ), 
			ip = ip.tostring ( ),
			id = n.tostring ( ),
			usergroup = 1,
			admin = 0,
			timeplayed = 0,
			email = "none"
		};

		if ( _type == 0 )
		{
			t.id = sql.query_insertid ( "INSERT into " + SERVER.getconfig ( ).usertable + " ( username, password, serial, ip, salt ) VALUES ( '" + sql.esacpe ( t.username ) + "', '" + sql.escape ( t.password ) + "', '" + t.serial + "', '" + t.ip + "', '" + t.salt + "' )" );
			if ( !t.id )
				return false;
			local result_2 = sql.query_insertid ( "INSERT into " + SERVER.getconfig ( ).statstable + " ( exp ) VALUES ( 0 )" );
		}
		else if ( _type == 1 )
		{
			local xfile = xml ( "accounts/accounts.xml" );
			xfile.nodeFind ( "accounts" );
			xfile.nodeFirstChild ( );
			xfile.nodeNew ( true, "account" );
			xfile.nodeSetAttribute ( "id", t.id );
			xfile.nodeSetAttribute ( "username", t.username );
			xfile.nodeSetAttribute ( "password", t.password );
			xfile.nodeSetAttribute ( "admin", t.admin.tostring ( ) );
			xfile.nodeSetAttribute ( "serial", t.ivmpserial );
			xfile.nodeSetAttribute ( "salt", t.salt );
			xfile.nodeSetAttribute ( "ip", t.ip );
			xfile.nodeSetAttribute ( "email", t.email );
			xfile.nodeSetAttribute ( "usergroup", t.usergroup.tostring ( ) );
			xfile.nodeSetAttribute ( "timeplayed", t.timeplayed.tostring ( ) );
			xfile.nodeRoot ( );
			xfile.save ( );
		}
		else if ( _type == 2 )
		{
			local ini = EasyINI ( "accounts/" + t.username + ".account" );
			ini.setKey ( "userdata", "username", t.username );
			ini.setKey ( "userdata", "password", t.password );
			ini.setKey ( "userdata", "admin", t.admin.tostring ( ) );
			ini.setKey ( "userdata", "serial", t.ivmpserial );
			ini.setKey ( "userdata", "salt", t.salt );
			ini.setKey ( "userdata", "ip", t.ip );
			ini.setKey ( "userdata", "id", t.id );
			ini.setKey ( "userdata", "email", t.email );
			ini.setKey ( "userdata", "usergroup", t.usergroup.tostring ( ) );
			ini.setKey ( "userdata", "timeplayed", t.timeplayed.tostring ( ) );
			
			ini.setKey ( "userstats", "kills", "0" );
			ini.setKey ( "userstats", "deaths", "0" );
			ini.setKey ( "userstats", "killstreak", "0" );
			ini.setKey ( "userstats", "money", "0" );
			ini.setKey ( "userstats", "exp", "0" );
			ini.setKey ( "userstats", "racewins", "0" );
			
			ini.saveData ( );
		}
		else if ( _type == 3 )
		{
			local result = sqlite_query ( _sqlite, "INSERT INTO users ( id, username, password, salt, serial, ip, email, timeplayed, usergroup, admin ) VALUES ( " + t.id.tointeger ( ) + ", '" + t.username + "', '" + t.password + "', '" + t.salt + "', '" + t.ivmpserial + "', '" + t.ip + "', '" + t.email + "', " + t.timeplayed.tointeger ( ) + ", " + t.usergroup.tointeger ( ) + ", " + t.admin.tointeger ( ) + " )" );
		}

		local account = addaccount ( t );
		callEvent ( "accountCreate", account );
		return account;
	}
	
};

class Account extends Element
{

	ms_username = "";
	ms_password = "";
	ms_ip = false;
	ms_serial = false;
	player = false;
	usergroup = false;
	admin = 0;
	salt = false;
	timeplayed = 0;
	stats = { kills = 0, deaths = 0, killstreak = 0, money = 0, exp = 0, racewins = 0 };
	profile = false;
	
	constructor ( account, t )
	{
		this.id = account.id;
		ms_username = account.username;
		ms_password = account.password;
		ms_ip = account.ip;
		ms_serial = account.ivmpserial;
		this.admin = account.admin;
		this.usergroup = account.usergroup;
		this.salt = account.salt;
		this.timeplayed = account.timeplayed;
		this.type = "account";
		this.profile = Profile ( this );
		if ( t != false )
		{
			this.stats.kills = t.kills.tointeger ( );
			this.stats.deaths = t.deaths.tointeger ( );
			this.stats.killstreak = t.killstreak.tointeger ( );
			this.stats.exp = t.exp.tointeger ( );
			this.stats.racewins = t.racewins.tointeger ( );
			this.stats.money = t.money.tointeger ( );
		}
	}
	
	function getusername ( )
	{
		return ms_username;
	}

	function getpassword ( )
	{
		// Password is hashed
		return ms_password;
	}	
	
	function setpassword ( newpass )
	{
		local _type = SERVER.getconfig ( ).acctype.tointeger ( );
		local pass = SERVER.util.hashforpass ( newpass );
		if ( _type == 0 )
		{
			local result = sql.query_assoc ( "UPDATE " + SERVER.getconfig ( ).usertable + " SET password = '" + pass[0] + "', salt = '" + pass[1] + "' WHERE `id` = " + this.id + "" );
			if ( result )
			{
				this.ms_password = pass;
				this.salt = pass[1];
				return true;
			}
		}
		else if ( _type == 1 )
		{
			
		}
		else if ( _type == 2 )
		{
			local ini = EasyINI ( "accounts/" + this.ms_username + ".account" );
			ini.setKey ( "userdata", "password", pass[0] );
			ini.setKey ( "userdata", "salt", pass[1] );
			ini.saveData ( );
			this.ms_password = pass[0];
			this.salt = pass[1];
			return true;
		}
		else if ( _type == 2 )
		{
			local result = sqlite_query ( SERVER.getaccounthandler ( )._sqlite, "UPDATE user SET password = '" + pass[0] + "', salt = '" + pass[1] + "' WHERE
			username = '" + ms_username + "'" );
			this.ms_password = pass[0];
			this.salt = pass[1];
		}
		return false;
	}
	
	function updateaccount ( )
	{
		local _type = SERVER.getconfig ( ).acctype.tointeger ( );
		if ( _type == 0 )
		{
			local result = sql.query_assoc ( "UPDATE " + SERVER.getconfig ( ).usertable + " SET timeplayed = " + this.timeplayed + " WHERE `id` = " + this.id + "" );
			if ( result )
			{
				result = sql.query_assoc ( "UPDATE " + SERVER.getconfig ( ).statstable + " SET kills = " + this.stats.kills + ", deaths = " + this.stats.deaths + ", killstreak = " + this.stats.killstreak + ", money = " + this.stats.money + ", exp = " + this.stats.exp + ", racewins = " + this.stats.racewins + " WHERE `id` = " + this.id + "" );
				if ( result )
					return true;
			}
		}
		else if ( _type == 1 )
		{
		
		}
		else if ( _type == 2 )
		{
			local ini = EasyINI ( "accounts/" + this.ms_username + ".account" );
			ini.setKey ( "userstats", "kills", this.stats.kills.tostring ( ) );
			ini.setKey ( "userstats", "deaths", this.statsdeaths.tostring ( ) );
			ini.setKey ( "userstats", "killstreak", this.stats.killstreak.tostring ( ) );
			ini.setKey ( "userstats", "money", this.stats.money.tostring ( ) );
			ini.setKey ( "userstats", "exp", this.stats.exp.tostring ( ) );
			ini.setKey ( "userstats", "racewins", this.stats.racewins.tostring ( ) );
			ini.saveData ( );
		}
		return false;
	}
	
	function assignplayer ( player )
	{
		this.player = player;
		return true;
	}
	
	function unassignplayer ( )
	{
		this.player = false;
		return true;
	}
	
	function updateminute ( )
	{
		this.timeplayed++;
		return true;
	}
	function inuse ( )
	{
		if ( this.player == false )
			return false;
		else
			return true;
	}
	
	function getusergroup ( )
	{
		return usergroup;
	}
	
	function getadminlevel ( )
	{
		return admin;
	}
	
	function getserial ( )
	{
		return mi_serial;
	}
	
	function getip ( )
	{
		return mi_ip;
	}
	
};

class Profile
{
	
	account = false;
	badges = [ 
		// ID = 0, This badge is given after 1 hour of time played in server.
		{ name = "First Hour", state = false }
	];
	friends = [ ];
	status = "";
	clan = false;
	social = { twitter = false, facebook = false };
	
	constructor ( account, data )
	{
		this.account = account;
	}
	
	function addbadge ( badgeid )
	{
		local badge = this.badges[ badgeid ];
		if ( badge )
		{
			badge.state = true;
			return true;
		}
		return false;
	}
	
	function countbadges ( )
	{
		local i = 0;
		foreach ( badge in badges )
		{
			if ( badge.state == true )
				i++;
		}
		return i;
	}
	
	function setstatus ( text )
	{
		if ( typeof ( text ) != "string" )
			return false;
			
		this.status = text;
		return true;
	}
	
	function addfriend ( account )
	{
		local f = this.friends.find ( account.getid ( ) );
		if ( f )
			return false;
		return this.friends.push ( account.getid ( ) );
	}
	
};