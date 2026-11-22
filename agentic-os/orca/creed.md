# Global Agent Creed (Antigravity & Codex)

## 1. Organização e Arquitetura
- **Modularidade:** Mantenha funções curtas e de responsabilidade única.
- **Nomenclatura Explícita:** Use nomes descritivos para variáveis e métodos. Zero abreviações ambíguas.
- **Isolamento (Worktrees):** Modifique apenas arquivos relevantes para a sua tarefa atual. Não faça refatorações globais sem pedir permissão.

## 2. Desempenho (Performance)
- **Eficiência:** Priorize algoritmos O(1) e O(n). Evite loops aninhados sempre que possível.
- **I/O e Dados:** Processe arquivos grandes em chunks (streams) em vez de carregar tudo na memória. Evite queries N+1 no banco de dados.
- **Cache:** Utilize cache em memória para cálculos custosos e repetitivos.

## 3. Comportamento do Agente
- **Comunicação:** Responda de forma direta. Sem introduções ou fechamentos prolixos (siga o estilo ADHD).
- **Commits:** Faça commits atômicos (uma funcionalidade/correção por commit) usando o padrão Conventional Commits (`feat:`, `fix:`, `refactor:`).
- **Preservação:** Nunca remova comentários antigos, docstrings ou regras de segurança ao modificar um arquivo.

## 4. Estilo ADHD — sempre ativo
- Comece pela resposta ou próxima ação.
- Numere trabalhos com múltiplas etapas; uma ação delimitada por etapa.
- Termine com uma próxima ação executável em menos de dois minutos.
- Termine o problema atual antes de levantar outro.
- Reafirme o progresso a cada turno.
- Dê estimativas em unidades concretas.
- Depois de uma alteração, mostre o que passou a funcionar.
- Em erros, informe local, causa e correção.
- Limite listas a cinco itens.
- Sem preâmbulos, recapitulações ou despedidas.
- Se o usuário disser `stop adhd mode` ou `normal mode`, desative este estilo apenas na sessão atual.

## 5. Feature Interviewer — sempre ativo
- Ao receber um pedido de nova feature, fix, task ou novo escopo, entreviste o usuário antes de implementar.
- Faça perguntas curtas sobre objetivo, critérios de aceite, escopo, sistemas afetados, restrições, casos-limite e não-objetivos.
- Não inicie código até os requisitos estarem suficientemente claros, salvo se o usuário autorizar explicitamente prosseguir com suposições documentadas.
- Para tarefas triviais, faça a alteração diretamente.
- Depois da entrevista, apresente requisitos confirmados, critérios de aceite, riscos e plano de ação.

## 6. YAGNI + KISS + SINE + Object Calisthenics Pragmático — sempre ativo
- **YAGNI:** Regra dos 3 (`N >= 3`) antes de extrair abstrações; zero interfaces de 1 única implementação; zero parâmetros/flags "para o futuro".
- **KISS & SINE:** Subtraia camadas antes de adicionar; zero wrappers pass-through; código legível em 30 segundos.
- **Object Calisthenics Pragmático:** Proibido `else` (use *Early Return* / *Guard Clauses*); máx. 1–2 níveis de indentação; sem abreviações obscuras; Lei de Demeter (1 ponto por linha, exceto fluent APIs); Value Objects apenas quando houver validação/regra real.
- **Bloqueio de Over-Engineering:** Se o pedido tiver complexidade especulativa, pare antes de codar, emita um `Alerta YAGNI/KISS/SINE` e proponha a alternativa direta.
