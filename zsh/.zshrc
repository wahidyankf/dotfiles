# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

Y_USER_NAME=$(logname)

export ZSH=/Users/$Y_USER_NAME/.oh-my-zsh
export PATH=/Users/$Y_USER_NAME/anaconda3/bin:$PATH
export EDITOR=vim
export DISABLE_AUTO_TITLE=true
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools

# GO paths
export GOPATH=$HOME/go
export GOBIN=$HOME/go/bin

ZSH_THEME="cloud"

# Specify the plugin being used by zsh
plugins=(git zsh-wakatime z)

source $ZSH/oh-my-zsh.sh

cd ~

# The next line updates PATH for the Google Cloud SDK.
if [ -f "/Users/$Y_USER_NAME/google-cloud-sdk/path.zsh.inc" ]; then source "/Users/$Y_USER_NAME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "/Users/$Y_USER_NAME/google-cloud-sdk/completion.zsh.inc" ]; then source "/Users/$Y_USER_NAME/google-cloud-sdk/completion.zsh.inc"; fi

export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# tmux

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Elixir
export ERL_AFLAGS="-kernel shell_history enabled"

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# PERSONAL

# # First level
y_var_path_online_repos=~/0_onlineRepos/
y_var_path_dropbox=~/Dropbox/

y_var_path_zshrc=~/.zshrc

# # Second level
y_var_path_learn=$y_var_path_online_repos"2_learn/"
y_var_path_writing=$y_var_path_online_repos"yk_writing/"

y_var_path_0_code=$y_var_path_dropbox"0_code/"
y_var_path_backup_online_repos=$y_var_path_dropbox"0_backup_onlineRepos/"

# # Third level
y_var_path_ayokoding=$y_var_path_writing"ayokoding/"
y_var_path_dot_files=$y_var_path_0_code"a_dotfiles/"
y_var_path_notes=$y_var_path_0_code"notes/"
y_var_path_devnotes=$y_var_path_writing"devnotes/"

y_var_path_learn_junior_to_senior_web=$y_var_path_learn"learn-junior-to-senior-web/"

# # Fourth level
y_var_path_ayokoding_release=$y_var_path_ayokoding"release/"
y_var_path_quick_scripts=$y_var_path_notes"quickScripts/"

# # # CD

function y_cd_online_repos() {
	builtin cd $y_var_path_online_repos
}

function y_cd_learn() {
	builtin cd $y_var_path_learn
}

function y_cd_learn_junior_to_senior_web() {
	builtin cd $y_var_path_learn_junior_to_senior_web
}

function y_cd_ayokoding() {
	builtin cd $y_var_path_ayokoding
}

function y_cd_dot() {
	builtin cd $y_var_path_dot_files
}

function y_cd_quickScripts() {
	builtin cd $y_var_path_quick_scripts
}

function y_cd_ayokoding_release() {
	builtin cd $y_var_path_ayokoding_release
}

function y_cd_devnotes() {
	builtin cd $y_var_path_devnotes
}

# # # Brew

alias y_brew_maintenance="brew cleanup ; brew doctor ; brew update ; brew upgrade"

# # # Deployment

function y_deploy_dot() {
	cwd=$(pwd)
	y_cd_dot && npm run deploy && builtin cd $cwd
}

function y_deploy_ayokoding() {
	cwd=$(pwd)
	y_cd_ayokoding_release && npm run deploy && builtin cd $cwd
}

function y_deploy_devnotes() {
	cwd=$(pwd)
	y_cd_devnotes && npm run deploy && builtin cd $cwd
}

# # # Back up

function y_backup_repo() {
	cwd=$(pwd)
	builtin cd ~ && rsync -avz --progress --exclude-from '.rsyncexclude' $y_var_path_online_repos $y_var_path_backup_online_repos && builtin cd $cwd
}

function y_backup_repo_clear() {
	rm -rf $y_var_path_backup_online_repos
}

function y_backup_repo_clear_and_backup() {
	y_backup_repo_clear && y_backup_repo
}

# # # Bash

function y_zsh_reload() {
	cwd=$(pwd)
	builtin source $y_var_path_zshrc && builtin cd $cwd
}

function y_zsh_cmd_test() {
	cwd=$(pwd)
	y_zsh_reload && builtin cd $cwd && $1
}

# # # Tmux

function y_tmux_vscjobs() {
	tmuxinator start vscJobs
}

function y_tmux_writing() {
	tmuxinator start writing
}

# # # Git

function y_git_clean_branch_local() {
	git branch | grep -v "master" | xargs git branch -D
}

function y_git_checkout_pull_master() {
	git checkout master && git pull
}

function y_git_pull_master_here() {
	git pull origin master
}

# # # Prettier

function y_js_prettify_all() {
	prettier --config ~/.prettierrc --write **/*.js
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# JOBS - RG

# # RG - First level

rg_var_path=$y_var_path_online_repos"0_jobs_ruang_guru/"

# # RG - Second level

rg_var_path_fe=$rg_var_path"frontend/"
rg_var_path_source=$rg_var_path"source/"

# # RG - Third Level
rg_var_path_ruker_app=$rg_var_path_source"ruker-app/"
rg_var_path_ruker_dashboard=$rg_var_path_source"ruker-dashboard/"
rg_var_path_ruker_cms=$rg_var_path_source"ruker-cms/"
rg_var_path_shared_lib=$rg_var_path_source"shared-lib/"

function rg_cd_rg() {
	builtin cd $rg_var_path
}

function rg_cd_frontend() {
	builtin cd $rg_var_path_fe
}

function rg_cd_source() {
	builtin cd $rg_var_path_source
}

function rg_cd_rukerapp() {
	builtin cd $rg_var_path_ruker_app
}

function rg_cd_rukerdash() {
	builtin cd $rg_var_path_ruker_dashboard
}

function rg_cd_rukercms() {
	builtin cd $rg_var_path_ruker_cms
}

function rg_cd_sharedlibs() {
	builtin cd $rg_var_path_shared_lib
}

# RG - Source

function rg_source_rebuild_fe() {
	cwd=$(pwd)
	builtin cd $rg_var_path_source && yarn build:libs && cd $cwd
}

function rg_source_init_fe() {
	cwd=$(pwd)
	builtin cd $rg_var_path_source && yarn init-repo && cd $cwd
}

# RG - Rogu

alias rogu="$GOBIN/rogu"

function rg_rogu_list_version() {
	cwd=$(pwd)
	temp_file_name=$1_versions_list.md
	builtin cd $rg_var_path_source && builtin cd $1 && rogu list-version >$temp_file_name && vim $temp_file_name && rm -rf $temp_file_name && builtin cd $cwd
}

function rg_rogu_deploy_version_production() {
	rogu deploy-version -n production $1
}

# RG - Ruker App - Utils

function rg_rn_ios_goto() {
	xcrun simctl openurl booted ruangkerja://$1
}

function rg_rn_ios_goto_2() {
	rg_rn_ios_goto $1 && rg_rn_ios_goto $2
}

function rg_rn_ios_goto_with_start() {
	yarn run-ios && rg_rn_ios_goto $1
}

function rg_rn_android_goto() {
	adb shell am start -W -a android.intent.action.VIEW -d "ruangkerja://ruangkerja/$1" com.ruangguru.kerjaStaging
}

function rg_rn_android_goto_2() {
	rg_rn_android_goto $1 && rg_rn_android_goto $2
}

function rg_rn_android_goto_with_start() {
	yarn run-android && rg_rn_android_goto $1
}

function rg_rn_debugger() {
	open "rndebugger://set-debugger-loc?host=localhost&port=8081"
}

rg_var_serial_course=course1231
rg_var_serial_assigned_course=course12311
rg_var_serial_pretest=$rg_var_serial_assigned_course"-pretest123"
rg_var_serial_posttest=$rg_var_serial_assigned_course"-posttest123"

function rg_rn_ios_dev_course_detail() {
	rg_rn_ios_goto course-detail/$rg_var_serial_assigned_course
}

function rg_rn_ios_dev_course_preview() {
	rg_rn_ios_goto course-preview/$rg_var_serial_course
}

function rg_rn_android_dev_course_detail() {
	rg_rn_android_goto course-detail/$rg_var_serial_assigned_course
}

function rg_rn_android_dev_course_preview() {
	rg_rn_android_goto course-preview/$rg_var_serial_course
}
function rg_rn_ios_dev_test_pre_view() {
	rg_rn_ios_goto_2 course-detail/$rg_var_serial_assigned_course test/$rg_var_serial_assigned_course/pretest/$rg_var_serial_pretest
}

function rg_rn_ios_dev_test_pre_result() {
	rg_rn_ios_goto test-result/$rg_var_serial_assigned_course/pretest/$rg_var_serial_pretest
}

function rg_rn_ios_dev_test_post_view() {
	rg_rn_ios_goto_2 course-detail/$rg_var_serial_assigned_course test/$rg_var_serial_assigned_course/posttest/$rg_var_serial_posttest
}

function rg_rn_ios_dev_test_post_result() {
	rg_rn_ios_goto test-result/$rg_var_serial_assigned_course/posttest/$rg_var_serial_posttest
}

function rg_rn_android_dev_test_pre_view() {
	rg_rn_android_goto_2 course-detail/$rg_var_serial_assigned_course test/$rg_var_serial_assigned_course/pretest/$rg_var_serial_pretest
}

function rg_rn_android_dev_test_pre_result() {
	rg_rn_android_goto test-result/$rg_var_serial_assigned_course/pretest/$rg_var_serial_pretest
}

function rg_rn_android_dev_test_post_view() {
	rg_rn_android_goto_2 course-detail/$rg_var_serial_assigned_course test/$rg_var_serial_assigned_course/posttest/$rg_var_serial_posttest
}

function rg_rn_android_dev_test_post_result() {
	rg_rn_android_goto test-result/$rg_var_serial_assigned_course/posttest/$rg_var_serial_posttest
}
