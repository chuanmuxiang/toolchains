#! /bin/bash

#config
TOOL_USER=`whoami`
CODE_PATH="$HOME/code/"
TOOL_PATH="$HOME/code/toolchains/"
#...

tool_usage()
{
    echo "Usage: toolchains [command]"
    echo -e "  -b, --build \t\tbuild cscope for project"
}

logger_info()
{
   time=`date`
   echo "[$time][inf]: $1"
}

logger_err()
{
   time=`date`
   echo "[$time][err]: $1"
}

tool_debug()
{
    while true; do
    sleep 1;
    logger_info "$*";
    eval "$*";
    done
}

tool_build()
{
   project_path="${CODE_PATH}$1"
   logger_info "build {project: $1, path: \"${project_path}\"}"
   find ${project_path} -name "*.c" -o -name "*.h" -o -name "*.sh" -o -name "*.py" > ./cscope.files  2>/dev/null
   cscope -bkq -i "./cscope.files" 2>/dev/null
}
case $1 in
  "--build" | "-b")
    curpath=`pwd`
    project=`basename $curpath`
    tool_build $project
  ;;
  "--debug" | "-d")
    shift
    tool_debug  "$*"
  ;;
  "--help"|*)
    tool_usage
#    logger_err "envaild command, {command: $1}"
esac
