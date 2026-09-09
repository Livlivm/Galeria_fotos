#  Galeria de Fotos 

Aplicativo desenvolvido em Flutter como atividade prática da Aula 03 de Programação para Dispositivos Móveis 2 (PPDM2), do curso de Desenvolvimento de Sistemas.

O projeto consiste em um aplicativo de galeria de fotos desenvolvido para utilizar recursos do dispositivo móvel, permitindo capturar imagens pela câmera, registrar informações sobre os momentos e gerenciar as fotos salvas pelo aplicativo.

## Capacidades técnicas

* Projetar interfaces para dispositivos móveis.
* Implementar código respeitando as características da linguagem e da plataforma mobile.

## Conhecimentos aplicados

### Criação de interface

* Estrutura e leiaute de telas.
* Componentes de interface.
* Navegação entre telas.
* Menu de navegação.
* Organização das informações na tela.

### Recursos de hardware

* Multimídia.
* Câmera.
* Galeria de imagens.
* Armazenamento local.
* Compartilhamento de imagens.

## Sobre o aplicativo

O aplicativo foi desenvolvido com o objetivo de criar uma galeria de fotos personalizada, permitindo que o usuário registre momentos utilizando a câmera do dispositivo.

As imagens registradas pelo aplicativo podem ser visualizadas em uma galeria, acompanhadas de informações como data, horário e anotação. Também é possível acessar os detalhes de uma foto e realizar ações como compartilhar ou excluir o registro.

## Funcionalidades

* Splash Screen com apresentação inicial do aplicativo.
* Tela principal.
* Menu Sandwich (Drawer).
* Acesso à câmera do dispositivo.
* Captura de fotos.
* Adição de anotações às fotos.
* Registro da data e horário da captura.
* Galeria com as fotos registradas pelo aplicativo.
* Visualização das fotos em detalhes.
* Visualização da foto em tamanho maior.
* Compartilhamento das imagens.
* Exclusão de fotos.
* Armazenamento local das informações das fotos.
* Salvamento das imagens na galeria do dispositivo.

> As fotos que já estavam salvas anteriormente na galeria do celular não fazem parte da galeria do aplicativo. São exibidas somente as fotos registradas pelo próprio aplicativo.

## Tecnologias utilizadas

* Flutter
* Dart
* Android
* image_picker
* gal
* path_provider
* share_plus

## Estrutura do projeto

```text
lib/
├── main.dart
├── models/
│   └── foto.dart
├── services/
│   └── foto_service.dart
├── screens/
│   ├── splash.dart
│   ├── home.dart
│   └── detalhes.dart
└── widgets/
```

## Execução do projeto

Para executar o aplicativo, é necessário possuir o Flutter instalado e configurado, além de um dispositivo Android físico ou um emulador.

Primeiro, instale as dependências do projeto:

```bash
flutter pub get
```

Depois, execute o aplicativo:

```bash
flutter run
```

## APK

O arquivo APK será disponibilizado como parte da entrega do projeto.


## Repositório

O código-fonte completo do aplicativo está disponível no GitHub.

**GitHub:**
`COLOQUE_AQUI_O_LINK_DO_GITHUB`

## Objetivo da atividade

A atividade teve como objetivo desenvolver uma aplicação mobile utilizando Flutter, aplicando conhecimentos relacionados à criação de interfaces e ao acesso aos recursos de hardware de um dispositivo.

Durante o desenvolvimento foram trabalhados conceitos de câmera, galeria de imagens, armazenamento local, navegação entre telas e compartilhamento de arquivos.

## Conclusão

O projeto possibilitou colocar em prática os conhecimentos apresentados na Aula 03, desenvolvendo uma aplicação funcional para gerenciamento de fotos e explorando recursos disponíveis em dispositivos móveis.
