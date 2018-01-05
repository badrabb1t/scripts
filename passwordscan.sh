# finds string "password" in all readable files ending in common config file extensions
# outputs results to passwordscan.out
#
# 2017 @badrabb1t

bold="\e[1m"
unbold="\e[0m"

# remove output file if it already exists
if [ -f passwordscan.out ]; then
  rm passwordscan.out
fi

printf $bold"Locating files...\n"$unbold

# file extensions to search
dotconfig=( $(/usr/bin/find / -name *.config) )
dotconf=( $(/usr/bin/find / -name *.conf) )
dotcnf=( $(/usr/bin/find / -name *.cnf) )
dotini=( $(/usr/bin/find / -name *.ini) )
dotxml=( $(/usr/bin/find / -name *.xml) )
dotclass=( $(/usr/bin/find / -name *.class) )
dotjsp=( $(/usr/bin/find / -name *.jsp) )

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

# loop to search .xml files
for i in ${dotxml[@]}; do
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

# loop to search .class files
for i in ${dotclass[@]}; do
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

# loop to search .jsp files
for i in ${dotjsp[@]}; do
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
