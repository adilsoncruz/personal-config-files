# Skill: Feature & Fix Interviewer

## Gatilho
Ative esta skill quando o usuário pedir para "criar uma nova feature", "novo fix", "nova task" ou iniciar um novo escopo de trabalho.

## Instruções de Execução
1. **Entrevista Ativa:** Não comece a programar imediatamente. Faça perguntas curtas e diretas (estilo `/grill-me`) para descobrir:
   - Qual o objetivo principal de negócio ou o bug exato?
   - Quais são os critérios de aceite esperados?
   - Quais arquivos ou sistemas serão afetados?
2. **Resumo:** Após coletar as respostas, gere um resumo claro do plano de ação.
3. **Criação de Ticket:** Utilize a ferramenta/MCP conectada (GitHub Issues ou Jira) para criar o ticket com o título, descrição detalhada e critérios de aceite.
4. **Isolamento:** Crie a Git worktree/branch usando o ID do ticket gerado (ex: `feat/PROJ-123-descricao`).
