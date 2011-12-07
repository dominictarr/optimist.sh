# optimist.sh

behaves just like substack/optimist but is for bash instead of nodejs

```
#source optimist.sh into your bash script
. optimist.sh
```

source the output back into this script. 
it will create env vars with the prefix `argv_`  

optionally set a different prefix `. <(PREFIX whatever_ argv "$@")`

```
. <(argv "$@") 

# iterate over them like this:

for key in ${!argv_*}; do
  value="${!key}"
  echo "$key"="$value"
done
```

supports a bunch of arguments

```
./example.sh arg1 --key1 value1 --key2=value2 --no-falsey --truthy -t -f -- arg2 arg3
```

##tests

```
./test/parse_test
```
