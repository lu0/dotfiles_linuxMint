#i
# Install my favourite cinnamon spices
# Applets and extensions
#

BORRAR de localShareCinnamonApplets las que no use
copiar de localShareCinnamonApplets a su folder correspondiente

BORRAR de p_cinnamon_configs los que no use
copiar de p_cinnamon_configs a su folder correspondiente

imagino es lo mismo para extensiones y desklets v:

editar el ícono de LM para que sea mas chico :3


cd ~/.local/share/cinnamon/applets/
wget https://cinnamon-spices.linuxmint.com/files/applets/placesCenter@scollins.zip && unzip placesCenter@scollins.zip

wget https://cinnamon-spices.linuxmint.com/files/applets/temperature@fevimu.zip && unzip temperature@fevimu

#Enabled applets
dconf write /org/cinnamon/enabled-applets "[]"

enabled-applets=['panel1:left:1:workspace-switcher@cinnamon.org:61', 'panel1:right:3:blueberry@cinnamon.org:85', 'panel2:right:7:SW++@mohammad-sn:86', 'panel1:right:13:power@cinnamon.org:91', 'panel1:right:14:spacer@cinnamon.org:95', 'panel2:right:2:weather@mockturtl:110', 'panel1:right:4:ScreenShot+RecordDesktop@tech71:119', 'panel1:right:6:qredshift@quintao:121:orient', 'panel1:right:9:removable-drives@cinnamon.org:123', 'panel1:right:2:color-picker@fmete:126', 'panel1:right:5:show-hide-applets@mohammad-sn:129', 'panel1:right:11:sound@cinnamon.org:133', 'panel2:left:0:menu@cinnamon.org:136', 'panel2:left:1:window-list@cinnamon.org:139', 'panel2:right:4:calendar@cinnamon.org:140', 'panel2:right:6:calendar@cinnamon.org:141', 'panel2:right:3:separator@cinnamon.org:142']


enabled-applets=['panel1:right:10:systray@cinnamon.org:3', 'panel1:right:12:network@cinnamon.org:9', 'panel1:right:8:temperature@fevimu:37', 'panel1:left:1:workspace-switcher@cinnamon.org:61', 'panel1:right:3:blueberry@cinnamon.org:85', 'panel2:right:7:SW++@mohammad-sn:86', 'panel1:right:13:power@cinnamon.org:91', 'panel1:right:14:spacer@cinnamon.org:95', 'panel2:right:2:weather@mockturtl:110', 'panel1:right:4:ScreenShot+RecordDesktop@tech71:119', 'panel1:right:6:qredshift@quintao:121:orient', 'panel1:right:9:removable-drives@cinnamon.org:123', 'panel1:right:2:color-picker@fmete:126', 'panel1:right:5:show-hide-applets@mohammad-sn:129', 'panel1:right:11:sound@cinnamon.org:133', 'panel2:left:0:menu@cinnamon.org:136', 'panel2:left:1:window-list@cinnamon.org:139', 'panel2:right:4:calendar@cinnamon.org:140', 'panel2:right:6:calendar@cinnamon.org:141', 'panel2:right:3:separator@cinnamon.org:142']


enabled-applets=['panel1:right:10:systray@cinnamon.org:3', 'panel1:right:12:network@cinnamon.org:9', 'panel1:right:8:temperature@fevimu:37', 'panel1:left:1:workspace-switcher@cinnamon.org:61', 'panel1:right:3:blueberry@cinnamon.org:85', 'panel2:right:7:SW++@mohammad-sn:86', 'panel1:right:13:power@cinnamon.org:91', 'panel1:right:14:spacer@cinnamon.org:95', 'panel2:right:2:weather@mockturtl:110', 'panel1:right:4:ScreenShot+RecordDesktop@tech71:119', 'panel1:right:6:qredshift@quintao:121:orient', 'panel1:right:9:removable-drives@cinnamon.org:123', 'panel1:right:2:color-picker@fmete:126', 'panel1:right:5:show-hide-applets@mohammad-sn:129', 'panel1:right:11:sound@cinnamon.org:133', 'panel2:left:0:menu@cinnamon.org:136', 'panel2:left:1:window-list@cinnamon.org:139', 'panel2:right:4:calendar@cinnamon.org:140', 'panel2:right:6:calendar@cinnamon.org:141', 'panel2:right:3:separator@cinnamon.org:142']