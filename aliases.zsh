#################################
# Work
#################################
function ssh_jump(){ # ssh_jump keyFullOrPartialName ip [user:default centos]
  local key=~/.aws/keys/$1
  if ! [ -f $key ];then
    key=$(find ~/.aws/keys -name "*$1*" | head -n 1)
  fi
  echo "Using key $key"
  ssh -i $key ${3:-$USER}@$2
}

# Replace `c.` by the [C]lients initial.
function c.resolver(){
  echo "
  # put this in the resolver, use o_file_resolver
  vpn, etc client resolver not added in connection or some custom
  "
}

function c.aws_credentials(){ # c.aws_credentials account 
  local aws_date(){date_utc "$(AWS_PROFILE=${1} aws configure get expiration)"}
  local date_utc(){sec=$(TZ="UTC" date -j -f "%Y-%m-%d %H:%M:%S" "${1%.*}" +'%s');date -j -f %s "$sec"}
  local pe(){echo "# AWS experation time  (>)  $(aws_date $1) [$1]"}

  # write the command to login
  login with some tool example $1 || return 1

  echo "# Current time         (<)  $(date)"
  eval "pe ${1//,/;pe }"

  echo '# If you want to export it somewhere'
  echo '  \/  \/  \/  \/  \/  \/  \/  \/  \/'
  local pc(){
    echo "# ${1}"
    echo "export AWS_ACCESS_KEY_ID=$(AWS_PROFILE=${1} aws configure get aws_access_key_id)"
    echo "export AWS_SECRET_ACCESS_KEY=$(AWS_PROFILE=${1} aws configure get aws_secret_access_key)"
    echo "export AWS_SESSION_TOKEN=$(AWS_PROFILE=${1} aws configure get aws_session_token)"
  }
  eval "pc ${1//,/;pc }"
}

# changed the ~/.pip* configuration to point to clients artifactory
function c.python_attach(){
  mkdir -p $HOME/.pip
  if [ -f $HOME/.pip/pip.conf.bck ]
  then echo '> pip.conf already attached!'
  else
    cp $HOME/.pip/pip.conf $HOME/.pip/pip.conf.bck 2>/dev/null || echo "pip.conf does not exist, ignoring backup!"
    echo "[global]
index-url = http://client.repo/artifactory/api/pypi/pypi/simple
trusted-host = client.repo

[local]
repository: http://client.repo/artifactory/api/pypi/pypi-internal
username: REDACTED
password: REDACTED
" > $HOME/.pip/pip.conf
  fi
  if [ -f $HOME/.pypirc.bck ]
  then echo '> .pypirc already attached!'
  else
    cp $HOME/.pypirc $HOME/.pypirc.bck 2>/dev/null || echo "pypirc does not exist, ignoring backup!"
    echo "[distutils]
index-servers =
  internal

[internal]
repository=http://client.repo/artifactory/api/pypi/pypi-internal
trusted-host=client.repo
username=REDACTED
password=REDACTED
" > $HOME/.pypirc
  fi
}
function c.python_release(){
  mv -f $HOME/.pip/pip.conf.bck $HOME/.pip/pip.conf
  mv -f $HOME/.pypirc.bck $HOME/.pypirc
}
