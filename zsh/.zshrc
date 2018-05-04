# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/abdurrahman/.oh-my-zsh
export PATH=/Users/abdurrahman/anaconda3/bin:$PATH
export EDITOR=vim
export DISABLE_AUTO_TITLE=true
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="cloud"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
cd ~

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/abdurrahman/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/abdurrahman/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/abdurrahman/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/abdurrahman/google-cloud-sdk/completion.zsh.inc'; fi

export PATH="/usr/local/opt/python/libexec/bin:$PATH"  

tmux

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Functions - Personal

alias ykcdlearn = "cd ~/0_onlineRepos/2_learn/"

alias ykcdayokoding = "cd ~/0_onlineRepos/0_writing/ayokoding/"

alias ykcdport = "cd ~/0_onlineRepos/1_portfolio/"

alias ykcddot = "cd ~/Dropbox/0_code/a_dotfiles/"

alias ykbackuprepo = "cd ~ && rsync -avz --progress --exclude-from '.rsyncexclude' ~/0_onlineRepos/ ~/Dropbox/0_backup_onlineRepos/"

alias ykclearbackup = "-rf ~/Dropbox/0_backup_onlineRepos/"

alias ykclearandbackuprepo = "-rf ~/Dropbox/0_backup_onlineRepos/ && builtin cd ~ && rsync -avz --progress --exclude-from '.rsyncexclude' ~0_onlineRepos/ ~/Dropbox/0_backup_onlineRepos/"

alias ykreloadzsh = "source ~/.zshrc"

# Functions - jobs

alias ykcdrg = "cd ~/0_onlineRepos/0_jobs_ruang_guru/"

alias ykcdfe = "cd ~/0_onlineRepos/0_jobs_ruang_guru/frontend/"

alias ykcdsource = "cd ~/0_onlineRepos/0_jobs_ruang_guru/source"

alias ykcdrukerapp = "cd ~/0_onlineRepos/0_jobs_ruang_guru/source/ruker-app"

alias ykcdrukerdash = "cd ~/0_onlineRepos/0_jobs_ruang_guru/source/ruker-dashboard"

alias ykcdrukercms = "cd ~/0_onlineRepos/0_jobs_ruang_guru/source/ruker-cms"

alias ykcdrgsharedlibs = "cd ~/0_onlineRepos/0_jobs_ruang_guru/source/shared-lib"

function ykrniosgoto {
  xcrun simctl openurl booted ruangkerja://$1
}

function ykrniosgoto2 {
  ykrniosgoto $1 && ykrniosgoto $2
}

function ykrniosstartgoto {
  yarn run-ios && ykrniosgoto $1
}

function ykrnandroidgoto {
  adb shell am start -W -a android.intent.action.VIEW -d "ruangkerja://ruangkerja/$1" com.ruangguru.kerjaStaging
}

function ykrnandroidgoto2 {
  ykrnandroidgoto $1 && ykrnandroidgoto $2
}

function ykrnandroidstartgoto {
  yarn run-android && ykrnandroidgoto $1
}

alias ykrndebugger = "open \"rndebugger://set-debugger-loc?host=localhost&port=8081\""
}

alias ykrniosdevpretestview = "ykrniosgoto2 course-detail/course12311 test/course12311/pretest/course12311-pretest123"

alias ykrniosdevpretestresult = "ykrniosgoto2 course-detail/course12311 test/course12311/pretest/course12311-pretest123 && ykrniosgoto test-result/course12311/pretest/course12311-pretest123"

alias ykrniosdevpretestresult0 = "ykrniosgoto test-result/course12311/pretest/course12311-pretest123"

alias ykrniosdevposttestview = "ykrniosgoto2 course-detail/course12311 test/course12311/posttest/course12311-posttest123"

alias ykrniosdevposttestresult = "ykrniosgoto2 course-detail/course12311 test/course12311/posttest/course12311-posttest123 && ykrniosgoto test-result/course12311/posttest/course12311-posttest123 "

alias ykrniosdevposttestresult0 = "ykrniosgoto test-result/course12311/posttest/course12311-posttest123 "

alias ykrnandroiddevpretestview = "ykrnandroidgoto2 course-detail/course12311 test/course12311/pretest/course12311-pretest123"

alias ykrnandroiddevpretestresult = "ykrnandroidgoto2 course-detail/course12311 test/course12311/pretest/course12311-pretest123 && ykrnandroidgoto test-result/course12311/pretest/course12311-pretest123 "

alias ykrnandroiddevpretestresult0 = "ykrnandroidgoto test-result/course12311/pretest/course12311-pretest123 "

alias ykrnandroiddevposttestview = "ykrnandroidgoto2 course-detail/course12311 test/course12311/posttest/course12311-posttest123"

alias ykrnandroiddevposttestresult = "ykrnandroidgoto2 course-detail/course12311 test/course12311/posttest/course12311-posttest123 && ykrnandroidgoto test-result/course12311/posttest/course12311-posttest123 "

alias ykrnandroiddevposttestresult0 = "ykrnandroidgoto test-result/course12311/posttest/course12311-posttest123 "

alias ykrniosdevcoursedetail = "ykrniosgoto course-detail/course12311"

alias ykrniosdevcoursepreview = "ykrniosgoto course-preview/course1231"

alias ykrnandroiddevcoursedetail = "ykrnandroidgoto course-detail/course12311"

alias ykrnandroiddevcoursepreview = "ykrnandroidgoto course-preview/course1231"
