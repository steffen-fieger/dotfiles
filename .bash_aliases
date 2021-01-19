alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

alias mci="mvn clean install -T 1C" 
alias mcif="mvn clean install -Dmaven.test.skip -Dspotbugs.skip=true -Dcheckstyle.skip=true -T 1C"
alias mciuf="mvn clean install -Dmaven.test.skip -Dspotbugs.skip=true -Dcheckstyle.skip=true -U -T 1C"
alias mgd="mvn clean package -Pgenerate-doc -T 1C"

alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'

alias ..='cd ..'
