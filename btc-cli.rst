===========================
bitcoin-cli Manual Page
===========================

:Version: v28.1.0
:Date: December 2024
:Software: Bitcoin Core RPC client

Synopsis
========

.. code-block:: bash

    bitcoin-cli [options] <command> [params]
    bitcoin-cli [options] -named <command> name=value...
    bitcoin-cli [options] help
    bitcoin-cli [options] help <command>

Description
===========

Bitcoin Core RPC client version v28.1.0.  
Use this CLI to send commands to a Bitcoin Core node.

Options
=======

- **-?** : Print this help message and exit.
- **-addrinfo** : Get the number of addresses known to the node per network and total.
- **-color=<when>** : Color setting for CLI output. Valid values: always, auto (default), never.
- **-conf=<file>** : Specify configuration file (default: bitcoin.conf).
- **-datadir=<dir>** : Specify data directory.
- **-generate [nblocks] [maxtries]** : Generate blocks (regtest/signet only).
- **-getinfo** : Get general information from the server.
- **-named** : Pass named instead of positional arguments.
- **-netinfo [level]** : Get network peer connection information.
- **-rpcclienttimeout=<n>** : Timeout in seconds for HTTP requests (default: 900).
- **-rpcconnect=<ip>** : Connect to a node at this IP (default: 127.0.0.1).
- **-rpccookiefile=<loc>** : Location of authentication cookie.
- **-rpcpassword=<pw>** : Password for JSON-RPC connections.
- **-rpcport=<port>** : Connect to JSON-RPC on this port (default 8332 mainnet).
- **-rpcuser=<user>** : Username for JSON-RPC connections.
- **-rpcwait** : Wait for RPC server to start.
- **-rpcwaittimeout=<n>** : Timeout in seconds to wait for RPC server (default: 0).
- **-rpcwallet=<walletname>** : Send RPC to a specific wallet.
- **-stdin** : Read extra arguments from standard input.
- **-stdinrpcpass** : Read RPC password from stdin.
- **-stdinwalletpassphrase** : Read wallet passphrase from stdin.
- **-version** : Print version and exit.

Chain Selection
===============

- **-chain=<chain>** : Choose network: main, test, testnet4, signet, regtest.
- **-signet** : Use signet chain.
- **-signetchallenge=<script>** : Blocks must satisfy this script (signet only).
- **-signetseednode=<host[:port]>** : Specify a seed node for signet.
- **-testnet** : Use testnet3 (deprecated).
- **-testnet4** : Use testnet4 (recommended over testnet3).

See Also
========

- `bitcoind(1)`  
- `bitcoin-tx(1)`  
- `bitcoin-wallet(1)`  
- `bitcoin-util(1)`  
- `bitcoin-qt(1)`

Copyright
=========

Copyright (C) 2009-2024 The Bitcoin Core developers.  
Distributed under the MIT software license. Visit <https://bitcoincore.org/> for more info.
