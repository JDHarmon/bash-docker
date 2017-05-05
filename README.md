Bash container with dev tools.

Usage: ```docker run -it --rm -v c:\:/c jdharmon/bash```

Shortcut: 
```%windir%\system32\cmd.exe /s /c "docker run -it --rm -v c:\:/c -v /var/run/docker.sock:/var/run/docker.sock jdharmon/bash"```

PowerShell script to start in current directory:
```
$workdir = (pwd).Path.Replace('\', '/').Replace('C:/', '/c/')
docker run -it --rm -v c:\:/c -v /var/run/docker.sock:/var/run/docker.sock --workdir $workdir jdharmon/bash
```
