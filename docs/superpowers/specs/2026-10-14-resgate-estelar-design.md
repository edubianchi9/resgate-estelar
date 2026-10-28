# Resgate Estelar: plano do jogo

## Objetivo

Quero fazer para Jogos Digitais II um jogo curto de horda, visto de cima, dentro de uma nave de carga infestada por ratos espaciais. O jogador precisa resgatar cinco aliados e mantê-los a salvo. O projeto cresce a cada aula, com cenas e scripts organizados de um jeito que eu consiga explicar.

## Carta do jogo

- Tema: nave de carga infestada por ratos espaciais.
- Tipo: resgate.
- Modo: horda, arena vista de cima.
- Objetivo: encontrar cinco aliados. Depois do resgate, eles seguem o jogador em fila.
- Vitória: resgatar os cinco aliados.
- Derrota: ficar sem vida ou deixar um rato tocar alguém da fila.

## Como a partida funciona

1. O jogador explora uma arena retangular, cercada por paredes e com obstáculos.
2. Ratos espaciais aparecem pelas bordas e perseguem o jogador.
3. Ao encostar em um aliado, o jogador o resgata. Os aliados seguem em sequência e mantêm a ordem e uma pequena distância entre si.
4. Um rato que encosta no jogador causa dano. Se alcançar alguém da fila, a partida termina em derrota.
5. O ataque do jogador elimina um rato por golpe e tem um intervalo entre usos. Atacar ajuda, mas não é obrigatório para vencer.
6. Resgatar cinco aliados mostra a vitória. Perder toda a vida ou deixar um rato alcançar a fila mostra a derrota. `Enter` reinicia a partida encerrada.

## Controles e interface

- Mover: setas ou `W`, `A`, `S`, `D`.
- Atacar: `Espaço`.
- Reiniciar depois do fim: `Enter`.
- O HUD mostra as vidas e quantos aliados foram resgatados, no formato `0/5`.

## Organização do projeto

- `scenes/` guarda a partida, a arena e a interface.
- `entities/` guarda as cenas do jogador, dos aliados e dos ratos.
- `scripts/` guarda o movimento, a fila de aliados, o objetivo, as vidas, o ataque e o comportamento dos ratos.
- `sprites/` é para arte própria ou recursos com autor, link e licença registrados no README.
- A cena principal inicia a partida, conta os resgates e decide quando há vitória ou derrota. Cada entidade cuida do próprio comportamento e avisa a cena principal quando algo importante acontece.
- Na Aula 10, os ratos ganham estados de comportamento e aprendem a contornar os obstáculos.
- No começo, o jogo usa formas simples. A arte do tema entra na Aula 11, depois que a partida já funciona.

## Documentação e autoria

- O README contém a carta do jogo, o modo, os controles e uma captura de tela.
- Código baseado em tutorial, documentação ou IA recebe um comentário com a origem. O aluno deve conseguir explicar cada trecho.
- Para arte, som ou fontes de terceiros, o README registra autor, link e licença.
- Projetos anteriores servem para consultar técnicas. O jogo novo não deve copiar o projeto anterior nem o trabalho de um colega.

## O que precisa funcionar

- O personagem anda nas quatro direções e para nas paredes.
- É possível resgatar cinco aliados e vê-los seguindo em fila.
- Os ratos aparecem pelas bordas e contornam obstáculos.
- O HUD mostra as vidas e o progresso `0/5`.
- O jogador pode vencer, perder e reiniciar.
- O jogo pode ser exportado para rodar fora do editor Godot.
- O aluno consegue explicar os arquivos e as decisões do projeto.

## Fora do plano inicial

Por enquanto, não vou incluir inventário, melhorias, chefes ou sistemas de progressão. O foco é fazer o resgate funcionar e acrescentar o conteúdo pedido em cada aula.
