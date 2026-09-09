import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/foto_model.dart';

class StorageService {
  static const String chaveFotos = 'fotos';

  static Future<List<FotoModel>> carregarFotos() async {
    final prefs = await SharedPreferences.getInstance();

    final dados = prefs.getString(chaveFotos);

    if (dados == null) {
      return [];
    }

    final List lista = jsonDecode(dados);

    return lista.map((item) => FotoModel.fromMap(item)).toList();
  }

  static Future<void> salvarFotos(List<FotoModel> fotos) async {
    final prefs = await SharedPreferences.getInstance();

    final dados = fotos.map((foto) => foto.toMap()).toList();

    await prefs.setString(
      chaveFotos,
      jsonEncode(dados),
    );
  }
}
