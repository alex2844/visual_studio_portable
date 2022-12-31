# visual_studio_portable

## Назначения скриптов

#### Упаковать Visual Studio в портативную версию
- .\scripts\pack.bat

#### Собрать проект используя портативный Visual Studio
- .\scripts\make.bat

### Собрать проект используя wine
``` bash
wine .\scripts\make.bat "src\Project.sln" -p:Configuration=Release
```
