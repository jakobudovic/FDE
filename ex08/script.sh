sudo install postgresql createuser jakob
sudo install postgresql createdb jakob


# Trim start and end of actors.list into actorsTrimmed.list
cat actors.list | tail -n +240 | head -n -272 >> actorsTrimmed.list
# convert to utf-8
iconv -f latin1 -t utf-8 actorsTrimmed.list > actorsUtf8.list
 
sed -r -e 's/\t+/|/g' -e 's/((\s*)|(\{.*\})|(\[.*\])|(<.*>)|\(.*[a-zA-Z].*\))*$//g' actorsUtf8.list | awk -F'|' '{if($1 != ""){actor=$1}; if ($2) print actor "|" $2}' > actors.csv
 
sudo -u postgres createuser <your user>
sudo -u postgres createdb imdb
psql -d imdb
CREATE TABLE playedin_text (
    actor_name text not null,
    movie_name text not null);
\copy playedin_text from actors.csv delimiter '|';