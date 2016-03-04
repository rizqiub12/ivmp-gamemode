
---

# Introduction #

> Welcome to [TheGhost's](http://forum.iv-multiplayer.com/index.php?action=profile;u=4055) open source ivmp project, [ServerCore](Main.md). I would like to thank you for your interest in using this code for your server and community. The goal is to provide a quality set of tools to allow servers to build and customize incredible servers for IVMP. I am always open for additional people to join the project, whether helping keep the documentation up to date or putting together bug fixes. Please do not hesitate from submitting [issues](http://code.google.com/p/ivmp-gamemode/issues/list) or providing [code feedback](http://code.google.com/p/ivmp-gamemode/issues/detail?id=1). I value input and everyone's contributions.

> ## About ##

> This resource serves as a foundation for basic features that enhance fundamental aspects of a server. Hence the name [ServerCore](Main.md). Ideally, this resource enables scripters to utilize key elements of game play that are not necessarily built into the default scripts package. While the resource is publicly and freely available, users of can be assured that individuality and customization are primary goals of this resource's development. Whether scripters are looking to customize simple aspects such adding additional maps, chat channels, or changing the method of account storage, or to build into a large scale community needing reliable core features, the resource provides an advanced-level core that will boost your server's capabilities. [ServerCore's](Main.md) main purpose is to provide large communities various features otherwise smaller 'indie' servers may not need.


---

# Features #

> ## Server Interface ##

> [ServerCore](Main.md) has numerous functional features. At the heart of the resource is a server    instance, which serves as the interface and handler for most of the resource. The server instance contains most other features such as command handling, chat server, accounts, game world management, etc. The server instance's easy to use member functions provide a wide range of possibilities.

> ## Account Management ##

> Managing accounts using [ServerCore](Main.md) keeps simple and integration at mind. Using a caching technique, [ServerCore](Main.md) retrieves account data from a range of storage methods, including MYSQL, SQLite, EasyINI, and XML. Once loaded, accounts can be modified easily along with account login and logout.

> ## Command Handling ##

> The command handling feature provides servers simpler command definition and management. Through a global function, [registerCommand](regsterCommand.md), server developers have the ability to assign a handle function to a command name, rather than checking conditionally during the command event. Integrated with the [ACS](ACS.md), commands can be restricted to certain user or admin groups.

> ## Chat Communication ##

> Player communication is an important aspect of gameplay. With [ServerCore](Main.md), developers can implement a ChatServer that provides separate channels. By default, the two channels enable public and admin communication. Furthermore, the ChatServer feature implements functionality with IRC and web-based client interaction.

> ## Maps ##

> The mapping feature allows .map files to be loaded and managed dependent on gamemode settings and the ACS. The map files are xml-based that store vehicle, blip, checkpoint, actor, object, spawnpoint, and custom element data.

> ## World Entities ##

> ## Admin and Remote Control Protocol ##

> ## Gamemode Extensions ##


---
