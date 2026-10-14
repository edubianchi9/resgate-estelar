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
