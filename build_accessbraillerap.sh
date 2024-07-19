

python3 -m venv venv
source ./venv/bin/activate
pip install -r requirement.txt
pip install tk
pip install pyGobject
pip install pycairo

printf "python :%s %s\n" $(python --version)
printf "nodejs :%s\n" $(node --version)
printf "npm    :%s\n" $(npm --version)
printf "branch :%s\n" "$BRANCH_BUILD"

pip freeze > /home/builduser/dist/requirement.txt
npm install

rm -r /home/builduser/dist/*

git checkout $BRANCH_BUILD 

#printf "\e[1;34mBuild debug \e[0m\n"
#npm run builddev
printf "\e[1;34mBuild production ready\e[0m\n"
npm run build
printf "\e[0mBuild finished\n"

#npm run buildview
pyinstaller LinuxAccessBrailleRAP.spec

 if [ $(find /home/builduser/AccessBrailleRAP/build/ -name "*.js") ];
  then
    
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
