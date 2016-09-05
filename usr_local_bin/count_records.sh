NUM_BSQL_COPY_LINES=$1

files=($2/*)

total_records=0

for item in ${files[*]}
do
  line_count=$(( `wc -l $item | awk '{print $1}'` ))
  num_records=$(( line_count - NUM_BSQL_COPY_LINES ))
  total_records=$(( total_records + num_records ))
  printf "   %s: %s (total: %s)\n" $item $num_records $total_records
done


printf "total records: %s\n" $total_records
