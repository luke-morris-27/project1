Luke Morris Project 1 ReadMe

There is one file: prefix.hs, which calculates prefix expressions.

I ran prefix.hs by opening it in Visual Studio Code. Be sure to install the extension for Haskell in Visual Studio Code.

In the terminal in Visual Studio Code, run this following line:

Set-ExecutionPolicy Bypass -Scope Process -Force;[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; try { & ([ScriptBlock]::Create((Invoke-WebRequest https://www.haskell.org/ghcup/sh/bootstrap-haskell.ps1 -UseBasicParsing))) -Interactive -DisableCurl } catch { Write-Error $_ }

This will download ghc. Once it has finished downloading, ensure it is working and present by inputting ghc --version into the terminal.
Then, run

ghc prefix.hs -o calc.exe

Then, it can be run with .\calc.exe or .\calc.exe -b
