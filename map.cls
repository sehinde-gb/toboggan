Class Toboggan.Map Extends %Persistent
{

Property map As %ArrayOfDataTypes;

Property right As %ArrayOfDataTypes;

Property down As %ArrayOfDataTypes;

Property trees As %ArrayOfDataTypes;

ClassMethod Import(dir As %String = "/usr/local/day3.txt") As %Status
{
    // Open my text file and check it exists
    IF ##class(%File).Exists(dir) '=1 {
    write !, "Unable to Open: "_dir
    QUIT}
    ELSE { write "File: "_dir_" is open"
    }

    // instantiate a new class called file
    set file = ##class(%Stream.FileCharacter).%New()
    // create a new variable called sc
    set sc = file.LinkToFile(dir)
    set count=1
    /// loop to go through the day3 txt file 
    WHILE ('file.AtEnd) 
    {
        set delim=" "
        set line = file.ReadLine()
        write !, "Loop started"
        write *32
        write line,!

        
        // Extract each tree position and assign to a new array called map
        set map(count)=$PIECE(line, delim)
        set countdown=$LENGTH(line,delim)
        set count=$INCREMENT(count)        
    }
        write !,*32
        write !, "Double checking to see if the map array is set"
        write !,*32
        
        write !, "1st element of map array ", map(1)
        write !, "2nd element of map array ", map(2)

        write !, "Import process complete"
        write *32
        
        do ..Setup(.map,.right)
}

ClassMethod Setup(ByRef map As %ArrayOfDataTypes, ByRef right As %ArrayOfDataTypes,ByRef down As %ArrayOfDataTypes, ByRef trees As %ArrayOfDataTypes) As %Status
{
    
    // set up the fields of the map array            
                              
    do map.SetAt(map(1),"1")
    do map.SetAt(map(2),"2")
    do map.SetAt(map(3),"3")
    do map.SetAt(map(4),"4")
    do map.SetAt(map(5),"5")
    do map.SetAt(map(6),"6")
    do map.SetAt(map(7),"7")
    do map.SetAt(map(8),"8")
    do map.SetAt(map(9),"9")
    do map.SetAt(map(10),"10")
    do map.SetAt(map(11),"11")
        
     
    // set up the right array
                   
    do right.SetAt("1","1")
    do right.SetAt("3","2")
    do right.SetAt("5","3")
    do right.SetAt("7","4")
    do right.SetAt("1","5")

    

    //set up the down array
                                
    do down.SetAt("1","1")
    do down.SetAt("1","2")
    do down.SetAt("1","3")
    do down.SetAt("1","4")
    do down.SetAt("2","5")

    
    //set up the trees array
    do trees.SetAt("0","1")
    do trees.SetAt("0","2")
    do trees.SetAt("0","3")
    do trees.SetAt("0","4")
    do trees.SetAt("0","5")

    //do ..partOne(.map)
    do ..partTwo(.map,.right,.down,.trees)
}

/// Part two change the row and columns so that they the positions are dynamic
ClassMethod partTwo(ByRef map As %ArrayOfDataTypes, ByRef right As %ArrayOfDataTypes, ByRef down As %ArrayOfDataTypes, ByRef trees As %ArrayOfDataTypes) As %Status
{
        

    for i=1:1:right.Count(),1:1:down.Count()  {

        // initialise the variables we will use
        set row = 0
        set column = 0
        set rowMax = 11-1
        
        write "rowMax Length:=", rowMax ,!
        set colMax = rowMax-1
        write "colMax Length:=",colMax ,!

        if (row < rowMax) {
            
            write "Next Record"
            write *32 ,!
            set delim="."

            // Loop over the array and find # set the tree count and column and row fields that are set dynamically
            for i=1:1:map.Count() { 
                set map(i)=map.GetAt(i)
                write *32 ,!
                write "# Numbers: " ,!
                write $LOCATE(map(i),"#") ,!
            
                set trees(i) = $LOCATE(map(i),"#") 
                write "Number of trees: ",trees(i) ,!                             
            
                set right(i)=right.GetAt(i)
                set column = right(i)
                write *32 ,!
                write "Column:", column ,!
            
                set down(i)=down.GetAt(i)
                set row = down(i)
                write *32 ,!
                write "Row:",row ,!
                write *32 ,!
                write !,"All done!"
                write *32 ,!

                
            } 
            
            // output the tree count and product to the screen
            write "Trees 1: ",trees(1) ,!

            set product = trees(1) * trees(2) * trees(3) * trees(4) * trees(5)
            write "Product is:",product ,!
        }

       
    }
}

/// Description
ClassMethod partOne(ByRef map As %ArrayOfDataTypes) As %Status
{
    
    // initialise the variables we will use
    set row = 0
    set column = 0
    set trees = 0
    set rowMax = $LENGTH(map)-1
                
    write "Length:=", rowMax ,!
    set colMax = rowMax-1
                
    while (row <= rowMax) {
        // Count the array nodes and then find out the length of the array
        for i=1:1:map.Count() { 
            set map(i)=map.GetAt(i)
            write map(i), !
                                                 
            set delim="."
            set countdown=$LENGTH(map(i),delim)
            set trees=1


            // Map over the array with our piece and extract the positions
            // set the trees and assign a column and row statically
            
            For reps=countdown:-1:1 {
                set extract=$PIECE(map(i),delim,trees)
                write !,trees," ",extract
                set trees=trees+1
                }
                write !,"All done!"
                                                 
                                                 
                
                set column = column+3 
                write *32 ,!
                write "Row:",row ,!
                write *32 ,!
                write "Column:", column ,!
                write *32 ,!
                                                
                // Increment the row and column numbers only if the column hasn't got to the end
                if (column >= colMax) {
                    set column = colMax +1 
                    set row = $INCREMENT(row)
                    write row ,!
                }}
        }
}

Storage Default
{
<Data name="MapDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>map</Value>
</Value>
</Data>
<DataLocation>^Toboggan.MapD</DataLocation>
<DefaultData>MapDefaultData</DefaultData>
<IdLocation>^Toboggan.MapD</IdLocation>
<IndexLocation>^Toboggan.MapI</IndexLocation>
<StreamLocation>^Toboggan.MapS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
