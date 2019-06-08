#!/usr/bin/env bash
#shellcheck disable=2155

#AUTHOR: Diego Mattos
#DESCRIBE: Get info of the YouTube
#LICENSE: Mit License
#VERSION: 0.1
#DATE: 08/06/2019

function vcsabiafunc(){

    local  vcsabia=$(mktemp)
    local  channel=$(mktemp)
           wget "$1" -O "$vcsabia" 2>/dev/null
    local  url="https://youtube.com/channel"
    local  titulo=$(grep '<title>' "$vcsabia" | sed 's/<[^>]*>//g' | sed 's/ - YouTube.*//g')
    local  id=$(grep 'meta itemprop' "$vcsabia" | sed -n '4p' | sed 's/\"//g' | sed 's/.\{39\}//' | sed 's/.$//g')
           wget "$url/$id" -O "$channel" 2>/dev/null
    local  nome_canal=$(sed -n '/title/{p; q;}' "$channel" | sed 's/<title>  //g')
    local  like=$(grep 'like-button-renderer-like-button' "$vcsabia" | sed 's/<[^>]*>//g' | sed -n '1p' | sed 's/ //g')
    local  inscritos=$(sed -n '/subscriber-count/{p; q;}' "$vcsabia" | sed 's/<[^>]*>//g' | sed 's/.\{30\}//')
    local  views=$(grep 'watch-view-count' "$vcsabia" | sed 's/<[^>]*>//g' | sed 's/ Au.*//g')
    local  dislike=$(grep 'like-button-renderer-dislike-button' "$vcsabia" | sed -n '1p' | sed 's/<[^>]*>//g' | sed 's/ //g')
    local  public=$(grep 'Publicado.*<\/strong>' "$vcsabia" | sed 's/.*Publicado/Publicado/g ; s/<\/strong>.*//g')

    echo "PUBLICADO: $public"
    echo "NOME DO CANAL: $nome_canal"
    echo "TITULO DO CANAL: $titulo"
    echo "LIKES DO VIDEO: $like"
    echo "NUMERO DE INSCRITOS: $inscritos"
    echo "DISLIKES DO VIDEO: $dislike"
    echo "VIZUALIZACOES: $views"
}

vcsabiafunc "$1"
