package;

import Sys.sleep;
import discord_rpc.DiscordRpc;

#if LUA_ALLOWED
import llua.Lua;
import llua.State;
#end

using StringTools;

class DiscordClient
{
	public static var isInitialized:Bool = false; // Sets the current initialization to a set false
	public function new()
		//Starts up the client
	{
		trace("Starting up the Discord Client starting...");
		DiscordRpc.start({
			clientID: "967112173455290388",
			onReady: onReady,
			onError: onError,
			onDisconnected: onDisconnected
		});
		trace("Discord Client has successfully started.");

		while (true)
		{
			DiscordRpc.process();
			sleep(2);
			//Don't trace anything here, it will just overflood the logs
		}

		DiscordRpc.shutdown();
	}
	
	public static function shutdown()
		// Just shutting down the Client shit
	{
		DiscordRpc.shutdown();
	}
	
	static function onReady()
		// When the client is ready this is what is going to be displayed.
	{
		DiscordRpc.presence({
			details: "In the VS Lego Movie Menus",
			state: null,
			largeImageKey: 'icon',
			largeImageText: "VS Lego Movie"
		});
	}

	static function onError(_code:Int, _message:String)
		// Whenever something is errored, this is where it will be called at.
	{
		trace('There has been an error! Code : $_code Message : $_message');
	}

	static function onDisconnected(_code:Int, _message:String)
		// Whenever the client disconnects, this is where it will be called at.
	{
		trace('Disconnected! Code : $_code Message : $_message');
	}

	public static function initialize()
		//This is when the client is initialized.
	{
		var DiscordDaemon = sys.thread.Thread.create(() ->
		{
			new DiscordClient();
		});
		trace("Discord Client initialized");
		isInitialized = true;
	}

	public static function changePresence(details:String, state:Null<String>, ?smallImageKey : String, ?hasStartTimestamp : Bool, ?endTimestamp: Float)
		// This basically updates the presence of the Client to display the current state, details, update the large ImageKey, text, timestamps, etc
	{
		var startTimestamp:Float = if(hasStartTimestamp) Date.now().getTime() else 0;

		if (endTimestamp > 0)
		{
			endTimestamp = startTimestamp + endTimestamp;
		}

		DiscordRpc.presence({
			details: details,
			state: state,
			largeImageKey: 'icon', // This will be changed later when we have the icons for the songs.
			largeImageText: "Mod Version: " + MainMenuState.CurrentVersionOfMod,
			smallImageKey : smallImageKey,
			// Obtained times are in milliseconds so they are divided so Discord can use it
			startTimestamp : Std.int(startTimestamp / 1000),
            endTimestamp : Std.int(endTimestamp / 1000)
		});
	}
		//Don't trace anything. No overflooding