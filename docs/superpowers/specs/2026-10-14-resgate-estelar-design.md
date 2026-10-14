# Resgate Estelar — Design do jogo

## Objetivo

Criar para Jogos Digitais II um jogo curto de horda, visto de cima, ambientado em uma nave de carga infestada por ratos espaciais. O jogador precisa resgatar cinco aliados e sobreviver. O projeto deve crescer por etapas das aulas, usar cenas e scripts organizados e permanecer simples o bastante para que o aluno consiga explicar o próprio código.

## Carta do projeto

- **Tema:** nave de carga infestada por ratos espaciais.
- **Tipo:** Resgate.
- **Modo:** horda, arena vista de cima.
- **Objetivo:** encontrar cinco aliados; eles seguem o jogador em fila.
- **Vitória:** resgatar os cinco aliados.
- **Derrota:** a vida do jogador chega a zero ou um rato toca qualquer aliado da fila.

## Ciclo de jogo

1. O jogador explora uma arena retangular com paredes e obstáculos.
2. Ratos espaciais surgem pelas bordas e perseguem o jogador.
3. Ao tocar um aliado, o jogador o resgata. Os aliados seguem em sequência, mantendo a ordem e um espaço curto entre si.
4. Um rato que toca o jogador causa dano. Um rato que toca qualquer aliado encerra a partida.
5. O ataque curto do jogador elimina um rato por golpe e tem um intervalo entre usos. Atacar ajuda, mas não é necessário para vencer.
6. Resgatar cinco aliados mostra a vitória. Perder toda a vida ou deixar um rato alcançar a fila mostra a derrota. A tecla Enter reinicia a partida encerrada.

## Controles e interface

- **Mover:** setas ou `W`, `A`, `S`, `D`.
- **Atacar:** `Espaço`.
- **Reiniciar após o fim:** `Enter`.
- A interface mostra a vida e a contagem de aliados resgatados no formato `0/5`.

## Organização técnica

- `scenes/`: cena principal da partida, arena e interface.
- `entities/`: cenas reutilizáveis do jogador, dos aliados e dos ratos.
- `scripts/`: movimento, fila de seguidores, objetivo, vida, ataque e comportamento dos ratos.
- `sprites/`: arte própria ou recursos com origem e licença registrados no README.
- A cena principal coordena início, contagem de resgates, vitória e derrota. Cada entidade mantém sua responsabilidade local e comunica eventos relevantes à cena principal.
- A lógica dos ratos cresce para uma máquina de estados simples e navegação que contorna obstáculos na etapa da Aula 10.
- O protótipo começa com formas simples. A arte do tema entra na Aula 11, depois que o ciclo funciona.

## Documentação e autoria

- O README registra a carta, o modo, como jogar e uma captura de tela.
- Código de tutorial, documentação ou IA recebe um comentário indicando a origem; o aluno precisa conseguir explicar cada trecho.
- Arte, som ou fonte de terceiros terão autor, link e licença no README.
- Projetos anteriores podem servir para consultar técnicas, mas o jogo novo não deve copiar o jogo anterior nem o de um colega.

## Critérios de conclusão

- O personagem se move nas quatro direções e respeita as paredes.
- Cinco aliados podem ser resgatados e seguem em fila.
- Os ratos surgem nas bordas e contornam obstáculos.
- A interface mostra vida e progresso `0/5`.
- O jogador consegue vencer, perder e reiniciar.
- O jogo pode ser exportado para rodar fora do editor Godot.
- Os arquivos e decisões são organizados e explicáveis pelo aluno.

## Fora do escopo inicial

Não incluir inventário, melhorias, chefes ou sistemas de progressão. O foco é entregar o ciclo de Resgate pedido na carta e acrescentar somente o conteúdo previsto em cada aula.
