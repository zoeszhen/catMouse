FILE='ukkonodes'
counter=0

while read line
do
	EvenOdd=$( expr $counter % 2 )

	if [ $EvenOdd -ne 0 ]
	then
		./chase_cat.sh S Catty $i
        #if the node is odd let Catty check first

         [[ -f "cmsg" ]] && grep -q "F" "cmsg" && echo "FOUND" && ./chase_cat.sh S Jazzy $i
        #if Catty found the cat, then Cordy dispatch Jazzy to check 

         [[ -f "cmsg" ]] && grep -q "F $i Jazzy" "cmsg" && echo "be sure there" && ./chase_cat.sh A Catty $i
         
         #if Jazzy also found a mouse on that node, Cordy will send Catty attack the mouse 
          
        [[ -f "cmsg" ]] && grep -q "G" "cmsg" && echo "The mouse dead" && exit 0
        #send got mouse message back and finish whole program
        sleep 4
	else
		 
        ./chase_cat.sh S Jazzy $i
        #if the node is even let Jazzy check it first

         [[ -f "cmsg" ]] && grep -q "F" "cmsg" && echo "FOUND" && ./chase_cat.sh S Catty $i
         #if Jazzy found the cat, then Cordy dispatch Catty to check 
         [[ -f "cmsg" ]] && grep -q "F $i Jazzy" "cmsg" && echo "be sure there" && ./chase_cat.sh A Jazzy $i
         #if Catty also found the mouse there, then Cordy let Jazzy attack the mouse
         
         [[ -f "cmsg" ]] && grep -q "G" "cmsg" && echo "The mouse dead" && exit 0
        #send got mouse message back and finish whole program
        sleep 4
	fi

	(( counter ++ ))
done < $FILE
