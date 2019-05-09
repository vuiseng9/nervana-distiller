# Bash utility

source scripts/log-level.sh
set_logging_level_debug

# bash equivalent of os.makedirs(path, exist_ok=True)
function makedirs() {
    dirlist=$@
	for dir in ${dirlist}
    do
        if [ ! -d ${dir} ]; then
            $log_info folder ./${dir} not found, creating ./${dir}
        	mkdir -p ${dir}
		else
			$log_info folder ./${dir} exists
    	fi
	done
}

# clone a list of accessible repo to current directory
function clone_repos() {
    repolist=$@
    for repo in ${repolist}
    do
        if [ ! -d ${repo} ]; then
            $log_info cloning ${repo}
            git clone ${repo} 
        else
            $log_info repo ${repo} exists
        fi
    done
}

# log variables - variable input is in string format, 
# text string will be dereferenced internally in function
function logvars() {
    varlists=${@}
    for var in ${varlists}
	do
		if [ ! ${!var} ]; then
            $log_warning variable $var : undef or empty
		else
			$log_info variable $var : ${!var} 
		fi
	done
}

# make divider in log
function logdivider() {
    echo -e "\n\n#########################################\n"
}
