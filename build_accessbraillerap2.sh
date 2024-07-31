Xvfb :99 -screen 0 1024x768x16 &
DISPLAY=:99.0
export DISPLAY

python3 -m venv venv
source ./venv/bin/activate
#pip install -r requirement.txt
# pip install tk
# pip install pyGobject
# pip install pycairo
# pip install QtPy
# pip install pyQt5
# pip install pyQtWebEngine
# pip install PyQtWebEngine-Qt5
# pip install pyserial
# pip install pywebview
# pip install pyinstaller
# pip install pygi
# pip install pypandoc
# pip install zipp
# pip install typing_extensions
# pip install pywin32-ctypes
printf "\e[1;34m######################\e[0m\n"
printf "\e[1;34minstall python dependencies\e[0m\n" 
printf "\e[1;34m######################\e[0m\n"
pip install -r /home/builduser/AccessBrailleRAP/requirement_linux.txt


#pip install -r reqlinux.txt

printf "\e[1;34m######################\e[0m\n"
printf "\e[1;34mplatform status\e[0m\n" 
printf "\e[1;34m######################\e[0m\n"
printf "python :%s %s\n" $(python --version)
printf "nodejs :%s\n" $(node --version)
printf "npm    :%s\n" $(npm --version)
printf "branch :%s\n" "$BRANCH_BUILD"

printf "\e[1;34m########################\e[0m\n"
printf "\e[1;34minstall npm dependencies\e[0m\n" 
printf "\e[1;34m########################\e[0m\n"

npm install

rm -r /home/builduser/dist/*

printf "writing python linux dependencies\n" 
pip freeze > /home/builduser/dist/requirement_test.txt

git pull
git checkout $BRANCH_BUILD 

#printf "\e[1;34mBuild debug \e[0m\n"
#npm run builddev
printf "\e[1;34m######################\e[0m\n"
printf "\e[1;34mBuild production ready\e[0m\n"
printf "\e[1;34m######################\e[0m\n"
npm run build
printf "\e[0mBuild finished\n"

#npm run buildview
pyinstaller LinuxAccessBrailleRAP.spec

 if [ $(find /home/builduser/AccessBrailleRAP/dist/ -name "AccessBrailleRAP-ubuntu") ];
  then
    #ls -la /home/builduser/AccessBrailleRAP/build/
    #ls -la /home/builduser/AccessBrailleRAP/
    #ls -la /home/builduser/AccessBrailleRAP/dist/
    #cp -r /home/builduser/AccessBrailleRAP/build/* /home/builduser/dist/
    cp -r /home/builduser/AccessBrailleRAP/dist/* /home/builduser/dist/
    printf "\e[0mCompilation: \e[1;32mSucceeded\n"
    printf "\n"
    printf "####### #    # \n"
    printf "#     # #   #  \n"
    printf "#     # #  #   \n"
    printf "#     # ###    \n"
    printf "#     # #  #   \n"
    printf "#     # #   #  \n"
    printf "####### #    # \n"
    printf "\n" 
  else
    printf "\e[0mCompilation: \e[0;31mFailed\n"
    printf "\n"
    printf "#    # #######\n"
    printf "#   #  #     #\n"
    printf "#  #   #     #\n"
    printf "# ###  #     #\n"
    printf "#  #   #     #\n"
    printf "#   #  #     #\n"
    printf "#    # #######\n"
    printf "\n" 
  fi
