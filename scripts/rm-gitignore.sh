for path in $(cat .gitignore); 
do
    	cmd="rm -rf ${path}"
    	echo "[INFO]: executing - $cmd"
    	eval $cmd
done

