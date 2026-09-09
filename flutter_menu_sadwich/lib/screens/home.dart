import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gal/gal.dart';

import '../models/foto_model.dart';
import '../services/storage_service.dart';

import 'detalhes.dart';
import 'splash.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ImagePicker _picker = ImagePicker();

  List<FotoModel> fotos = [];

  @override
  void initState() {
    super.initState();

    carregarFotos();
  }

  Future<void> carregarFotos() async {
    final lista = await StorageService.carregarFotos();

    setState(() {
      fotos = lista;
    });
  }

  Future<void> tirarFoto() async {
    try {
      final XFile? imagem = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (imagem == null) return;

      await Gal.putImage(imagem.path);

      final anotacao = await mostrarModalAnotacao();

      if (anotacao == null) return;

      final agora = DateTime.now();

      final foto = FotoModel(
        caminho: imagem.path,
        nome: 'foto_${agora.millisecondsSinceEpoch}.jpg',
        anotacao: anotacao,
        dataHora: '${agora.day.toString().padLeft(2, '0')}/'
            '${agora.month.toString().padLeft(2, '0')}/'
            '${agora.year} '
            '${agora.hour.toString().padLeft(2, '0')}:'
            '${agora.minute.toString().padLeft(2, '0')}',
      );

      setState(() {
        fotos.insert(0, foto);
      });

      await StorageService.salvarFotos(fotos);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Foto salva com sucesso!'),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao tirar foto: $e'),
        ),
      );
    }
  }

  Future<String?> mostrarModalAnotacao() async {
    final controller = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Adicionar anotação'),
          content: TextField(
            controller: controller,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: 'Digite uma anotação para a foto',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  controller.text,
                );
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void abrirDetalhes(int index) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Detalhes(
          foto: fotos[index],
        ),
      ),
    );

    carregarFotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Galeria'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.photo_library,
                    size: 60,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Minha Galeria',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Início'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Abrir câmera'),
              onTap: () {
                Navigator.pop(context);
                tirarFoto();
              },
            ),
            ListTile(
              leading: const Icon(Icons.refresh),
              title: const Text('Splash'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Splash(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Sair'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: fotos.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.photo_library_outlined,
                    size: 90,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Nenhuma foto ainda',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Toque no botão abaixo para tirar uma foto',
                  ),
                ],
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemCount: fotos.length,
              itemBuilder: (context, index) {
                final foto = fotos[index];

                return GestureDetector(
                  onTap: () {
                    abrirDetalhes(index);
                  },
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.file(
                            File(foto.caminho),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                foto.nome,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                foto.dataHora,
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: tirarFoto,
        icon: const Icon(
          Icons.camera_alt,
        ),
        label: const Text(
          'Tirar foto',
        ),
      ),
    );
  }
}
