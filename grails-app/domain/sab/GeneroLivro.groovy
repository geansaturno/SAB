package sab

class GeneroLivro {

  static belongsTo = [
    genero: Genero,
    livro: Livro
  ]

    static constraints = {
    }

    String toString(){
      if(genero?.nome && livro?.titulo){
        "Genero: ${genero.nome} - Livro: ${livro.titulo}"
      }
    }
}
