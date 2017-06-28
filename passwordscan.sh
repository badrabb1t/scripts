# finds string "password" in all readable files ending in .config, .conf, .cnf and .ini
# outputs results to passwordscan.out
#
# @badrabb1t

bold="\e[1m"
unbold="\e[0m"

# remove output file if it already exists
if [ -f passwordscan.out ]; then
  rm passwordscan.out
fi

printf $bold"Locating files...\n"$unbold

# file extensions to search
dotconfig=( $(find / -name *.config) )
dotconf=( $(find / -name *.conf) )
dotcnf=( $(find / -name *.cnf) )
dotini=( $(find / -name *.ini) )

printf $bold"Parsing...\n"$unbold

# loop to search .config files
for i in ${dotconfig[@]}; do
  # read each file, ignore comment lines
  cmd="cat $i | grep password | grep -v \# | grep -v '^;'";
  grepresult=$(eval $cmd)

  # only print results if file contained at least one instance of "password"
  if [[ ! -z "$grepresult" ]]
  then
    printf "**$bold$i$unbold\n" >> passwordscan.out
    printf "$grepresult\n" >> passwordscan.out
    printf "\n" >> passwordscan.out
  fi
done

# loop to search .conf files
for i in ${dotconf[@]}; do
  # read each file, ignore comment lines
  cmd="cat $i | grep password | grep -v \# | grep -v '^;'";
  grepresult=$(eval $cmd)

  # only print results if file contained at least one instance of "password"
  if [[ ! -z "$grepresult" ]]
  then
    printf "**$bold$i$unbold\n" >> passwordscan.out
    printf "$grepresult\n" >> passwordscan.out
    printf "\n" >> passwordscan.out
  fi
done

# loop to search .cnf files
for i in ${dotcnf[@]}; do
  # read each file, ignore comment lines
  cmd="cat $i | grep password | grep -v \# | grep -v '^;'";
  grepresult=$(eval $cmd)

  # only print results if file contained at least one instance of "password"
  if [[ ! -z "$grepresult" ]]
  then
    printf "**$bold$i$unbold\n" >> passwordscan.out
    printf "$grepresult\n" >> passwordscan.out
    printf "\n" >> passwordscan.out
  fi
done

# loop to search .ini files
for i in ${dotini[@]}; do
  # read each file, ignore comment lines
  cmd="cat $i | grep password | grep -v \# | grep -v '^;'";
  grepresult=$(eval $cmd)

  # only print results if file contained at least one instance of "password"
  if [[ ! -z "$grepresult" ]]
  then
    printf "**$bold$i$unbold\n" >> passwordscan.out
    printf "$grepresult\n" >> passwordscan.out
    printf "\n" >> passwordscan.out
  fi
done

printf "\n"
printf $bold"Finished, output saved to passwordscan.out\n"$unbold
