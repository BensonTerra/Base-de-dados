db.movies.find(
    {countries:{$in:["USA"]}},
    {_id:1,title:1,countries:1}
).limit(3);

db.movies.find(
    {$and:[{type:"series"},{languages:{$in:["Japanese"]}}]},
    {_id:0,title:1,languages:1,type:1}
).limit(3);

db.movies.find(
    {rating:{
        $gte:7.5,
        $lte:8.5
        }
    },
    {
        _id:1,
        title:1,
        rating:1,
        countries:1
    }
).limit(3);

db.movies.find(
    {genres:{$in:["Adventure"]}},
    {_id:1,title:1,countries:1}
).limit(3);