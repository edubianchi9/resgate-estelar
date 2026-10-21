# Diário de desenvolvimento

## Aula 08 — arena e movimento em quatro direções

**Data:** 14/10/2026

### Trabalho desta etapa

- Criada a base do projeto Godot 4.7 com janela de 1152 × 648.
- Montada uma arena vista de cima com piso, marcações discretas e quatro paredes externas com colisão.
- Adicionado um personagem provisório com `CharacterBody2D` e colisão circular.
- Configurados movimento pelas setas e por `W`, `A`, `S`, `D`, com velocidade inicial de 180 px/s e diagonais normalizadas.

O código e a montagem desta etapa foram feitos com assistência do Codex. O aluno deve revisar e conseguir explicar cada parte antes da entrega.

### Conferência

O projeto e a cena principal foram carregados no Godot 4.7.2. A execução conferiu movimento nas quatro direções, deslocamento diagonal normalizado e bloqueio pelas quatro paredes externas. A captura da arena em execução foi salva em `screenshots/aula-08.png`.

## Aula 09 — checkpoint 1

**Data:** 21/10/2026

### Trabalho desta etapa

- Adicionadas três vidas, dano por contato e invulnerabilidade breve depois de cada acerto.
- Criados ratos provisórios que surgem pelas bordas e perseguem o jogador em linha reta. Desvio de obstáculos fica para a Aula 10.
- Adicionado um ataque curto pela barra de espaço, com intervalo entre usos.
- A tela mostra derrota quando a vida chega a zero; Enter está configurado para reiniciar.

Ainda faltam os aliados seguidores, a contagem de resgates, a vitória por resgatar os cinco e a derrota caso um rato alcance a fila.

### Conferência

O projeto foi importado e executado no Godot 4.7.2. A execução mostrou a arena, dois ratos perseguindo o personagem, o HUD `VIDA 3/3` e a tela de derrota após a vida chegar a zero. A captura deste estado foi salva em `screenshots/aula-09-checkpoint-1.jpg`. A tecla Enter está mapeada para reiniciar, mas não foi possível confirmar essa entrada usando o teclado sintético do editor.
