# reflog: Pretty format `git reflog show` with optional flag options for refining reflog output
function reflog {
	if [[ ! "$(git rev-parse --is-inside-work-tree)" ]] 2>/dev/null; then
		echo "fatal: Not a git repository (or any of the parent directories): .git"
		return 1
	fi

	# decorated `git reflog show` graph format style
	local FORMAT='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'

	# all refs contained in the reflog
	local REFS="$(git --no-pager reflog show --pretty=format:'%gd')"

	# total number of refs in reflog
	local TOTAL=0

	# count refs
	for i in $REFS; do
		let TOTAL++
	done

	# default output, if no flags were given to `reflog`
	if [[ $# -eq 0 ]]; then
		if [[ "$TOTAL" -gt 10 ]]; then
			printf '\n********** \033[1;32mShowing last %s of %s entries\033[0m **********\n\n' "10" "$TOTAL"
			git reflog show --pretty=format:"$FORMAT" --abbrev-commit --date=relative --max-count="10"
		else
			printf '\n********** \033[1;32mShowing all %s entries\033[0m **********\n\n' "$TOTAL"
			git reflog show --pretty=format:"$FORMAT" --abbrev-commit --date=relative
		fi
		return 0
	fi

	# wrangle the given flag options
	while [[ $# -gt 0 ]]; do
		case "$1" in
			-h|--help)
				echo "Usage: reflog [--all|--last{=NUM}]"
				break
				;;
			-a|--all)
				printf '\n********** \033[1;32mShowing all %s entries\033[0m **********\n\n' "$TOTAL"
				git reflog show --pretty=format:"$FORMAT" --abbrev-commit --date=relative
				shift
				;;
			-l*|--last*)
				# parse number from flag (e.g. --last=5)
				local NUM="`echo $1 | sed -e 's/^[^=]*=//g'`"
				local REGEX='^[0-9]+$'
				# if flag option didn't include an assignment between flag option name and value,
				# get the next positional argument and update `$NUM` value to pass to `git reflog show`
				if ! [[ $NUM =~ $REGEX ]]; then
					NUM="$2"
				fi
				printf '\n********** \033[1;32mShowing last %s of %s total entries\033[0m **********\n\n' "$NUM" "$TOTAL"
				git reflog show --pretty=format:"$FORMAT" --abbrev-commit --date=relative --max-count="$NUM"
				shift
				;;
			*)
				break
				;;
		esac
	done
}