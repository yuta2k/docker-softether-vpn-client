# Lightweight Softether VPN Client

This docker only contains a working **SoftEther VPN Client** other components have been removed.

If you need other parts :
* [SoftEther VPN Bridge][bridge-link]
* [SoftEther VPN CMD][cmd-link]
* [SoftEther VPN Server][server-link]
___

# What is SoftEther VPN Client
> SoftEther VPN Client is VPN client software with a Virtual Network Adapter function that enables connection to a Virtual Hub on SoftEther VPN Server operated at a remote location. The user can use the easy settings on a computer with SoftEther VPN Client installed to connect to a Virtual Hub on SoftEther VPN Server and flexibly connect via a Virtual Network Adapter.

[https://www.softether.org/4-docs/1-manual/4._SoftEther_VPN_Client_Manual](https://www.softether.org/4-docs/1-manual/4._SoftEther_VPN_Client_Manual)

# About this image
Versions will follow [Softether VPN Github Repository][softether-repository] tags and [Alpine][alpine-link] update.

This image is make'd from [the offical Softether VPN Github Repository][softether-repository]

Nothing have been edited. So when you will start it the first time you will get the default configuration which is :
* Unconfigured client

You will have to configure it. To do so use :
* [SoftEther VPN CMD][cmd-link] (any platform - Console)
* [SoftEther VPN Server Manager][softether-download] (Windows, Mac OS X - GUI)
* Edit by hand /usr/vpnclient/vpn_client.config then restart the server (Not Recommended)

# How to use this image
For a simple use without persistence :
```
docker run -d amary/softether-vpn-client
```
For a simple use with persistence (will give you acces to configuration and logs) :
```
docker run -d -v /host/path/vpnclient:/usr/vpnclient:Z amary/softether-vpn-client
```
Add/delete any ```-p $PORT:$PORT/{tcp,udp} depending on you will ```

