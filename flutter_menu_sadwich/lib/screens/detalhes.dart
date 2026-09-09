import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../models/foto_model.dart';
import '../services/storage_service.dart';

class Detalhes extends StatefulWidget {
  final FotoModel foto;

  const Detalhes({
    super.key,
    required this.foto,
  });

  @override
  State<Detalhes> createState() => _DetalhesState();
}

class _DetalhesState extends State<Detalhes> {
  Future<void> excluirFoto() async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Excluir foto?',
          ),
          content: const Text(
            'Deseja realmente excluir esta foto?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  false,
                );
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  true,
                );
              },
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );

    if (confirmar != true) return;

    try {
      final arquivo = File(
        widget.foto.caminho,
      );

      if (await arquivo.exists()) {
        await arquivo.delete();
      }

      final fotos = await StorageService.carregarFotos();

      fotos.removeWhere(
        (foto) => foto.caminho == widget.foto.caminho,
      );

      await StorageService.salvarFotos(
        fotos,
      );

      if (!mounted) return;

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Erro ao excluir: $e',
          ),
        ),
      );
    }
  }

  Future<void> compartilharFoto() async {
    final arquivo = File(
      widget.foto.caminho,
    );

    if (!await arquivo.exists()) {
      return;
    }

    await SharePlus.instance.share(
      ShareParams(
        text: widget.foto.anotacao.isEmpty
            ? 'Foto da minha galeria'
            : widget.foto.anotacao,
        files: [
          XFile(widget.foto.caminho),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalhes da foto',
        ),
        actions: [
          IconButton(
            onPressed: compartilharFoto,
            icon: const Icon(
              Icons.share,
            ),
            tooltip: 'Compartilhar',
          ),
          IconButton(
            onPressed: excluirFoto,
            icon: const Icon(
              Icons.delete,
            ),
            tooltip: 'Excluir',
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: InteractiveViewer(
              child: Image.file(
                File(widget.foto.caminho),
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.foto.nome,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Capturada em: '
                  '${widget.foto.dataHora}',
                ),
                const SizedBox(height: 15),
                const Text(
                  'Anotação:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.foto.anotacao.isEmpty
                      ? 'Nenhuma anotação.'
                      : widget.foto.anotacao,
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: compartilharFoto,
                        icon: const Icon(
                          Icons.share,
                        ),
                        label: const Text(
                          'Compartilhar',
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: excluirFoto,
                        icon: const Icon(
                          Icons.delete,
                        ),
                        label: const Text(
                          'Excluir',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
