arrayutil = require("../lib/array-util")

exports['Array::indexOf by function'] =  (test)  ->
   array = [{username:"me"},{username:"meToo"},{username:"meOfCourse"}]
   fn = (player) -> player.username == "meToo"
   index = array.indexOfFn(fn)
   test.equal(index, 1)
   test.done()

exports['Array::indexOf by function with non existing value'] =  (test)  ->
   array = [{username:"me"},{username:"meToo"},{username:"meOfCourse"}]
   fn = (player) -> player.username == "meTooToo"
   index = array.indexOfFn(fn)
   test.equal(index, -1)
   test.done()


exports['Array::remove by function'] =  (test)  ->
   array = [{username:"me"},{username:"meToo"},{username:"meOfCourse"}]
   array.remove (player) -> player.username == "meToo"

   test.equal array[0].username, "me"
   test.equal array[1].username, "meOfCourse"
   test.equal(array.length, 2)
   
   array.remove (player) -> player.username == "imNotHere"
   test.equal(array.length, 2)
   
   array.remove (player) -> player.username == "meOfCourse"
   test.equal array[0].username, "me"
   test.equal(array.length, 1)
   
   test.done()
   
   

exports['Array::clear'] =  (test)  ->
   array = [{username:"me"},{username:"meToo"},{username:"meOfCourse"}]
   array.clear()
   test.equal(array.length, 0)
   test.done()
   
exports['Array::shuffle'] =  (test)  ->
   array = [{username:"me"},{username:"meToo"},{username:"meOfCourse"}]
   array.shuffle()
   console.log array
   test.done()
   
exports['Array::find'] =  (test)  ->
   array = [{username:"me"},{username:"meToo"},{username:"meOfCourse"}]

   player = array.find (p)->
     p.username == array[1].username
   test.equal player, array[1]
   
   player = array.find (p)->
     p.username == "meToo2"
   test.equal player, null
   
   test.done()

exports['Array::findAll'] =  (test)  ->
   array = [{username:"me"},{username:"me"},{username:"meOfCourse"}]

   players = array.findAll (p)->
     p.username == array[1].username
   
   test.equal players.length, 2
   
   test.done()
   
exports['Array::find in empty array'] =  (test)  ->
   array = []
   player = array.find (p)->
     p.username == "meToo"
   test.equal player, null
   
   test.done()
   
exports['Array::groupBy'] =  (test)  ->
   array = [{rank:1, suite:"spade"},
            {rank:1, suite:"diamond"},
            {rank:2, suite:"spade"},
            {rank:2, suite:"heart"},
            {rank:3, suite:"spade"}]
   groups = array.groupBy (card)->
     card.rank
     
   test.equal groups.length,3
   
   
   test.equal groups[0].by,1
   test.equal groups[1].by,2
   test.equal groups[2].by,3
   
   groups = array.groupBy (card)->
     card.suite
   test.equal groups.length,3  
   test.equal groups[0].by,"spade"
   
   
   test.done()
   

exports['Array::count'] =  (test)->
   array = [{rank:1, suite:"spade"},
            {rank:1, suite:"diamond"},
            {rank:2, suite:"spade"},
            {rank:2, suite:"heart"},
            {rank:3, suite:"spade"}]
   
   count = array.count (card)->
     card.rank==1
   test.equal count, 2
   
   count = array.count (card)->
     card.suite=="diamond"
   test.equal count, 1

   
   test.done()
  

exports['Array::max'] =  (test)->
   array = [{rank:1, suite:"spade"},
            {rank:1, suite:"diamond"},
            {rank:8, suite:"spade"},
            {rank:2, suite:"heart"},
            {rank:3, suite:"spade"}]
   
   maxCard = array.max (card)->
     card.rank
   test.equal maxCard.rank, 8
   
   
   test.done()
   
exports["Array::countUnique"] =  (test)->
  cards = [{rank:8, suite:"club"},{rank:9, suite:"club"},{rank:9, suite:"diamond"},{rank:12, suite:"club"},{rank:13, suite:"club"}]  
  test.equal (cards.countUnique (card)->card.rank),4
  
  cards = [{rank:9, suite:"club"},{rank:9, suite:"club"},{rank:9, suite:"diamond"},{rank:9, suite:"club"},{rank:9, suite:"club"}]  
  test.equal (cards.countUnique (card)->card.rank),1
  
  cards = [{rank:9, suite:"club"},{rank:10, suite:"club"},{rank:11, suite:"diamond"},{rank:12, suite:"club"},{rank:13, suite:"club"}]  
  test.equal (cards.countUnique (card)->card.rank),cards.length
  
  test.done()
  
exports["Array::sequence"] =  (test)->

  cards = [{rank:8, suite:"club"},{rank:7, suite:"club"},{rank:8, suite:"club"},{rank:4, suite:"diamond"},{rank:9, suite:"club"},{rank:9, suite:"diamond"},{rank:12,suite: "club"},{rank:13,suite: "club"}]
  cards.sort (card1, card2)->
    card2.rank - card1.rank  
  
  console.log("cards",cards)  
  seq = cards.sequence(5, (card1, card2)->card1.rank - card2.rank)    
  #console.log(seq)
  test.equal(1, seq.length)
  
  seq = cards.sequence(3, (card1, card2)->card1.rank - card2.rank)  
  console.log("seq(3)",seq)
  test.equal(5, seq.length)
  
  seq = cards.sequence(4, (card1, card2)->card1.rank - card2.rank)  
  console.log("seq(4)",seq)
  test.equal(1, seq.length)
  
  cards = [{rank:5, suite:"club"},{rank:5, suite:"club"},{rank:9, suite:"club"}, {rank:10,suite: "diamond"},{rank:10,suite: "club"},{rank:11,suite: "diamond"},{rank:12,suite: "club"},{rank:13,suite: "club"}]
  cards.sort (card1, card2)->
    card2.rank - card1.rank  
  #console.log("cards",cards)
  seq = cards.sequence(5, (card1, card2)->card1.rank - card2.rank)  
  
  test.equal(6, seq.length)
  #console.log("sequence",seq.length)
  test.done()  
  
exports["Array::exclude"] =  (test) ->

  players = [{username:"itsme"}, {username:"excludeme"}]
  newArray = players.exclude (elem)-> 
    console.log elem.username
    elem.username == "excludeme"
    
  test.equal players.length,2
  test.equal newArray.length,1
  test.equal newArray[0].username,"itsme"

  test.done()
