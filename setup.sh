append_line() {
  set -e

  local skip line file pat lno
  skip="$1"
  line="$2"
  file="$3"
  pat="${4:-}"

  echo "Update $file:"
  echo "  - $line"
  [ -f "$file" ] || touch "$file"
  if [ $# -lt 4 ]; then
    lno=$(\grep -nF "$line" "$file" | sed 's/:.*//' | tr '\n' ' ')
  else
    lno=$(\grep -nF "$pat" "$file" | sed 's/:.*//' | tr '\n' ' ')
  fi
  if [ -n "$lno" ]; then
    echo "    - Already exists: line #$lno"
  else
    if [ $skip -eq 1 ]; then
      echo >> "$file"
      echo "$line" >> "$file"
      echo "    + Added"
    else
      echo "    ~ Skipped"
    fi
  fi
  echo
  set +e
}

update_bashrc() {
  append_line 1 "[ -f ~/dotbraddenver/.bash_profile ] && source ~/dotbraddenver/.bash_profile" ~/.bashrc
}
update_bashrc
