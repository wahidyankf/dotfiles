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

# PERSONAL

# First level
yk_var_path_online_repos=~/0_onlineRepos/
yk_var_path_dropbox=~/Dropbox/

yk_var_path_zshrc=~/.zshrc

# # Second level
yk_var_path_learn=$yk_var_path_online_repos"2_learn/"
yk_var_path_writing=$yk_var_path_online_repos"0_writing/"
yk_var_path_portfolio=$yk_var_path_online_repos"1_portfolio/"

yk_var_path_0_code=$yk_var_path_dropbox"0_code/"
yk_var_path_backup_online_repos=$yk_var_path_dropbox"0_backup_onlineRepos/"

# # # Third level
yk_var_path_ayokoding=$yk_var_path_writing"ayokoding/"
yk_var_path_dot_files=$yk_var_path_0_code"a_dotfiles/"

function yk_cd_online_repos {
  builtin cd $yk_var_path_online_repos
}

function yk_cd_learn {
  builtin cd $yk_var_path_learn
}

function yk_cd_ayokoding {
  builtin cd $yk_var_path_ayokoding
}

function yk_cd_port {
  builtin cd $yk_var_path_portfolio
}

function yk_cd_dot {
  builtin cd $yk_var_path_dot_files
}

function yk_deploy_dot {
  cwd=$(pwd)
  yk_cd_dot && npm run deploy && builtin cd $cwd
}

function yk_backup_repo {
  cwd=$(pwd)
  builtin cd ~ && rsync -avz --progress --exclude-from '.rsyncexclude' $yk_var_path_online_repos $yk_var_path_backup_online_repos && builtin cd $cwd
}

function yk_backup_repo_clear {
  rm -rf $yk_var_path_backup_online_repos
}

function yk_backup_repo_clear_and_backup {
  yk_backup_repo_clear && yk_backup_repo
}

function yk_zsh_reload {
  cwd=$(pwd)
  builtin source $yk_var_path_zshrc && builtin cd $cwd
}

function yk_test_cmd {
  cwd=$(pwd)
  yk_zsh_reload && builtin cd $cwd && $1
}

function yk_tmux_vscjobsh {
  tmuxinator start vscJobsH
}

# JOBS - RG

# RG - First level

rg_var_path=$yk_var_path_online_repos"0_jobs_ruang_guru/"

# # RG - Second level

rg_var_path_fe=$rg_var_path"frontend/"
rg_var_path_source=$rg_var_path"source/"

# # RG - Third Level
rg_var_path_ruker_app=$rg_var_path_source"ruker-app/"
rg_var_path_ruker_dashboard=$rg_var_path_source"ruker-dashboard/"
rg_var_path_ruker_cms=$rg_var_path_source"ruker-cms/"
rg_var_path_shared_lib=$rg_var_path_source"shared-lib/"

function rg_cd_rg {
 builtin cd $rg_var_path
}

function rg_cd_frontend {
  builtin cd $rg_var_path_fe
}

function rg_cd_source {
  builtin cd $rg_var_path_source
}

function rg_cd_rukerapp {
  builtin cd $rg_var_path_ruker_app
}

function rg_cd_rukerdash {
  builtin cd $rg_var_path_ruker_dashboard
}

function rg_cd_rukercms {
  builtin cd $rg_var_path_ruker_cms
}

function rg_cd_sharedlibs {
  builtin cd $rg_var_path_shared_lib
}

# RG - Ruker App - Utils

function rg_rn_ios_goto {
  xcrun simctl openurl booted ruangkerja://$1
}

function rg_rn_ios_goto_2 {
  rg_rn_ios_goto $1 && rg_rn_ios_goto $2
}

function rg_rn_ios_goto_with_start {
  yarn run-ios && rg_rn_ios_goto $1
}

function rg_rn_android_goto {
  adb shell am start -W -a android.intent.action.VIEW -d "ruangkerja://ruangkerja/$1" com.ruangguru.kerjaStaging
}

function rg_rn_android_goto_2 {
  rg_rn_android_goto $1 && rg_rn_android_goto $2
}

function rg_rn_android_goto_with_start {
  yarn run-android && rg_rn_android_goto $1
}

function rg_rn_debugger {
  open "rndebugger://set-debugger-loc?host=localhost&port=8081"  
}

rg_var_serial_course=course1231
rg_var_serial_assigned_course=course12311
rg_var_serial_pretest=$rg_var_serial_assigned_course"-pretest123"
rg_var_serial_posttest=$rg_var_serial_assigned_course"-posttest123"

function rg_rn_ios_dev_course_detail {
  rg_rn_ios_goto course-detail/$rg_var_serial_assigned_course
}

function rg_rn_ios_dev_course_preview {
  rg_rn_ios_goto course-preview/$rg_var_serial_course
}

function rg_rn_android_dev_course_detail {
  rg_rn_android_goto course-detail/$rg_var_serial_assigned_course
}

function rg_rn_android_dev_course_preview {
  rg_rn_android_goto course-preview/$rg_var_serial_course
}
function rg_rn_ios_dev_test_pre_view {
  rg_rn_ios_goto_2 course-detail/$rg_var_serial_assigned_course test/$rg_var_serial_assigned_course/pretest/$rg_var_serial_pretest
}

function rg_rn_ios_dev_test_pre_result {
  rg_rn_ios_goto test-result/$rg_var_serial_assigned_course/pretest/$rg_var_serial_pretest
}

function rg_rn_ios_dev_test_post_view {
  rg_rn_ios_goto_2 course-detail/$rg_var_serial_assigned_course test/$rg_var_serial_assigned_course/posttest/$rg_var_serial_posttest
}

function rg_rn_ios_dev_test_post_result {
  rg_rn_ios_goto test-result/$rg_var_serial_assigned_course/posttest/$rg_var_serial_posttest
}

function rg_rn_android_dev_test_pre_view {
  rg_rn_android_goto_2 course-detail/$rg_var_serial_assigned_course test/$rg_var_serial_assigned_course/pretest/$rg_var_serial_pretest
}

function rg_rn_android_dev_test_pre_result {
  rg_rn_android_goto test-result/$rg_var_serial_assigned_course/pretest/$rg_var_serial_pretest
}

function rg_rn_android_dev_test_post_view {
  rg_rn_android_goto_2 course-detail/$rg_var_serial_assigned_course test/$rg_var_serial_assigned_course/posttest/$rg_var_serial_posttest
}

function rg_rn_android_dev_test_post_result {
  rg_rn_android_goto test-result/$rg_var_serial_assigned_course/posttest/$rg_var_serial_posttest
}
