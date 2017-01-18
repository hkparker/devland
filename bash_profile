##
## Personalization and aliases
##

export EDITOR=vim

alias hack='docker run --net=host -t -i kali-full /bin/bash'
alias i2p='docker run -p 7070:7070 -p 4446:4446 -p 6668:6668 -v /home/hayden/.i2pd/:/home/i2pd/.i2pd kytv/i2pd'
alias tmux='tmux -u'

##
## PS1 with git branch and hints
##

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
TEAL='\033[1;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

function git_open {
	if [[ $(git branch 2> /dev/null) != '' ]]
		then
			echo -n -e " ${CYAN}("
			echo -n $(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ \1/")
			echo -n -e "${NC}"
	fi
}

function git_untracked {
	if [[ $(git status 2>/dev/null | grep 'Untracked files:') == 'Untracked files:' ]]
		then
			echo -n -e "${YELLOW}+${NC}"
	fi
}

function git_unstaged {
	if [[ $(git status 2>/dev/null | grep 'Changes not staged for commit:') == 'Changes not staged for commit:' ]]
		then
			echo -n -e "${RED}*${NC}"
	fi
}

function git_staging {
	if [[ $(git status 2>/dev/null | grep 'Changes to be committed:') == 'Changes to be committed:' ]]
		then
			echo -n -e "${TEAL}~${NC}"
	fi
}

function git_commit_distance {
	if [[ $(git status 2> /dev/null | head -n2 | tail -n1 | cut -d ' ' -f 4) != "up-to-date" ]]
		then
			echo -n " "
			echo -e -n $(git status 2> /dev/null | head -n2 | tail -n1 | grep -o '[0-9]\+')
			[[ $(git status 2> /dev/null | head -n2 | tail -n1 | cut -d ' ' -f 4) == "ahead" ]] && echo -e -n "${GREEN}▲${NC}"
			[[ $(git status 2> /dev/null | head -n2 | tail -n1 | cut -d ' ' -f 4) == "behind" ]] && echo -e -n "${RED}▼${NC}"
	fi
}

function git_close {
	if [[ $(git branch 2> /dev/null) != '' ]]
		then
			echo -n -e "${CYAN})${NC} "
	fi
}

function git_stuff {
	git_open
	git_untracked
	git_unstaged
	git_staging
	git_commit_distance
	git_close
	echo
}

PS1='\[\033[1;35m\]\u@\h \[\033[1;34m\]\w\[\033[0m\]$(git_stuff)\[\033[0;36m\]\[\033[1;34m\]$\[\033[0m\] '

##
## Programming languages
##

# Go

export GOPATH=/src/Go
export PATH=$PATH:$GOPATH/bin
