# Diário de desenvolvimento

## Aula 08: arena e movimento em quatro direções

Data: 14/10/2026

### O que fiz

- Criei o projeto no Godot 4.7, com janela de 1152 × 648.
- Montei a arena vista de cima, com piso, marcações e quatro paredes com colisão.
- Fiz um personagem provisório usando `CharacterBody2D` e colisão circular.
- Configurei o movimento pelas setas e por `W`, `A`, `S`, `D`. A velocidade é 180 px/s, inclusive na diagonal.

Usei o ChatGPT para ajudar com o código e a montagem. Preciso entender cada parte para conseguir explicá-la.

### Teste

Abri a cena no Godot 4.7.2 e conferi o movimento nas quatro direções e a colisão com as paredes. Salvei uma captura em `screenshots/aula-08.png`.

## Aula 09: vida, dano e ataque (checkpoint 1)

Data: 21/10/2026

### O que fiz

- Adicionei três vidas, dano por contato e um breve período de invulnerabilidade depois de cada acerto.
- Criei ratos que aparecem pelas bordas e perseguem o jogador em linha reta. O desvio das caixas ficou para a Aula 10.
- Acrescentei um ataque curto na barra de espaço, com um intervalo entre usos.
- A partida mostra derrota quando a vida chega a zero. `Enter` está configurado para reiniciar.

Neste checkpoint ainda não havia aliados, contagem de resgates ou vitória por resgatar os cinco.

### Teste

Rodei o projeto no Godot 4.7.2. Vi os dois ratos perseguirem o personagem, o HUD mostrar `VIDA 3/3` e a derrota aparecer quando a vida acabou. Salvei uma captura em `screenshots/aula-09-checkpoint-1.jpg`. Não consegui confirmar o reinício com `Enter` naquele teste.

## Aula 09: aliados e resgate (checkpoint 2)

Data: 21/10/2026

### O que fiz

- Coloquei cinco aliados na arena. O jogador os resgata ao encostar neles.
- Depois do resgate, os aliados seguem o jogador em fila. O HUD conta de `0/5` até `5/5`.
- Resgatar os cinco dá vitória. Se um rato alcançar alguém da fila, a partida termina em derrota.

Fiz essa parte com ajuda do ChatGPT. Preciso saber explicar como funcionam o resgate, a fila e o fim da partida.

### Teste

Conferi no Godot a fila, a contagem de resgates e os finais da partida. A cena também abriu em modo headless, sem erros no registro. A captura que está no README ainda é do primeiro checkpoint.

## Aula 10: ratos contornam obstáculos

Data: 28/10/2026

### O que fiz

- Coloquei três caixas de carga na arena, todas com colisão.
- Criei uma grade para os ratos encontrarem um caminho até o jogador.
- Os ratos perseguem o jogador quando têm caminho livre, contornam as caixas quando encontram um bloqueio e atacam por contato.
- No primeiro teste, um rato oscilava mesmo com espaço livre. Ao recalcular a rota, ele voltava ao centro da célula onde já estava. Ajustei o início do caminho para evitar esse recuo.

Usei o ChatGPT para ajudar nesta etapa. Preciso conseguir explicar os estados do rato e como ele calcula o caminho.

### Teste

Na simulação, o rato ficou perto de `x=152` por dez segundos. Depois da correção, avançou até `x=553` no mesmo intervalo. No jogo, confirmei que os ratos pararam de oscilar e contornam os obstáculos.

No editor, confirmei que os ratos contornam as caixas sem oscilar, o jogador bate nelas e as mensagens de vitória e derrota ficam centralizadas.
