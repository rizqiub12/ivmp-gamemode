# Introduction #

Managing accounts using ServerCore keeps simple and integration at mind. Using a caching technique, ServerCore retrieves account data from a range of storage methods, including MYSQL, SQLite, EasyINI, and XML. Once loaded, accounts can be modified easily along with account login and logout.

# Implemention #

Choosing which method of account storage can be tricky, however, there are key differences that separate each other an help ease your decision. The  most advanced of these, and the default option, is MYSQL. Accounts using MYSQL are easy to implement and all settings can be set in the ServerCore configuration file. When implementing MYSQL accounts, make sure you have the correct MYSQL server the configuration file and the server is accessible. MYSQL accounts can easily be managed by thrid party web-api's such as phpMyAdmin. With phpMyAdmin, account data can be modified by server administrators as neccessary and provide for a convienent way to edit accounts outside of the IVMP Server. For a complete installation of MYSQL and phpMyAdmin, TheGhost's recommendation is XAMMP, found here.

The following are a list of functions included with ServerCore. No matter which method of account storage you may choose, these functions remain the same.

# Account Functions #

  * [getAccount](getAccount.md)
  * [getAccounts](getAccounts.md)
  * [isAccount](isAccount.md)
  * [addAccount](addAccount.md)
  * [loginPlayer](loginPlayer.md)
  * [logoutPlayer](logoutPlayer.md)
  * [getPlayerAccount](getPlayerAccount.md)
  * [isPlayerLoggedIn](isPlayerLoggedIn.md)
  * [getAccountUsername](getAccountUsername.md)
  * [setAccountUsername](setAccountUsername.md)
  * [getAccountPassword](getAccountPassword.md)
  * [setAccountPassword](setAccountPassword.md)
  * [getAccountData](getAccountData.md)
  * [setAccountData](setAccountData.md)