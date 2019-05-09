## Reference:
# https://gist.github.com/nadeemahmad/effa66117ebd1be829d9
# http://nadeemahmad.github.io/blog/2016/01/13/logging-in-bash-with-log-levels-library/
##

##
# Log levels for bash scripts
# vim: set ft=sh :
##

# Date format for logging
# declare -r DATE_FORMAT='+%Y-%m-%d:%H:%M:%S:%:z'
declare -r DATE_FORMAT='+%Y-%m-%d %H:%M:%S'

##
# These are the "methods" that your script will use to do the logging
# E.g. #1 Write a debug message
#            $log_debug "About to remove directory $temp"
#            rmdir $temp
# E.g. #2 Write a warning message
#            if [[ ! -r $file ]]; then
#                $log_warning "Cannot read configuration from $conf"
#            fi
##
declare log_debug='_log_silent'
declare log_info='_log_silent'
declare log_warning='_log_silent'
declare log_error='_log_silent'

##
# Boolean for toggling whether to add logging to file
# By default, all logs are only to console
##
declare _log_levels_should_log_to_file=false
declare _log_levels_log_file="/tmp/${0}.log"

##
# Variable to hold additional info for log message
##
declare _log_levels_prefix=''

##
# Use these to set the logging levels as desired
# Typically, this would be done when setting up your script
##
function set_logging_level_debug() {
    log_debug='_log_debug'
    log_info='_log_info'
    log_warning='_log_warning'
    log_error='_log_error'
}
function set_logging_level_info() {
    log_info='_log_info'
    log_warning='_log_warning'
    log_error='_log_error'
}
function set_logging_level_warning() {
    log_warning='_log_warning'
    log_error='_log_error'
}
function set_logging_level_error() {
    log_error='_log_error'
}

##
# Enable writing logs to disk
# @param $1 Full path to file where logs are to be stored
##
function set_logging_file_appender() {
    if [[ ! -z "${1}" ]]
    then
        _log_levels_log_file="${1}"
    fi

    if [[ -w "${_log_levels_log_file}" ]]
    then
        _log_levels_should_log_to_file=true
    else
        echo >&2 "Log file ${_log_levels_log_file} not writable"
    fi
}

##
# Add additional information to log message
# E.g. set_logging_prefix "${PID} Puppet hooks:"
# @param $1 Full prefix string
##
function set_logging_prefix() {
    _log_levels_prefix="${1}"
}
function _log_debug() {
    local log_date="$(date "${DATE_FORMAT}")"
    local log_message="${log_date} DEBUG ${_log_levels_prefix} $*"

    if [[ "${_log_levels_should_log_to_file}" = true ]] ; then
        echo "${log_message}" >> "${_log_levels_log_file}"
    fi

    echo "${log_message}"
}
function _log_info() {
    local log_date="$(date "${DATE_FORMAT}")"
    local log_message="${log_date} INFO ${_log_levels_prefix} $*"

    if [[ "${_log_levels_should_log_to_file}" = true ]] ; then
        echo "${log_message}" >> "${_log_levels_log_file}"
    fi

    echo "${log_message}"
}
function _log_warning() {
    local log_date="$(date "${DATE_FORMAT}")"
    local log_message="${log_date} WARNING ${_log_levels_prefix} $*"

    if [[ "${_log_levels_should_log_to_file}" = true ]] ; then
        echo "${log_message}" >> "${_log_levels_log_file}"
    fi

    echo >&2 "${log_message}"
}
function _log_error() {
    local log_date="$(date "${DATE_FORMAT}")"
    local log_message="${log_date} ERROR ${_log_levels_prefix} $*"

    if [[ "${_log_levels_should_log_to_file}" = true ]] ; then
        echo "${log_message}" >> "${_log_levels_log_file}"
    fi

    echo >&2 "${log_message}"
}
