#!/bin/sh

usage() {
  echo "USAGE: $0 VAR_NAME_FILE ..."
}

if [ $# -lt 1 ] ; then
  usage
  exit 1
fi

for VAR_NAME_FILE in $@ ; do
  eval FILE_NAME=\${${VAR_NAME_FILE}}
  # echo "$VAR_NAME_FILE = $FILE_NAME"
  if [ x${FILE_NAME} == x ]; then
    echo "${VAR_NAME_FILE} is empty"
  else
    VAR_NAME="${VAR_NAME_FILE%_FILE}"

    if env | grep "^${VAR_NAME}="; then
      echo "ERROR: Both $VAR_NAME_FILE and $VAR_NAME are set. These are mutually exclusive." >&2
      exit 1
    fi

    if [[ ! -f "${FILE_NAME}" ]]; then
      # Maybe the file doesn't exist, maybe we just can't read it due to file permissions.
      # Check permissions on each part of the path
      path=''
      if ! echo "${FILE_NAME}" | grep -q '^/'; then
        path='.'
      fi

      dirname "${FILE_NAME}" | tr '/' '\n' | while read part; do
        if [[ "$path" == "/" ]]; then
          path="${path}${part}"
        else
          path="$path/$part"
        fi

        if ! [[ -x "$path" ]]; then
          echo "ERROR: Cannot read ${FILE_NAME} from $VAR_NAME_FILE, due to lack of permissions on '$path'" 2>&1
          exit 1
        fi
      done

      if ! [[ -r "${FILE_NAME}" ]]; then
        echo "ERROR: File ${FILE_NAME} from $VAR_NAME_FILE is not readable." 2>&1
      else
        echo "ERROR: File ${FILE_NAME} from $VAR_NAME_FILE does not exist" >&2
      fi

      exit 1
    fi

    FILE_PERMS="$(stat -L -c '%a' ${FILE_NAME})"

    # if [[ "$FILE_PERMS" != "400" && "$FILE_PERMS" != "600" ]]; then
    #   if [[ -L "${FILE_NAME}" ]]; then
    #     echo "ERROR: File $(readlink "${FILE_NAME}") (target of symlink ${FILE_NAME} from $VAR_NAME_FILE) must have file permissions 400 or 600, but actually has: $FILE_PERMS" >&2
    #   else
    #     echo "ERROR: File ${FILE_NAME} from $VAR_NAME_FILE must have file permissions 400 or 600, but actually has: $FILE_PERMS" >&2
    #   fi
    #   exit 1
    # fi

    echo "Setting $VAR_NAME from $VAR_NAME_FILE at ${FILE_NAME}" >&2
    export "$VAR_NAME"="$(cat ${FILE_NAME})"

    unset VAR_NAME
    # Unset the suffixed environment variable
    unset "$VAR_NAME_FILE"
  fi
done