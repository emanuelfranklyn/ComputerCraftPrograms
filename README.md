# ComputerCraftPrograms
Programas criados/modificados por min para ComputerCraft.

# ElevatorX (Not completly custom ambiant)
Um programa que permite o controle de seu elevador (até 16 andares) usando somente 1 computador.
Ambiente de uso:
  - Em cada andar deve ter 1 monitor que vai ser usado para chamar o elevador (Testado somente com monitores avançados)
  - O seu elevador deve ter um bloco que emita um sinal de redstone (para que o programa saiba a posição do elevador
  - Em cada andar o bloco de emição de sinal de redstone do elevador deve estar em contato com um cabo colorido (project-red)
  - Os cabos coloridos de cada andar devem estar conectados em um bundled cable proprio para eles seguindo a ordem de cores (Branco, Laranja, Magenta, Azul claro ...)
  - o controle de movimento do elevador (cabos que quando emitem um sinal de redstone fazem o elevador se deslocar para cima ou baixo) devem ser respectivamente Branco: subir, Laranja: Descer. E devem estar conectados em um bundled cable separado do dos andares.
  - O lado dos bundledCables é opcional na instalação do programa
  - Se você tiver um monitor dentro do seu elevador é recomendado o uso dele com 3 blocos de altura e 2 de largura
  - Ter um monitor dentro do elevador é opcional na instalação
  - Para refazer o processo de instalação caso você ainda não o tenha concluido basta apenas reiniciar o computador (control + T, control + R) Caso você tenha o concluido basta deletar o arquivo ElevatorCfg.lua
  - Apos a instalação você pode iniciar o controle do elevador rodando o programa novamente ou reiniciando o computador
  - É recomenado instalar o programa com o nome startup.lua para que o mesmo seja executado na inicialisação do elevador
  - O elevador por padrão desce para o primeiro andar (Terreo) quando iniciado
  
