Luke Morris Project 1 ReadMe

There is one file: prefix.hs, which calculates prefix expressions.

I ran prefix.hs by opening it in Visual Studio Code. Be sure to install the extension for Haskell in Visual Studio Code.

In the terminal in Visual Studio Code, run this following line:

Set-ExecutionPolicy Bypass -Scope Process -Force;[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; try { & ([ScriptBlock]::Create((Invoke-WebRequest https://www.haskell.org/ghcup/sh/bootstrap-haskell.ps1 -UseBasicParsing))) -Interactive -DisableCurl } catch { Write-Error $_ }

This will download ghc. Once it has finished downloading, ensure it is working and present by inputting ghc --version into the terminal.
Then, run

ghc prefix.hs -o calc.exe

Then, the program can be run with .\calc.exe or .\calc.exe -b

When giving input to the program, it must be a valid prefix expression with spaces in between the characters, like + 1 2
Press enter to get result of expression. Use $ to use history references, e.g. $2 is the 2nd value in history.
Type quit to end program. -b and --batch activate batch mode.
