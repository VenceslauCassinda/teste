class ValidacaoCampos {
  bool validarEmail(String? email) {
    return email!.contains("@");
  }

  bool validarPalavraPasse(String palavra_passe) {
    if (palavra_passe.length < 8) {
      return false;
    }
    return true;
  }

  bool validarAlteracaoPalavraPasse(List<String> lista_palavra_passe_e_antiga) {
    if (lista_palavra_passe_e_antiga[0].length < 8 ||
        lista_palavra_passe_e_antiga[0] != lista_palavra_passe_e_antiga[1]) {
      return false;
    }
    return true;
  }

  bool validarNome(String nome) {
    if (RegExp(
            """^[A-ZA-Z\u00C0-\u00D6\u00D8-\u00f6\u00f8-\u00ff\s]+(([',. -][A-ZA-Z\u00C0-\u00D6\u00D8-\u00f6\u00f8-\u00ff\s])?[A-ZA-Z\u00C0-\u00D6\u00D8-\u00f6\u00f8-\u00ff\s]*)*""")
        .hasMatch(nome)) {
      return true;
    }
    return false;
  }

  bool validarGenerico() {
    return true;
  }
}

enum TipoCampoTexto {
  generico,
  nome,
  email,
  numero,
  palavra_passe,
  alteracao_palavra_passe
}
