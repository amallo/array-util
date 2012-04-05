Array::indexOfFn = (fn) ->
  i = 0
  while i < @length 
    if fn(@[i])
      return i
    i++
  return -1


Array::remove = (fn) ->
  index = @indexOfFn(fn)
  if (index > -1)
    @splice(index,1)
    

Array::clear = (preserveReferences=false) ->
  if preserveReferences
    @length=0
  else
    @splice(0, @length)


Array::findAll = (fn)->
  foundArray=[]
  @forEach (elem, index, array)->
    if fn(elem,index,array)
      foundArray.push(elem)  
  foundArray

  
Array::find = (fn)->
  index=@indexOfFn(fn)
  if index>-1
    @[index]
  else
    null
      
#Fisher-Yates randomizing shuffle algorithm
Array::shuffle=()->
  i = @length
  if (i==0)
    return 
  while ( --i ) 
     j = Math.floor( Math.random() * ( i + 1 ) )
     tempi = @[i]
     tempj = @[j]
     @[i] = tempj
     @[j] = tempi


Array::groupBy = (fn)->
  set=[]
  @forEach (elem, index)->
    value = fn(elem)
    found = set.find (val)->
      val['by'] == value
    if found? 
      found['tokens'].push(elem)
    else
      set.push {'by':value, 'tokens':[elem]}
  set    

Array::count = (fn)-> 
  _count = 0
  @forEach (elem, index, array)->
    if (fn(elem, index, array))
      _count++
  _count
  
Array::max = (fn)-> 
   _max = fn(@[0])
   _maxIndex=0
   
   @forEach (elem, index)->
     if index > 0 && fn(elem) > _max  
       _max = fn(elem)
       _maxIndex=index
   @[_maxIndex]
   
Array::countUnique = (fn)->
  last = null
  count = 0
  @forEach (item, index)->
    if index == 0
      last = fn(item) 
    if fn(item)!=fn(last)
      count++
      last = item
  count   
      

Array::sequence = (maxSeqCount, fn)-> 
  #we assume array is sorted by highest values.
  last = @[0]
  index = 1
  seq = [@[0]]
  seqCount = 1
  while index < @length && seqCount < maxSeqCount
    diff = fn(last,@[index])
    #we start a new sequence 
    if diff > 1 
      seq.length=0 # don't destroy instances !
      seqCount=0
    #increment seq counter if prec and current values are not equal.
    if diff != 0
      seqCount++      
    last = @[index]
    seq.push(@[index])
    index++
  seq
  
Array::exclude = (fn)->
  filterFn = (elem)->
    !fn(elem)
  @filter filterFn
