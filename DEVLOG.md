# Diário de desenvolvimento

## Aula 08: arena e movimento em quatro direções

Data: 14/10/2026

### O que fiz

- Criei o projeto no Godot 4.7, com janela de 1152 × 648.
- Montei a arena vista de cima, com piso, marcações e quatro paredes com colisão.
- Fiz um personagem provisório usando `CharacterBody2D` e colisão circular.
- Configurei o movimento pelas setas e por `W`, `A`, `S`, `D`. A velocidade é 180 px/s, inclusive na diagonal.

Usei o ChatGPT para ajudar com o código e a montagem da arena. Quero entender cada parte para explicar como fiz.

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

Rodei o projeto no Godot 4.7.2. Os dois ratos perseguiam o personagem, o HUD mostrava `VIDA 3/3` e a derrota aparecia quando a vida acabava. Salvei uma captura em `screenshots/aula-09-checkpoint-1.jpg`. Naquele teste, não cheguei a confirmar o reinício com `Enter`.

## Aula 09: aliados e resgate (checkpoint 2)

Data: 21/10/2026

### O que fiz

- Coloquei cinco aliados na arena. O jogador os resgata ao encostar neles.
- Depois do resgate, os aliados seguem o jogador em fila. O HUD conta de `0/5` até `5/5`.
- Resgatar os cinco dá vitória. Se um rato alcançar alguém da fila, a partida termina em derrota.

Usei o ChatGPT como ajuda no código. Ainda preciso estudar como funcionam o resgate, a fila e o fim da partida para explicar na apresentação.

### Teste

No Godot, conferi a fila, a contagem de resgates e as telas de vitória e derrota. Também abri a cena em modo headless. A captura do README ainda mostrava o primeiro checkpoint.

## Aula 10: ratos contornam obstáculos

Data: 28/10/2026

### O que fiz

- Coloquei três caixas de carga na arena, todas com colisão.
- Criei uma grade para os ratos encontrarem um caminho até o jogador.
- Os ratos perseguem o jogador quando têm caminho livre, contornam as caixas quando encontram um bloqueio e atacam por contato.
- No primeiro teste, um rato oscilava mesmo com espaço livre. Ao recalcular a rota, ele voltava ao centro da célula onde já estava. Ajustei o início do caminho para evitar esse recuo.

Usei o ChatGPT para ajudar nesta etapa. Vou revisar os estados do rato e o cálculo do caminho para conseguir explicar como funcionam.

### Teste

Na simulação, o rato ficou perto de `x=152` por dez segundos. Corrigi o cálculo do caminho e, no mesmo intervalo, ele chegou a `x=553`. Depois, confirmei no jogo que os ratos contornam as caixas sem oscilar.

No Godot, confirmei o desvio das caixas e a colisão delas com o jogador. As mensagens de vitória e derrota também ficaram centralizadas.

## Aula 11: arte da nave e horda

Data: 04/11/2026

Desenhei cinco artes SVG com ajuda do ChatGPT: nave, caixa, jogador, aliado e rato. Fiz o piso de metal com luzes e ventilações, e marquei as caixas com faixas de segurança. O jogador veste azul; os aliados, verde. Os personagens viram ao andar e o jogador pisca depois de levar dano.

Aumentei o limite da horda de quatro para 24 ratos. Cada rato consulta a linha de visão a cada 0,12 segundo, com um pequeno atraso inicial diferente. Isso evita que todos façam a consulta no mesmo quadro. As colisões e o contato ainda são verificados a cada passo de física.

No Godot, conferi que movimento, colisões, ataque, resgate, vitória, derrota e reinício funcionam com a arte nova. A captura da partida está em `screenshots/aula-11.png`.

Na simulação com renderização, o contador ficou em 200 FPS tanto com 24 quanto com 96 ratos, que é o limite do projeto. A física levou em média 0,58 ms e 1,72 ms, respectivamente. Usei a arena e deixei o alvo em movimento; esses números dependem do computador. O Godot não conseguiu gravar o cache de shaders neste ambiente, mas abriu a cena e salvou a captura.
